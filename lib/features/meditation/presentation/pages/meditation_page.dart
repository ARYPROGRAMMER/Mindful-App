import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:mental_health/features/auth/domain/entities/auth/googleapisignin.dart';
import 'package:mental_health/features/meditation/presentation/bloc/dailyQuote/daily_quote_bloc.dart';
import 'package:mental_health/features/meditation/presentation/bloc/dailyQuote/daily_quote_event.dart';
import 'package:mental_health/features/meditation/presentation/bloc/dailyQuote/daily_quote_state.dart';
import 'package:mental_health/features/meditation/presentation/bloc/mood_data/mood_data_bloc.dart';
import 'package:mental_health/features/meditation/presentation/bloc/mood_data/mood_data_state.dart';
import 'package:mental_health/features/meditation/presentation/bloc/mood_message/mood_message_bloc.dart';
import 'package:mental_health/features/meditation/presentation/bloc/mood_message/mood_message_event.dart';
import 'package:mental_health/features/meditation/presentation/bloc/mood_message/mood_message_state.dart';
import 'package:mental_health/features/meditation/presentation/widgets/moods.dart';
import 'package:mental_health/features/meditation/presentation/widgets/task_card.dart';
import 'package:mental_health/presentation/chat_screen/chat_with_ai.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/theme.dart';

class MeditationPage extends StatefulWidget {
  const MeditationPage({super.key});

  @override
  State<MeditationPage> createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  TooltipBehavior? _tooltipBehavior;
  List<ChartSampleData>? dataSources;
  List<CircularChartAnnotation>? _annotationSources;
  List<Color>? colors;
  late GoogleSignInAccount? user2;
  late User? user1;
  List<ChartSampleData>? __chartData;
  TooltipBehavior? __tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, format: 'point.x : point.y%');
    __tooltipBehavior = _tooltipBehavior;

    _annotationSources = <CircularChartAnnotation>[
      CircularChartAnnotation(
        widget: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: SizedBox(
            height: 20,
            child: LottieBuilder.network(
                'https://lottie.host/b4a596fb-3b74-403a-ba62-94e56dd1662c/n0wCMuhZKw.json'),
          ),
        ),
      ),
      CircularChartAnnotation(
        widget: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: SizedBox(
            height: 60,
            child: LottieBuilder.network(
                'https://lottie.host/40e7eb6f-1461-4074-b9e6-836c2f59bab3/PB53CLQJwY.json'),
          ),
        ),
      ),
      CircularChartAnnotation(
        widget: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: SizedBox(
            height: 60,
            child: LottieBuilder.network(
                'https://lottie.host/3462abf3-a8a4-4deb-bda8-9457dbba7856/mpGSZCUNdL.json'),
          ),
        ),
      ),
      CircularChartAnnotation(
        widget: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: SizedBox(
            height: 60,
            child: LottieBuilder.network(
                'https://lottie.host/eb85b992-d67e-4308-b566-56b70863528e/pvJy8nX9UM.json'),
          ),
        ),
      ),
      CircularChartAnnotation(
        widget: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: SizedBox(
            height: 60,
            child: LottieBuilder.network(
                'https://lottie.host/5d81afcc-21d6-4395-82f9-b3245bfbdfcd/Tx797g2kdJ.json'),
          ),
        ),
      ),
      CircularChartAnnotation(
        widget: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: SizedBox(
            height: 60,
            child: LottieBuilder.network(
                'https://lottie.host/ec761808-ad04-4b8e-910e-f97234c4d6c6/k1f6uaivUR.json'),
          ),
        ),
      ),
    ];
    colors = const <Color>[
      Color.fromRGBO(69, 186, 161, 1.0),
      Color.fromRGBO(230, 135, 111, 1.0),
      Color.fromRGBO(145, 132, 202, 1.0),
      Color.fromRGBO(235, 96, 143, 1.0),
      Color.fromRGBO(20, 65, 92, 1.0),
      Color.fromRGBO(100, 20, 143, 1.0)
    ];

    super.initState();
  }

  SfCircularChart _buildCustomizedRadialBarChart() {
    dataSources = <ChartSampleData>[
      ChartSampleData(
          x: 'Happy',
          y: 0.20,
          text: '10%',
          pointColor: const Color.fromRGBO(69, 186, 161, 1.0)),
      ChartSampleData(
          x: 'Neutral',
          y: 0.50,
          text: '10%',
          pointColor: const Color.fromRGBO(230, 135, 111, 1.0)),
      ChartSampleData(
          x: 'Sad',
          y: 0.6,
          text: '100%',
          pointColor: const Color.fromRGBO(145, 132, 202, 1.0)),
      ChartSampleData(
          x: 'Calm',
          y: 0.1,
          text: '100%',
          pointColor: const Color.fromRGBO(145, 132, 202, 1.0)),
      ChartSampleData(
          x: 'Relax',
          y: 0.9,
          text: '100%',
          pointColor: const Color.fromRGBO(145, 132, 202, 1.0)),
      ChartSampleData(
          x: 'Focus',
          y: 0.8,
          text: '100%',
          pointColor: const Color.fromRGBO(235, 96, 143, 1.0))
    ];
    return SfCircularChart(
      title: const ChartTitle(text: 'Scroll Sideways for details'),
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.scroll,
        legendItemBuilder:
            (String name, dynamic series, dynamic point, int index) {
          return Column(children: [
            Row(children: <Widget>[
              SizedBox(
                  height: 55,
                  width: 65,
                  child: SfCircularChart(
                    annotations: <CircularChartAnnotation>[
                      _annotationSources![index],
                    ],
                    series: <RadialBarSeries<ChartSampleData, String>>[
                      RadialBarSeries<ChartSampleData, String>(
                          animationDuration: 0,
                          dataSource: <ChartSampleData>[dataSources![index]],
                          maximumValue: 100,
                          radius: '100%',
                          cornerStyle: CornerStyle.bothCurve,
                          xValueMapper: (ChartSampleData data, _) =>
                              point.x as String,
                          yValueMapper: (ChartSampleData data, _) => data.y,
                          pointColorMapper: (ChartSampleData data, _) =>
                              data.pointColor,
                          innerRadius: '70%',
                          pointRadiusMapper: (ChartSampleData data, _) =>
                              data.text),
                    ],
                  )),
            ]),
            SizedBox(
                width: 72,
                child: Text(
                  point.x,
                  style: TextStyle(
                      fontSize: 20,
                      color: colors![index],
                      fontWeight: FontWeight.bold),
                )),
          ]);
        },
      ),
      series: _getRadialBarCustomizedSeries(),
      tooltipBehavior: _tooltipBehavior,
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
          height: '90%',
          width: '90%',
          widget: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CircleAvatar(
              backgroundImage: user1 != null
                  ? (user1?.photoURL != null
                      ? NetworkImage(user1!.photoURL!)
                      : const NetworkImage(
                          "https://pbs.twimg.com/media/F3tVQbJWUAEOXJB.jpg:large"))
                  : user2!.photoUrl != null
                      ? NetworkImage(user2!.photoUrl!)
                      : const NetworkImage(
                          "https://pbs.twimg.com/media/F3tVQbJWUAEOXJB.jpg:large"),
            ),
          ),
        ),
      ],
    );
  }

  List<RadialBarSeries<ChartSampleData, String>>
      _getRadialBarCustomizedSeries() {
    return <RadialBarSeries<ChartSampleData, String>>[
      RadialBarSeries<ChartSampleData, String>(
        animationDuration: 20,
        maximumValue: 100,
        gap: '10%',
        radius: '100%',
        dataSource: <ChartSampleData>[
          ChartSampleData(
              x: 'Happy',
              y: 62.70,
              text: '100%',
              pointColor: const Color.fromRGBO(69, 186, 161, 1.0)),
          ChartSampleData(
              x: 'Neutral',
              y: 29.20,
              text: '100%',
              pointColor: const Color.fromRGBO(230, 135, 111, 1.0)),
          ChartSampleData(
              x: 'Sad',
              y: 85.20,
              text: '100%',
              pointColor: const Color.fromRGBO(145, 132, 202, 1.0)),
          ChartSampleData(
              x: 'Calm',
              y: 45.70,
              text: '100%',
              pointColor: const Color.fromRGBO(235, 96, 143, 1.0)),
          ChartSampleData(
              x: 'Relax',
              y: 45.70,
              text: '100%',
              pointColor: const Color.fromRGBO(235, 96, 143, 1.0)),
          ChartSampleData(
              x: 'Focus',
              y: 45.70,
              text: '100%',
              pointColor: const Color.fromRGBO(235, 96, 143, 1.0)),
        ],
        cornerStyle: CornerStyle.bothCurve,
        xValueMapper: (ChartSampleData data, _) => data.x as String,
        yValueMapper: (ChartSampleData data, _) => data.y,
        pointRadiusMapper: (ChartSampleData data, _) => data.text,
        pointColorMapper: (ChartSampleData data, _) => data.pointColor,
        legendIconType: LegendIconType.circle,
      ),
    ];
  }

  List<ColumnSeries<ChartSampleData, String>> _getDefaultColumn() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
          width: 0.8,
          spacing: 0.2,
          dataSource: __chartData,
          color: const Color.fromRGBO(251, 193, 55, 1),
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: 'Neutral'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: __chartData,
          width: 0.8,
          spacing: 0.2,
          color: const Color.fromRGBO(177, 183, 188, 1),
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Happy'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: __chartData,
          width: 0.8,
          spacing: 0.2,
          color: const Color.fromRGBO(140, 92, 69, 1),
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.thirdSeriesYValue,
          name: 'Sad')
    ];
  }

  SfCartesianChart _buildColumnChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 1,
      title: const ChartTitle(text: 'Top 3 Mood Chart'),
      primaryXAxis: const CategoryAxis(
        title: AxisTitle(text: "Days"),
      ),
      primaryYAxis: const NumericAxis(
          title: AxisTitle(text: "# of Times"),
          maximum: 20,
          minimum: 0,
          interval: 4,
          axisLine: AxisLine(width: 1),
          majorTickLines: MajorTickLines(size: 1)),
      series: _getDefaultColumn(),
      legend: const Legend(isVisible: true),
      tooltipBehavior: __tooltipBehavior,
    );
  }

  @override
  void dispose() {
    try {
      dataSources!.clear();
      __chartData!.clear();
      _annotationSources!.clear();
    } catch (error) {}

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    user1 = FirebaseAuth.instance.currentUser;
    user2 = GoogleSignInApi.details();
    final mybox = Hive.box('firstime');
    String valobatained = mybox.get('firsttime');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: DefaultColors.white,
        centerTitle: true,
        title: const Text(
          "Dashboard",
          style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 't3',
              letterSpacing: 1),
        ),
        elevation: 10,
        shadowColor: Colors.black,
        leading: Image.asset(
          'assets/menu_burger.png',
        ),
        actions: [
          GestureDetector(
            onTap: () => showDialog(
                barrierColor: Colors.white.withOpacity(0.2),
                builder: (context) => BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 1, sigmaX: 2),
                      child: AlertDialog(
                          elevation: 20,
                          shadowColor: Colors.black,
                          icon: const Icon(
                            Icons.auto_graph_sharp,
                            color: Colors.black,
                            size: 30,
                          ),
                          title: user1 != null
                              ? (user1?.displayName != null
                                  ? Center(
                                      child: Text(
                                        "${user1?.displayName}'s stats",
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        "User stats",
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                    ))
                              : Center(
                                  child: Text(
                                    "${user2?.displayName} stats",
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                          content: SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width + 300,
                              child: _buildCustomizedRadialBarChart())),
                    ),
                context: context),
            child: CircleAvatar(
              backgroundImage: user1 != null
                  ? (user1?.photoURL != null
                      ? NetworkImage(user1!.photoURL!)
                      : const NetworkImage(
                          "https://pbs.twimg.com/media/F3tVQbJWUAEOXJB.jpg:large"))
                  : user2!.photoUrl != null
                      ? NetworkImage(user2!.photoUrl!)
                      : const NetworkImage(
                          "https://pbs.twimg.com/media/F3tVQbJWUAEOXJB.jpg:large"),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: user1 != null
                        ? user1?.displayName != null
                            ? Text(
                                "Welcome Back, ${user1?.displayName}",
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                                style: Theme.of(context).textTheme.titleLarge,
                              )
                            : Text(
                                "Welcome Back, User",
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                                style: Theme.of(context).textTheme.titleLarge,
                              )
                        : Text(
                            "Welcome Back, ${user2?.displayName}",
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const ChatScreen()));
                        },
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: LottieBuilder.network(
                              "https://lottie.host/7f8fdd94-95c4-4a11-90bb-edc15af41005/jVxlzL8zAW.json"),
                          // decoration: const BoxDecoration(
                          //     image: DecorationImage(
                          //         image: AssetImage('assets/bot_ai.png'))),
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "How are you feeling today ?",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MoodButton(
                      label: "Happy",
                      path:
                          'https://lottie.host/b4a596fb-3b74-403a-ba62-94e56dd1662c/n0wCMuhZKw.json',
                      onTap: () {
                        context
                            .read<MoodMessageBloc>()
                            .add(FetchMoodMessage('happy'));
                      }),
                  MoodButton(
                      label: "Neutral",
                      path:
                          'https://lottie.host/40e7eb6f-1461-4074-b9e6-836c2f59bab3/PB53CLQJwY.json',
                      onTap: () {
                        context
                            .read<MoodMessageBloc>()
                            .add(FetchMoodMessage('neutral'));
                      }),
                  MoodButton(
                      label: "Sad",
                      path:
                          'https://lottie.host/3462abf3-a8a4-4deb-bda8-9457dbba7856/mpGSZCUNdL.json',
                      onTap: () {
                        context
                            .read<MoodMessageBloc>()
                            .add(FetchMoodMessage('sad'));
                      }),
                  MoodButton(
                      label: "Calm",
                      path:
                          'https://lottie.host/eb85b992-d67e-4308-b566-56b70863528e/pvJy8nX9UM.json',
                      onTap: () {
                        context
                            .read<MoodMessageBloc>()
                            .add(FetchMoodMessage('calm'));
                      }),
                  MoodButton(
                      label: "Relax",
                      path:
                          'https://lottie.host/5d81afcc-21d6-4395-82f9-b3245bfbdfcd/Tx797g2kdJ.json',
                      onTap: () {
                        context
                            .read<MoodMessageBloc>()
                            .add(FetchMoodMessage('relax'));
                      }),
                  MoodButton(
                      label: "Focus",
                      path:
                          'https://lottie.host/ec761808-ad04-4b8e-910e-f97234c4d6c6/k1f6uaivUR.json',
                      onTap: () {
                        context
                            .read<MoodMessageBloc>()
                            .add(FetchMoodMessage('focus'));
                      }),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              BlocBuilder<DailyQuoteBloc, DailyQuoteState>(
                  builder: (context, state) {
                if (state is DailyQuoteLoading) {
                  return Center(
                    child: SizedBox(
                        height: 100,
                        child: LottieBuilder.network(
                            "https://lottie.host/65bd2e51-261e-4712-a5bd-38451aac4977/viHIqd4hxU.json")),
                  );
                } else if (state is DailyQuoteLoaded) {
                  final int h = DateTime.now().hour;

                  if (0 <= h && h <= 12) {
                    return TaskCard(
                        title: "A Very Good Morning",
                        description: state.dailyQuote.morningQuote,
                        color: DefaultColors.task1);
                  } else if (12 <= h && h <= 17) {
                    return TaskCard(
                        title: "Good Afternoon",
                        description: state.dailyQuote.noonQuote,
                        color: DefaultColors.task2);
                  } else {
                    return TaskCard(
                        title: "Good Evening",
                        description: state.dailyQuote.eveningQuote,
                        color: DefaultColors.task3);
                  }
                } else if (state is DailyQuoteError) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                            height: 100,
                            child: LottieBuilder.network(
                                "https://lottie.host/628ae316-ce58-4c02-a205-d29fe845a04a/DsXepW48Af.json")),
                        Text(
                            "Please Check Server Connection and Refresh (Errorx01)",
                            style: Theme.of(context).textTheme.labelSmall),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                            height: 100,
                            child: LottieBuilder.network(
                                "https://lottie.host/fc2bc940-1d88-4ea2-8d5d-791e6480760e/4oA0NKLXn3.json")),
                        Text("Please Refresh (Errorx02)",
                            style: Theme.of(context).textTheme.labelSmall),
                      ],
                    ),
                  );
                }
              }),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today's status",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        context.read<DailyQuoteBloc>().add(FetchDailyQuote());
                      },
                      icon: const Icon(
                        Icons.refresh_rounded,
                        color: DefaultColors.orange,
                      ))
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey.shade100.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                          border: const Border(
                              bottom: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black))),
                      height: 200,
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.apple,
                                  size: 60,
                                ),
                                // SizedBox(width: MediaQuery.of(context).size.width/60),
                                SizedBox(width: 1),
                                Text(
                                  "Food",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 32),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "1185 of 2400 cals consumed",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                            //progres bar
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey.shade100.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                          border: const Border(
                              bottom: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black))),
                      height: 200,
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.water_drop_outlined,
                                  size: 50,
                                ),
                                SizedBox(width: 1),
                                Text(
                                  "Water",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 32),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "You drank 4 glasses of water out of 6",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                            //progres bar
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.lightBlue.shade100.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: const Border(
                        bottom: BorderSide(color: Colors.black),
                        top: BorderSide(color: Colors.black),
                        left: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black))),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.face,
                            size: 30,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Overall Health Analysis",
                            style: TextStyle(color: Colors.black, fontSize: 30),
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      "The total overall mood is happy 75% times",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    //graph
                    valobatained == 'true'
                        ? const SizedBox(
                            height: 50,
                            child: Text(
                              "No data",
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : BlocBuilder<MoodDataBloc, MoodDataState>(
                            builder: (context, state) {
                            if (state is MoodDataLoaded) {
                              __chartData = <ChartSampleData>[
                                ChartSampleData(
                                    x: 'Mon',
                                    y: num.parse(state.moodDatainfo.happy),
                                    secondSeriesYValue:
                                        num.parse(state.moodDatainfo.neutral),
                                    thirdSeriesYValue:
                                        num.parse(state.moodDatainfo.calm)),
                                ChartSampleData(
                                    x: 'Tue',
                                    y: num.parse(state.moodDatainfo.happy),
                                    secondSeriesYValue:
                                        num.parse(state.moodDatainfo.neutral),
                                    thirdSeriesYValue:
                                        num.parse(state.moodDatainfo.calm)),
                                ChartSampleData(
                                    x: 'Wed',
                                    y: num.parse(state.moodDatainfo.happy),
                                    secondSeriesYValue:
                                        num.parse(state.moodDatainfo.neutral),
                                    thirdSeriesYValue:
                                        num.parse(state.moodDatainfo.calm)),
                                ChartSampleData(
                                    x: 'Thurs',
                                    y: num.parse(state.moodDatainfo.happy),
                                    secondSeriesYValue:
                                        num.parse(state.moodDatainfo.neutral),
                                    thirdSeriesYValue:
                                        num.parse(state.moodDatainfo.calm)),
                                ChartSampleData(
                                    x: 'Fri',
                                    y: num.parse(state.moodDatainfo.happy),
                                    secondSeriesYValue:
                                        num.parse(state.moodDatainfo.neutral),
                                    thirdSeriesYValue:
                                        num.parse(state.moodDatainfo.calm)),
                                ChartSampleData(
                                    x: 'Sat',
                                    y: num.parse(state.moodDatainfo.happy),
                                    secondSeriesYValue:
                                        num.parse(state.moodDatainfo.neutral),
                                    thirdSeriesYValue:
                                        num.parse(state.moodDatainfo.calm)),
                                ChartSampleData(
                                    x: 'Sun',
                                    y: num.parse(state.moodDatainfo.happy),
                                    secondSeriesYValue:
                                        num.parse(state.moodDatainfo.neutral),
                                    thirdSeriesYValue:
                                        num.parse(state.moodDatainfo.calm)),
                              ];

                              num total = num.parse(state.moodDatainfo.happy) +
                                  num.parse(state.moodDatainfo.neutral) +
                                  num.parse(state.moodDatainfo.sad) +
                                  num.parse(state.moodDatainfo.calm) +
                                  num.parse(state.moodDatainfo.relax) +
                                  num.parse(state.moodDatainfo.focus);
                              dataSources = <ChartSampleData>[
                                ChartSampleData(
                                    x: 'Happy',
                                    y: num.parse(state.moodDatainfo.happy) /
                                        total,
                                    text: '10%',
                                    pointColor: const Color.fromRGBO(
                                        69, 186, 161, 1.0)),
                                ChartSampleData(
                                    x: 'Neutral',
                                    y: num.parse(state.moodDatainfo.neutral) /
                                        total,
                                    text: '10%',
                                    pointColor: const Color.fromRGBO(
                                        230, 135, 111, 1.0)),
                                ChartSampleData(
                                    x: 'Sad',
                                    y: num.parse(state.moodDatainfo.sad) /
                                        total,
                                    text: '100%',
                                    pointColor: const Color.fromRGBO(
                                        145, 132, 202, 1.0)),
                                ChartSampleData(
                                    x: 'Calm',
                                    y: num.parse(state.moodDatainfo.calm) /
                                        total,
                                    text: '100%',
                                    pointColor: const Color.fromRGBO(
                                        145, 132, 202, 1.0)),
                                ChartSampleData(
                                    x: 'Relax',
                                    y: num.parse(state.moodDatainfo.relax) /
                                        total,
                                    text: '100%',
                                    pointColor: const Color.fromRGBO(
                                        145, 132, 202, 1.0)),
                                ChartSampleData(
                                    x: 'Focus',
                                    y: num.parse(state.moodDatainfo.focus) /
                                        total,
                                    text: '100%',
                                    pointColor:
                                        const Color.fromRGBO(235, 96, 143, 1.0))
                              ];
                              try {
                                return _buildColumnChart();
                              } catch (error) {
                                return const Text("ERROR LOADING");
                              }
                            }
                            if (state is MoodDataLoading) {
                              return const Text("loading");
                            }

                            if (state is MoodDataError) {
                              return const Text(
                                "No Data Found",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              );
                            }
                            return const SizedBox(
                              height: 50,
                              child: Text(
                                "No data",
                                style: TextStyle(color: Colors.red),
                              ),
                            );
                          })
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              BlocBuilder<MoodMessageBloc, MoodMessageState>(
                builder: (context, state) {
                  if (state is MoodMessageLoaded) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                          barrierDismissible: false,
                          barrierColor: Colors.blueGrey.withOpacity(0.6),
                          context: context,
                          builder: (context) => AlertDialog(
                                elevation: 30,
                                shadowColor: Colors.blueGrey,
                                title: Text(
                                  'Advice for your Mood',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                content: Text(state.moodMessage.text,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            fontSize: 18, color: Colors.black)),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        context
                                            .read<MoodMessageBloc>()
                                            .add(ResetMoodMessage());
                                      },
                                      child: const Text(
                                        "Thanks",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.greenAccent),
                                      ))
                                ],
                              ));
                    });
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}
