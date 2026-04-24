import "dart:async";

Stream<int> numberStream() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 2));
    yield i;
  }
}

void main() {
  print("Starting stream...");
  numberStream().listen(
    (value) {
      print("Received: $value");
    }, onDone: () {
      print("Stream completed");
    }, onError: (e) {
      print("Error: $e");
    },
  );
}
