import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeTableSection extends StatelessWidget {
  const TimeTableSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Schedule",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  DateFormat('EEEE, MMMM d').format(DateTime.now()),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    margin: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor.withOpacity(0.7),
                          Theme.of(context).primaryColor.withOpacity(0.4),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 9}:00 AM',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Subject ${index + 1}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.person, color: Colors.white70, size: 16),
                            SizedBox(width: 4),
                            Text(
                              'Prof. Smith',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.room, color: Colors.white70, size: 16),
                            SizedBox(width: 4),
                            Text(
                              'Room 10${index + 1}',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
