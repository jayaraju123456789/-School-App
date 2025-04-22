import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Results & Exams'),
          backgroundColor: Colors.deepPurple,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Results'),
              Tab(text: 'Upcoming Exams'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildResultsTab(),
            _buildUpcomingExamsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(bottom: 16),
          child: ExpansionTile(
            title: Text('Semester ${index + 1}'),
            children: [
              _buildSubjectResult('Mathematics', 85),
              _buildSubjectResult('Physics', 78),
              _buildSubjectResult('Chemistry', 92),
              _buildSubjectResult('English', 88),
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('SGPA:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('8.5', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSubjectResult(String subject, int marks) {
    return ListTile(
      title: Text(subject),
      trailing: Text(
        '$marks',
        style: TextStyle(
          color: marks >= 75 ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildUpcomingExamsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(bottom: 16),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Text('${index + 1}'),
            ),
            title: Text('Mid Semester Exam ${index + 1}'),
            subtitle: Text(
                'Date: ${DateTime.now().add(Duration(days: (index + 1) * 7)).toString().substring(0, 10)}'),
            trailing: Chip(
              label: Text('Upcoming'),
              backgroundColor: Colors.orange,
              labelStyle: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
