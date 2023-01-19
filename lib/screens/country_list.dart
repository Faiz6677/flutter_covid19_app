import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_covid19_app/services/state_services.dart';
import 'package:http/http.dart' as http;

import 'detail_screen.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({Key? key}) : super(key: key);

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchController,
              decoration: InputDecoration(
                  hintText: 'search country',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Expanded(
                child: FutureBuilder(
              future: stateServices.getCountryListApi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        if (searchController.text.isEmpty) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return DetailScreen(
                                  name:
                                      snapshot.data![index].country.toString(),
                                  image: snapshot.data![index].countryInfo!.flag
                                      .toString(),
                                  totalCase:
                                      snapshot.data![index].cases.toString(),
                                  active:
                                      snapshot.data![index].active.toString(),
                                  critical:
                                      snapshot.data![index].critical.toString(),
                                  test: snapshot.data![index].tests.toString(),
                                  todayRecovered: snapshot
                                      .data![index].todayRecovered
                                      .toString(),
                                  totalDeaths: snapshot.data![index].todayDeaths
                                      .toString(),
                                  totalRecovered: snapshot
                                      .data![index].recovered
                                      .toString(),
                                );
                              }));
                            },
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(10),
                              leading: Image.network(
                                snapshot.data![index].countryInfo!.flag
                                    .toString(),
                                height: 100,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                  snapshot.data![index].country.toString()),
                              subtitle: Text(
                                  'Recovered ${snapshot.data![index].recovered.toString()}'),
                              trailing: Text(
                                  'Deaths ${snapshot.data![index].todayDeaths.toString()}'),
                            ),
                          );
                        } else if (snapshot.data![index].country
                            .toString()
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return DetailScreen(
                                  name:
                                      snapshot.data![index].country.toString(),
                                  image: snapshot.data![index].countryInfo!.flag
                                      .toString(),
                                  totalCase:
                                      snapshot.data![index].cases.toString(),
                                  active:
                                      snapshot.data![index].active.toString(),
                                  critical:
                                      snapshot.data![index].critical.toString(),
                                  test: snapshot.data![index].tests.toString(),
                                  todayRecovered: snapshot
                                      .data![index].todayRecovered
                                      .toString(),
                                  totalDeaths: snapshot.data![index].todayDeaths
                                      .toString(),
                                  totalRecovered: snapshot
                                      .data![index].recovered
                                      .toString(),
                                );
                              }));
                            },
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(10),
                              leading: Image.network(
                                snapshot.data![index].countryInfo!.flag
                                    .toString(),
                                height: 100,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                  snapshot.data![index].country.toString()),
                              subtitle: Text(
                                  'Recovered ${snapshot.data![index].recovered.toString()}'),
                              trailing: Text(
                                  'Deaths ${snapshot.data![index].todayDeaths.toString()}'),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      });
                } else {
                  return Center(
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade100,
                        highlightColor: Colors.grey.shade700,
                        child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return ListTile(
                                contentPadding: const EdgeInsets.all(10),
                                leading: Container(
                                  color: Colors.white,
                                  width: 70,
                                  height: 100,
                                ),
                                title: Container(
                                  height: 10,
                                  width: 20,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 5.0,
                                  width: 0.05,
                                  color: Colors.white,
                                ),
                                trailing: Container(
                                  height: 10,
                                  width: 20,
                                  color: Colors.white,
                                ),
                              );
                            })),
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
