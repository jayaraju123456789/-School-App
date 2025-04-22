import 'package:flutter/material.dart';

class AnnouncementsSection extends StatelessWidget {
  const AnnouncementsSection({Key? key}) : super(key: key);

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
            Text(
              'Announcements',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.announcement,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    title: Text(
                      'Important Announcement ${index + 1}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'This is a sample announcement content that provides important information to students.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      '${index + 1}h ago',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onTap: () {
                      // Show full announcement
                      _showFullAnnouncement(context, index);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFullAnnouncement(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Important Announcement ${index + 1}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8),
              Text(
                'Posted ${index + 1}h ago',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 16),
              Text(
                'This is the full content of the announcement. It contains detailed information about the announcement that is important for students to know.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
