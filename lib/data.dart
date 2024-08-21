const pageSize = 5;

Future<List<String>> getComments(int lastItemId) async {
  return Future.delayed(
    const Duration(seconds: 1),
    () => List.generate(
      pageSize,
      (index) => "Comment ${lastItemId + 1 + index}",
    ),
  );
}
