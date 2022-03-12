class APIResult{
  final String status;
  final String? message;
  final List<dynamic> data;
  APIResult({
    required this.status,
    required this.message,
    required this.data,
  });
  factory APIResult.fromJson(Map<String, dynamic> json){
    return APIResult(status: json['status'], message: json['message'], data: json['data']);
  }
}