class CustomException implements Exception {
  String message;

  CustomException(this.message) {
    print("Exception thrown : $message");
  }

  String toString() => "CustomExcpetion: $message";
}
