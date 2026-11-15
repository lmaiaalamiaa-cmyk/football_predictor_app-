
import 'package:flutter/material.dart';
import '../models/match.dart';

class PredictionsScreen extends StatelessWidget {
  final List<FootballMatch> matches;
  final bool isArabic;

  const PredictionsScreen({
    super.key,
    required this.matches,
    required this.isArabic,
  });

  String tr(String ar, String fr) {
    return isArabic ? ar : fr;
  }

  @override
  Widget build(BuildContext context) {
    final upcoming = matches.where(
      (match) =>
          !match.isLive && !match.isFinished,
    ).toList();

    return Directionality(
      textDirection: isArabic
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Icon(
            Icons.auto_awesome,
            size: 55,
            color: Color(0xFF16C784),
          ),

          const SizedBox(height: 12),

          Text(
            tr(
              'المحلل الذكي AI',
              'ANALYSEUR INTELLIGENT IA',
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            tr(
              'تحليل المباريات والتوقعات الرياضية',
              'Analyse des matchs et pronostics',
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white60,
            ),
          ),

          const SizedBox(height: 25),

          Card(
            color: const Color(0xFF10232D),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Text(
                    tr(
                      'محرك التوقعات',
                      'Moteur de pronostics',
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    tr(
                      'سيتم تفعيل التوقعات الإحصائية بعد ربط بيانات آخر المباريات والهجوم والدفاع والمواجهات المباشرة.',
                      'Les pronostics statistiques seront activés après connexion aux données de forme, attaque, défense et confrontations directes.',
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Chip(
                    avatar: Icon(
                      Icons.pending_actions,
                      color: Colors.orangeAccent,
                    ),
                    label: Text('Statistics integration pending'),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            tr(
              'المباريات القادمة',
              'Prochains matchs',
            ),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          if (upcoming.isEmpty)
            Text(
              tr(
                'لا توجد مباريات قادمة في البيانات الحالية',
                'Aucun prochain match dans les données actuelles',
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white60,
              ),
            ),

          ...upcoming.map(
            (match) => Card(
              color: const Color(0xFF10232D),
              child: ListTile(
                leading: const Icon(
                  Icons.sports_soccer,
                  color: Color(0xFF16C784),
                ),
                title: Text(
                  '${match.home} - ${match.away}',
                ),
                subtitle: Text(match.league),
                trailing: const Icon(
                  Icons.auto_awesome,
                  color: Color(0xFF16C784),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
