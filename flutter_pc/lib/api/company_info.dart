import 'dart:convert';
import 'package:flutter_pc/data/stock.dart';
import 'package:http/http.dart' as http;

Future<Stock> fetchGetCompany(String symbol) async {
  final response = await http.get(Uri.parse(
      'https://finnhub.io/api/v1/stock/profile2?symbol=$symbol&token=c22v9eqad3idsrtigfq0'));

  if (response.statusCode == 200) {
    if (response.body.isNotEmpty) {
      return Stock.fromJson(json.decode(response.body));
    }
  }

  throw Exception("Failed to load stock information");
}
