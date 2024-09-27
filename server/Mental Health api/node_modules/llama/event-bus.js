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

export class SimpleEventBus {
  /**
   * A simple event bus to enable event-driven architecture
   * @param {Object} options optional parameters
   * @param {string} [options.name] define a name, in a multi EventBus scenario
   * @param {(e:Error) => {}} [options.catcher] define an error catching function
   * @param {Console} [options.logger] define a logger, can be {logger: console} to send on the javascript console
   */
  constructor (options = {}) {
    this._hook = new Map()
    this.name = options?.name || 'emit'
    this.catcher = options?.catcher
    this.logger = options?.logger
  }

  /**
   * Attach an event listener for a source
   * @param {string} s name of the source of the listener
   * @param {string|string[]} e the event(s) key(s) to attach the listener
   * @param {(...r) => {}} f the listener function
   */
  on (s, e, f) {
    if (this.logger && (!this.logger?.logFor || this.logger?.logFor('on'))) this.logger.debug(`EventBus.on<${this.name}>: %s / %s`, s, e /*, f.toString() */)
    const l = (e instanceof Array) ? e : [e]
    l.forEach((k) => {
      let d = this._hook.get(k)
      if (!d) {
        d = {}
        this._hook.set(k, d)
      }
      d[s] = f
    })
  }

  /**
   * Emit an event for a given key that are sent to every attached events listeners
   * @param {string} k the event key
   * @param  {...any} p the optional args
   */
  emit (k, ...p) {
    if (this.logger && (!this.logger?.logFor || this.logger?.logFor(this.name))) this.logger.debug(`EventBus.emit<${this.name}>: %s`, k, ...p)
    setTimeout(() => {
      try {
        this._run(k, p)
      } catch (error) {
        if (this.catcher) this.catcher(error, this.name)
        else throw error
      }
    }, 1)
  }

  _run (k, p) {
    const handlers = this._hook.get(k)
    if (handlers) {
      Object.entries(handlers).forEach(([s, f]) => {
        if (this.logger && (!this.logger?.logFor || this.logger?.logFor(this.name))) this.logger.debug(`EventBus.emit<${this.name}>: %s to %s`, k, s)
        f(...p)
      })
    }
  }

  /**
   * Clear event listeners for a source
   * @param {string} s the name of the source to clear events for
   * @param {(k:string)=> boolean} [filter] filter the keys that should be cleared (return true for keys to be cleared)
   */
  clear (s, filter = () => true) {
    if (this.logger && (!this.logger?.logFor || this.logger?.logFor('clear'))) this.logger.debug(`EventBus.clear<${this.name}>: %s`, s)
    for (const [k, d] of this._hook.entries()) { if ((s in d) && filter(k)) delete d[s] }
  }
}

export class SequenceHandlerLoader {
  constructor (sqEventBus, src, evt) {
    Object.assign(this, { sqEventBus, src, evt })
  }

  before (f) {
    this.sqEventBus._before.on(this.src, this.evt, f)
    return this
  }

  do (f) {
    this.sqEventBus._emit.on(this.src, this.evt, f)
    return this
  }

  after (f) {
    this.sqEventBus._after.on(this.src, this.evt, f)
    return this
  }
}

export class SequenceEventBus {
  /**
   * A simple event bus to enable event-driven architecture
   * @param {Object} options optional parameters
   * @param {(e:Error, ...r) => {}} [options.catcher] define an error catching function
   * @param {Console} [options.logger] define a logger, can be {logger: console} to send on the javascript console
   */
  constructor (options = {}) {
    this._before = new SimpleEventBus({ name: 'before', catcher: options?.catcher, logger: options?.logger })
    this._emit = new SimpleEventBus({ name: 'emit', catcher: options?.catcher, logger: options?.logger })
    this._after = new SimpleEventBus({ name: 'after', catcher: options?.catcher, logger: options?.logger })
  }

  /**
   * Attach an event listener for a source
   * @param {string} s name of the source of the listener
   * @param {string|string[]} e the event(s) key(s) to attach the listener
   * @param {(...r) => {}} [f] the listener function
   */
  on (s, e, f) {
    if (f) this._emit.on(s, e, f)
    return new SequenceHandlerLoader(this, s, e)
  }

  /**
   * Emit an event for a given key that are sent to every attached events listeners
   * @param {string} k the event key
   * @param  {...any} p the optional args
   */
  emit (k, ...p) {
    if (this.logger && (!this.logger?.logFor || this.logger?.logFor('emit'))) this.logger.debug('EventBus.emit: %s', k, ...p)
    setTimeout(() => {
      this._before._run(k, p)
      this._emit._run(k, p)
      this._after._run(k, p)
    }, 1)
  }

  /**
   * Clear event listeners for a source
   * @param {string} s the name of the source to clear events for
   * @param {(k:string)=> boolean} [filter] filter the keys that should be cleared (return true for keys to be cleared)
   */
  clear (s, filter = () => true) {
    if (this.logger && (!this.logger?.logFor || this.logger?.logFor('clear'))) this.logger.debug('EventBus.clear: %s', s)
    this._before.clear(s, filter)
    this._emit.clear(s, filter)
    this._after.clear(s, filter)
  }
}

const EventBus = SequenceEventBus

export default EventBus
