final class OffshoreFxModel {
  final String accountNumber;

  OffshoreFxModel({
    required this.accountNumber,
  });

  Map<String, dynamic> toJson() => {
    'accountNumber': accountNumber,
  };
}