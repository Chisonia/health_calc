import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  final List<Map<String, dynamic>> calculationHistory;

  const HistoryPage({Key? key, required this.calculationHistory}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculation History'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: widget.calculationHistory.isEmpty
          ? const Center(child: Text('No History'))
          : ListView.builder(
        itemCount: widget.calculationHistory.length,
        itemBuilder: (context, index) {
          final entry = widget.calculationHistory[index];
          return ListTile(
            leading: Icon(entry['icon']),
            title: Text(entry['type']),
            subtitle: Text(entry['result']),
          );
        },
      ),
    );
  }
}