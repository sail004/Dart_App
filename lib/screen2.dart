import 'package:flutter/material.dart';

class BreakfastScreen extends StatefulWidget {
  final List<Map<String, dynamic>> items;

  const BreakfastScreen({required this.items});

  @override
  _BreakfastScreenState createState() => _BreakfastScreenState();
}

class _BreakfastScreenState extends State<BreakfastScreen> {
  String _searchText = '';

  List<Map<String, dynamic>> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    _selectedItems = List<Map<String, dynamic>>.from(widget.items);
  }

  @override
  Widget build(BuildContext context) {
    final String? cardTitle = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: Text('${cardTitle ?? 'Unknown'}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedItems.length,
              itemBuilder: (context, index) {
                if (_selectedItems[index]['name'].toLowerCase().contains(_searchText.toLowerCase())) {
                  return ListTile(
                    title: Text(_selectedItems[index]['name']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${_selectedItems[index]['calories']} ккал',
                          style: TextStyle(fontSize: 12),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _selectedItems[index]['count'] += (_selectedItems[index]['count'] ?? 0);
                            });
                          },
                          icon: Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}