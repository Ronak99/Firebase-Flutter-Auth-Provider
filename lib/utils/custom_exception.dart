class CustomException implements Exception {
  String message;
  String? code;

  CustomException(this.message, {this.code}) {
    print(this.toString());
  }

  String toString() => "CustomExcpetion: $message";
}
