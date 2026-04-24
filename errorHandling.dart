import "dart:io";

void main() {
  try {
    print("Enter numerical ID: ");
    String? input = stdin.readLineSync();
    if (input == null || input.trim().isEmpty) {
      throw FormatException("Input cannot be emptty");
    }
    int id = int.parse(input);

    print("Valid ID entered: $id");
  } on FormatException catch (e) {
    print("Error: Invalid input / please enter a valid number / $e");
  } catch (e) {
    print("Unexpected error occured: $e");
  } finally {
    print("\nProgram completed");
  }
}
