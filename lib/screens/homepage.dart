import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hpb/models/covid_data_model.dart';
import 'package:hpb/models/pcr_model.dart';

import '../components/custom_container.dart';
import '../services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService service = ApiService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: service.getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              CovidDataModel data = snapshot.data!;
              List<PcrData> pcrDataList = data.pcrData!;
              //Map<String, dynamic> data = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.menu),
                        Text(
                          "Covid 19",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                        Icon(Icons.add_location)
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomContainer(
                          size: size,
                          title: 'Total Deaths',
                          value: data.totalDeaths!,
                          color: Colors.red,
                        ),
                        CustomContainer(
                          size: size,
                          title: 'Total Recovered',
                          value: data.totalRecovered!,
                          color: Colors.green,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomContainer(
                          size: size,
                          title: 'Active Cases',
                          value: data.activeCases!,
                          color: Colors.blue,
                        ),
                        CustomContainer(
                          size: size,
                          title: 'Total Cases',
                          value: data.totalCases!,
                          color: Colors.amber.shade600,
                        ),
                      ],
                    ),
                    const Text(
                      "Daily Pcr Test",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: pcrDataList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                pcrDataList[index].date.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                pcrDataList[index].count.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            }
            return const Center(child: CupertinoActivityIndicator());
          },
        ),
      ),
    );
  }
}
