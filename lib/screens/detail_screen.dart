import 'package:flutter/material.dart';

import 'home_screen.dart';

class DetailScreen extends StatefulWidget {
  final String name, image;
  final String totalCase,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  const DetailScreen(
      {super.key,
      required this.name,
      required this.image,
      required this.totalCase,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.067),
                child: Container(

                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      ItemRow(
                        title: 'Total Cases',
                        value: widget.totalCase,
                      ),
                      ItemRow(title: 'Total Deaths', value: widget.totalDeaths),
                      ItemRow(
                          title: 'Total Recovered',
                          value: widget.totalRecovered),
                      ItemRow(
                        title: 'Critical',
                        value: widget.critical,
                      ),
                      ItemRow(title: 'active', value: widget.active),
                      ItemRow(title: 'tests', value: widget.test),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
