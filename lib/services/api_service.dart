
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/match.dart';

class ApiService {
  static const String baseUrl =
      'https://v3.football.api-sports.io';

  static const String apiKey =
      String.fromEnvironment('API_FOOTBALL_KEY');

  Future<List<FootballMatch>> getMatches(
      DateTime date) async {

    if (apiKey.isEmpty) {
      throw Exception(
        'API_KEY_MISSING',
      );
    }

    final day =
        '${date.year}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';

    final uri = Uri.parse(
      '$baseUrl/fixtures',
    ).replace(
      queryParameters: {
        'date': day,
        'timezone': 'Africa/Casablanca',
      },
    );

    final response = await http.get(
      uri,
      headers: {
        'x-apisports-key': apiKey,
      },
    ).timeout(
      const Duration(seconds: 20),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'API_ERROR_${response.statusCode}',
      );
    }

    final data = jsonDecode(response.body);

    if (data['errors'] is Map &&
        (data['errors'] as Map).isNotEmpty) {
      throw Exception(
        data['errors'].toString(),
      );
    }

    final List items = data['response'] ?? [];

    final matches = items.map((item) {
      return FootballMatch.fromJson(item);
    }).where((match) {
      return _isSupported(match);
    }).toList();

    matches.sort((a, b) {
      if (a.isLive != b.isLive) {
        return a.isLive ? -1 : 1;
      }

      return a.kickoff.compareTo(b.kickoff);
    });

    return matches;
  }

  bool _isSupported(FootballMatch match) {
    final country = match.country.toLowerCase();
    final league = match.league.toLowerCase();

    const countries = [
      'morocco',
      'england',
      'spain',
      'france',
      'germany',
      'italy',
      'portugal',
      'netherlands',
      'europe',
    ];

    const competitions = [
      'champions league',
      'europa league',
      'conference league',
      'world cup',
      'africa cup of nations',
    ];

    return countries.contains(country) ||
        competitions.any(
          (name) => league.contains(name),
        );
  }
}
