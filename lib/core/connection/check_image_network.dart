import 'package:http/http.dart' as http;

class CheckImageNetwork {
  // String networkImageUrl;
  // CheckImageNetwork({required this.networkImageUrl});

  static Future<bool> checkImageStatus(
      {required String networkImageUrl}) async {
    final response = await http.head(Uri.parse(networkImageUrl));
    return response.statusCode == 200 ? true : false;
  }
}
