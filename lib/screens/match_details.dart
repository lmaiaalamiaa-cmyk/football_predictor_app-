
import 'package:flutter/material.dart';

import '../models/match.dart';
import '../services/ai_service.dart';

class MatchDetailsScreen extends StatelessWidget {
  final FootballMatch match;
  final bool isArabic;

  const MatchDetailsScreen({
    super.key,
    required this.match,
    required this.isArabic,
  });

  String tr(String ar, String fr) {
    return isArabic ? ar : fr;
  }

  @override
  Widget build(BuildContext context) {
    final ai = AiService();

    return Directionality(
      textDirection: isArabic
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AI MATCH PRO'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              match.league,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF16C784),
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(
                    match.home,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),

                Text(
                  '${match.homeGoals ?? '-'} : ${match.awayGoals ?? '-'}',
                  style: const TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF16C784),
                  ),
                ),

                Expanded(
                  child: Text(
                    match.away,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Card(
              color: const Color(0xFF10232D),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      size: 35,
                      color: Color(0xFF16C784),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      tr(
                        'تحليل الذكاء الاصطناعي',
                        'Analyse par IA',
                      ),
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      ai.analyze(match),
                      style: const TextStyle(
                        height: 1.7,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              tr(
                'التوقعات ليست مضمونة',
                'Les pronostics ne sont pas garantis',
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.orangeAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
