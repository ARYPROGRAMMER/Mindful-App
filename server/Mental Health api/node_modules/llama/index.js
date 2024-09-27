/*
 * Copyright 2022 Nicolas Lochet Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License is
 * distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and limitations under the License.
 */

import Component, { HostComponent } from './component.js'
import EventBus from './event-bus.js'
import Router from './router.js'

export {
  Component, HostComponent, EventBus, Router
}

/**
 * @typedef {Object} RouteTarget
 * @property {typeof Component} [type]
 * @property {string} [name] name of the component to serve as source for event listeners
 * @property {string} [box] the id of an HTML element the component is rendered into
 * @property {string} [sub_box] the id of an HTML element the embedded sub-component are rendered into
 * @property {string|(args: object, path: string, this:Component)=>{}} [html] a string or a function that produce a html to be injected before init
 * @property {string} [css] a string of CSS to be injected
 * @property {(args: object, path: string)=>{}} [onLoad] a hook for action on load of the component
 * @property {(args: object, path: string)=>{}} [onPostLoad] a hook for action after load of the component
 * @property {()=>{}} [onBeforeClean] a hook for action on load of the component
 * @property {()=>{}} [onAfterClean] a hook for action on load of the component
 * @property {Console} [logger] define a logger, can be {logger: console} to send on the javascript console
 * @property {Object.<string, RouteTarget>} embed embedded route
 */

/**
 * Set all the Llama goodness together
 *
 * @param {Object} options
 * @param {string} [options.box] the id of the div we load components in
 * @param {EventBus} [options.eventBus]
 * @param {Object} [options.context]
 * @param {Object.<string, typeof Component|RouteTarget>} options.routes
 * @param {Console} [options.logger] define a logger, can be {logger: console} to send on the javascript console
 */
export default function llama (options) {
  return new LlamaConfig(options).buildRouter()
}

export class LlamaConfig {
  /**
   * @param {Object} options
   * @param {string} [options.box] the id of the div we load components in
   * @param {EventBus} [options.eventBus]
   * @param {Object} [options.context]
   * @param {Object.<string, typeof Component|RouteTarget>} options.routes
   * @param {Console} [options.logger] define a logger, can be {logger: console} to send on the javascript console
   */
  constructor (options) {
    if (!('routes' in options)) throw new Error('options.routes is compulsory')

    this.routes = options.routes

    this.context = options?.context || {}

    this.box = options?.box || 'app'
    this.eventBus = options?.eventBus || new EventBus()
    this.logger = options?.logger

    this.options = options
  }

  buildRouter () {
    const router = new Router(this.eventBus, this.addLogger())

    for (const [path, Target] of Object.entries(this.routes)) {
      if (typeof Target === 'object') {
        const Type = Target.type || (!('embed' in Target) ? Component : HostComponent)
        const opt = this.targetOpt(Target)

        if (this.logger) this.logger.debug(`adding root component ${path}`)

        const component = new Type(opt)
        if (('embed' in Target) && !(component instanceof HostComponent)) throw new Error('llama.host.component.must.be.type.HostComponent')

        router.on(path, component)

        if ('embed' in Target) {
          const recOpt = Object.assign(this.basicOpts(), this.extractFieldIfExists(Target, 'sub_box'), this.addLogger({ o: opt }))

          const subRoute = this.recBuildEmbedded(path, Target.embed, recOpt)
          component.setSubRoute(subRoute)
          for (const p of this.flattenSubRoute(subRoute)) {
            router.on(p, component)
          }
        }
      } else {
        if (this.logger) this.logger.debug(`adding root component ${path}`)
        router.on(path, new Target(this.targetOpt({})))
      }
    }

    return router
  }

  recBuildEmbedded (path, embed, opt) {
    const res = {}
    for (const [p, T] of Object.entries(embed)) {
      const subPath = `${path}/${p}/`.replace(/\/{2,}/g, '/')

      if (this.logger) this.logger.debug(`adding sub component ${subPath}`)
      const box = T.box || opt.sub_box || 'sub'
      const eventBus = opt.eventBus
      const context = opt.context

      if (typeof T === 'object') {
        const subOpt = this.targetOpt(T, opt, { box, eventBus, context })

        const Type = T.type || (!('embed' in T) ? Component : HostComponent)
        const component = new Type(subOpt)

        if ('embed' in T) {
          if (!(component instanceof HostComponent)) throw new Error('llama.host.component.must.be.type.HostComponent')

          const recOpt = Object.assign(
            { box, eventBus, context },
            this.extractFieldIfExists(opt, 'sub_box'),
            this.extractFieldIfExists(T, 'sub_box'),
            this.addLogger({ o: subOpt })
          )

          const subRoute = this.recBuildEmbedded(subPath, T.embed, recOpt)
          component.setSubRoute(subRoute)
        }

        res[subPath] = component
      } else {
        const subOpt = this.targetOpt({}, opt, { box, eventBus, context })

        res[subPath] = new T(subOpt)
      }
    }
    return res
  }

  flattenSubRoute (subRoute, res = new Set()) {
    for (const [p, t] of Object.entries(subRoute)) {
      if (!(t instanceof HostComponent)) {
        res.add(p)
      } else {
        this.flattenSubRoute(t.getSubRoute(), res)
      }
    }
    return res
  }

  targetOpt (target, opt = this, altOpts = undefined) {
    return Object.assign({}, target, altOpts || this.basicOpts(), this.addLogger({ o: opt, cond: !('logger' in target) }))
  }

  basicOpts () {
    const { box, eventBus, context } = this
    return { box, eventBus, context }
  }

  addLogger ({ o = this, cond = true } = {}) {
    return this.extractFieldIfExists(o, 'logger', cond)
  }

  extractFieldIfExists (o, field, cond = true) {
    return (field in o) && o[field] && cond ? { [field]: o[field] } : {}
  }
}
