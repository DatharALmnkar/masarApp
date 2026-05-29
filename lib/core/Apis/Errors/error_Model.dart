class ErrorModel {
  final String message;

  ErrorModel({required this.message});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    
    if (json['message'] != null && json['message'].toString().isNotEmpty) {
      return ErrorModel(message: json['message'].toString());
    }

    
    if (json['errors'] != null && json['errors'] is Map<String, dynamic>) {
      final errors = json['errors'] as Map<String, dynamic>;
      for (final value in errors.values) {
        if (value is List && value.isNotEmpty) {
          return ErrorModel(message: value.first.toString());
        }
      }
    }

    
    if (json['error'] != null) {
      return ErrorModel(message: json['error'].toString());
    }

    
    return ErrorModel(message: 'Something went wrong. Please try again.');
  }
}