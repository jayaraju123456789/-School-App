import 'package:flutter/material.dart';

class TimeTableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Table'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildDaySchedule('Monday'),
              _buildDaySchedule('Tuesday'),
              _buildDaySchedule('Wednesday'),
              _buildDaySchedule('Thursday'),
              _buildDaySchedule('Friday'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDaySchedule(String day) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(day, style: TextStyle(fontWeight: FontWeight.bold)),
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: Text('${index + 1}'),
                ),
                title: Text('Subject ${index + 1}'),
                subtitle: Text('9:00 AM - 10:00 AM'),
                trailing: Icon(Icons.school),
              );
            },
          ),
        ],
      ),
    );
  }
}
