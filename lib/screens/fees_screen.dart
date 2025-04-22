import 'package:flutter/material.dart';

class FeesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fee Statement'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFeeCard('Tuition Fee', 50000, true),
            _buildFeeCard('Library Fee', 5000, true),
            _buildFeeCard('Lab Fee', 10000, false),
            _buildFeeCard('Hostel Fee', 30000, false),
            SizedBox(height: 20),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Fee Summary',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    _buildSummaryRow('Total Fee', 95000),
                    _buildSummaryRow('Paid', 55000),
                    _buildSummaryRow('Due', 40000),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeeCard(String title, double amount, bool isPaid) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(title),
        subtitle: Text('Amount: ₹$amount'),
        trailing: Chip(
          label: Text(isPaid ? 'Paid' : 'Pending'),
          backgroundColor: isPaid ? Colors.green : Colors.red,
          labelStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            '₹$amount',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
