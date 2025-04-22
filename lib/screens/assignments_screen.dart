import 'package:flutter/material.dart';

class AssignmentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignments'),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement assignment submission
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Assignment submission coming soon!')),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: 5,
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Icon(Icons.assignment, color: Colors.white),
              ),
              title: Text('Assignment ${index + 1}'),
              subtitle: Text(
                  'Due Date: ${DateTime.now().add(Duration(days: index + 1)).toString().substring(0, 10)}'),
              trailing: IconButton(
                icon: Icon(Icons.upload_file),
                onPressed: () {
                  // TODO: Implement file upload
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('File upload coming soon!')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
