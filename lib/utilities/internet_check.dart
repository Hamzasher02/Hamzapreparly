import 'dart:io';
import 'package:http/http.dart' as http;


// checking 'google.com' if it is working or not so that we can understand if internet is available or not

Future<bool> checkInternetAvailability() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      final response = await http.get(Uri.parse('https://google.com'));
      if (response.statusCode == HttpStatus.ok) {
        // You can add any other handling here if needed
        return true;
      }
    }
    return false;
  } on SocketException catch (_) {
    return false;
  }
}
