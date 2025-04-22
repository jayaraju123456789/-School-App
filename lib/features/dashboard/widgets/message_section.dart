import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class MessageSection extends StatelessWidget {
  const MessageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: badges.Badge(
        position: badges.BadgePosition.topEnd(top: -8, end: -8),
        badgeContent: Text(
          '3',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        child: IconButton(
          icon: Icon(Icons.message, color: Colors.white),
          onPressed: () => _showMessages(context),
        ),
      ),
    );
  }

  void _showMessages(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.6,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Messages',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text('Message ${index + 1}'),
                        subtitle: Text('This is a sample message content'),
                        trailing: Text('2m ago'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
