import 'package:flutter/material.dart';
import 'package:infinite_scroll/data.dart';

class InfiniteScreen extends StatefulWidget {
  const InfiniteScreen({super.key});

  @override
  State<InfiniteScreen> createState() => _InfiniteScreenState();
}

class _InfiniteScreenState extends State<InfiniteScreen> {
  List<String> items = [];
  bool reachedEnd = false;

  Future refresh() async {
    setState(() => items.clear());
    List<String> tempItems = await getComments(-1);
    setState(() {
      items = tempItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Push To Refresh"),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView.builder(
          itemCount: items.length + 1,
          itemBuilder: ((context, index) {
            if (index < items.length) {
              final item = items[index];
              return ListTile(title: Text(item));
            } else {
              fetchAndAppendComments(items.length);
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          }),
        ),
      ),
    );
  }

  Future<void> fetchAndAppendComments(int lastItemId) async {
    List<String> tempItems = await getComments(lastItemId);
    setState(() {
      reachedEnd = tempItems.length < pageSize;
      items.addAll(tempItems);
    });
  }
}
