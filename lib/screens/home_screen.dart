import 'package:flutter/material.dart';
import 'package:flutter_covid19_app/models/WorldStateModel.dart';
import 'package:flutter_covid19_app/services/state_services.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import 'country_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: FutureBuilder(
            future: stateServices.getWorldStateModel(),
            builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.all(5.0),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: double.infinity,
                      child: PieChart(
                          colorList: colorList,
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          dataMap: {
                            'cases':
                                double.parse(snapshot.data!.cases.toString()),
                            'Recovered': double.parse(
                                snapshot.data!.recovered.toString()),
                            'Deaths':
                                double.parse(snapshot.data!.deaths.toString()),
                          }),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.all(5.0),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade900),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ItemRow(
                              title: 'Total',
                              value: snapshot.data!.cases.toString()),
                          ItemRow(
                              title: 'Death',
                              value: snapshot.data!.deaths.toString()),
                          ItemRow(
                              title: 'Recovered',
                              value: snapshot.data!.recovered.toString()),
                          ItemRow(
                              title: 'Active',
                              value: snapshot.data!.active.toString()),
                          ItemRow(
                              title: 'Critical',
                              value: snapshot.data!.critical.toString()),
                          ItemRow(
                              title: 'Today Death',
                              value: snapshot.data!.todayDeaths.toString()),
                          ItemRow(
                              title: 'Today Recovered',
                              value: snapshot.data!.todayRecovered.toString()),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.95,
                                  MediaQuery.of(context).size.height * 0.07),
                              backgroundColor: const Color(0xff1aa260)),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return CountryListScreen();
                            }));
                          },
                          child: Text(
                            'Country List',
                            style: Theme.of(context).textTheme.titleLarge,
                          )),
                    )
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}

class ItemRow extends StatelessWidget {
  final String title, value;

  const ItemRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(value, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        const Divider(
          thickness: 1,
        ),
      ],
    );
  }
}
