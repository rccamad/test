import 'dart:async';

Stream<int> temperatureStream() async* {
  for (int temp = 20; temp <= 25; temp++) {
    await Future.delayed(Duration(seconds: 1));
    yield temp;
  }
}

void main() {
  Stream<int> broadcastStream = temperatureStream().asBroadcastStream();

  print("Starting temperature stream...\n");

  broadcastStream.where((temp) => temp > 22).listen((temp) {
    print("Raw temperature (Celsius): $temp");
  });

  broadcastStream.map((temp) => (temp * 9 / 5) + 32).listen((temp) {
    print("Converted temperature (Fahrenheit): ${temp.toStringAsFixed(2)}]°F");
  });
}
