class NetworkResponse {
  final int statusCode;
  final bool isSuccess;
  final List<dynamic>? responseList; // Change here

  NetworkResponse(this.isSuccess, this.statusCode, this.responseList);
}
