import 'package:blosso_mindfulness/bits/bits.dart';
import 'package:blosso_mindfulness/parts/parts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class GardenPage extends StatefulWidget {
  const GardenPage({super.key});

  @override
  GardenPageState createState() => GardenPageState();
}

class GardenPageState extends State<GardenPage> {
  DateTime currentMonth = DateTime.now();
  Random random = Random();
  Map<DateTime, bool> completedPrompts = {};

  DateTime getFirstDayOfWeekForWeek(int weekIndex, int year, int month) {
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    while (firstDayOfMonth.weekday != DateTime.monday) {
      firstDayOfMonth = firstDayOfMonth.subtract(const Duration(days: 1));
    }
    return firstDayOfMonth.add(Duration(days: 7 * weekIndex));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${DateFormat.MMMM().format(currentMonth)} ${currentMonth.year}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_left),
          onPressed: () {
            if (currentMonth.month > 1 || currentMonth.year > DateTime.now().year) {
              setState(() {
                currentMonth = DateTime(currentMonth.year, currentMonth.month - 1, 1);
              });
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_right),
            onPressed: () {
              if (currentMonth.month < DateTime.now().month || currentMonth.year < DateTime.now().year) {
                setState(() {
                  currentMonth = DateTime(currentMonth.year, currentMonth.month + 1, 1);
                });
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: getNumberOfWeeks(currentMonth.year, currentMonth.month),
        itemBuilder: (context, index) {
          int reverseIndex = getNumberOfWeeks(currentMonth.year, currentMonth.month) - 1 - index;
          DateTime firstDayOfWeek = getFirstDayOfWeekForWeek(reverseIndex, currentMonth.year, currentMonth.month);
          String formattedDate = "${firstDayOfWeek.month}-${firstDayOfWeek.day}";

          return Column(
            children: [
              InkWell(
                onTap: () async {
                  DateTime? selectedDate = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Choose a day for the week of $formattedDate'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(7, (idx) {
                            DateTime day = firstDayOfWeek.add(Duration(days: idx));
                            return ListTile(
                              title: Text('${DateFormat.EEEE().format(day)} ${day.day}'),
                              onTap: () => Navigator.pop(context, day),
                            );
                          }),
                        ),
                      );
                    },
                  );

                  if (selectedDate != null) {
                    bool entryExists = await checkIfEntryExists(selectedDate);
                    if (!entryExists) {
                      // Prompt user to complete the tracker for the selected day.
                      // Assume navigateToTracker is a function that navigates to the tracker screen and returns a boolean value indicating whether the tracker was completed.
                      bool completedTracker = await navigateToTracker(selectedDate);
                      if (completedTracker) {
                        setState(() {
                          completedPrompts[selectedDate] = true;
                        });
                      }
                    } else {
                      // Notify user that an entry already exists for this day.
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('An entry already exists for this date.'),
                        ),
                      );
                    }
                  }
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      color: Colors.green,
                      child: Center(child: Text('Week of $formattedDate')),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: index == 0 ? 250.0 : 150.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/Background/Background1.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ...generateFlowersForWeek(firstDayOfWeek),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<bool> checkIfEntryExists(DateTime date) async {
    // Implement the logic to check if an entry exists for the provided date.
    // Placeholder for actual implementation.
    // Return true if an entry exists, otherwise return false.
    return false;
  }

  Future<bool> navigateToTracker(DateTime date) async {
    // Navigate to the tracker screen and pass the selected date.
    // Placeholder for actual navigation implementation.
    // Return true if the tracker was completed, otherwise return false.
    return false;
  }

  int getNumberOfWeeks(int year, int month) {
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);
    return ((lastDayOfMonth.day + lastDayOfMonth.weekday - 1) / 7).ceil();
  }

  List<Widget> generateFlowersForWeek(DateTime startOfWeek) {
    List<Widget> flowers = [];
    List<Offset> spots = [
      const Offset(50, 150),
      const Offset(100, 150),
      const Offset(150, 150),
      const Offset(200, 150),
      const Offset(250, 150),
      const Offset(300, 150),
      const Offset(350, 150),
    ];

    DateTime day = startOfWeek;
    for (int i = 0; i < 7; i++) {
      if (completedPrompts[day] == true) {
        int flowerNum = random.nextInt(7) + 1;
        flowers.add(
          Positioned(
            left: spots[i].dx,
            top: spots[i].dy,
            child: Image.asset('assets/Flowers/Flower$flowerNum.png', width: 75, height: 75),
          ),
        );
      }
      day = day.add(const Duration(days: 1));
    }
    return flowers;
  }
}