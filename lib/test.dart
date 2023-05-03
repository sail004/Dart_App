import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'APIManager.dart';

void main() {
  group('APIManager', () {
    test('getData returns a list of products', () async {
      final client = http.Client();
      final apiManager = APIManager(client: client);
      final products = await apiManager.getData({}, 'products');

      expect(products, isA<List<Map<String, dynamic>>>());
    });
  });
}