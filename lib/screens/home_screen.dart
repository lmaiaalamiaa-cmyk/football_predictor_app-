
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/match.dart';
import '../services/api_service.dart';
import '../widgets/match_card.dart';
import 'match_details.dart';
import 'predictions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService api = ApiService();

  DateTime selectedDate = DateTime.now();

  late Future<List<FootballMatch>> matchesFuture;

  String language = 'ar';
  int selectedTab = 0;

  bool get isArabic => language == 'ar';

  String tr(String ar, String fr) {
    return isArabic ? ar : fr;
  }

  @override
  void initState() {
    super.initState();
    loadMatches();
  }

  void loadMatches() {
    matchesFuture = api.getMatches(selectedDate);
  }

  Future<void> refreshMatches() async {
    setState(loadMatches);
    try {
      await matchesFuture;
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isArabic
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF10232D),
          title: const Text(
            '⚽ AI MATCH PRO',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  language = isArabic ? 'fr' : 'ar';
                });
              },
              child: Text(
                isArabic ? 'FR' : 'عربي',
                style: const TextStyle(
                  color: Color(0xFF16C784),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: refreshMatches,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),

        body: FutureBuilder<List<FootballMatch>>(
          future: matchesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return _errorWidget(
                snapshot.error.toString(),
              );
            }

            final matches = snapshot.data ?? [];

            if (selectedTab == 1) {
              return PredictionsScreen(
                matches: matches,
                isArabic: isArabic,
              );
            }

            return _matchesPage(matches);
          },
        ),

        bottomNavigationBar: NavigationBar(
          backgroundColor: const Color(0xFF10232D),
          selectedIndex: selectedTab,
          onDestinationSelected: (index) {
            setState(() {
              selectedTab = index;
            });
          },
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.sports_soccer),
              label: tr('المباريات', 'Matchs'),
            ),
            NavigationDestination(
              icon: const Icon(Icons.auto_awesome),
              label: tr('توقعات AI', 'Pronostics IA'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _matchesPage(List<FootballMatch> matches) {
    final grouped = <String, List<FootballMatch>>{};

    for (final match in matches) {
      final key = '${match.country} - ${match.league}';

      grouped.putIfAbsent(key, () => []).add(match);
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF145B42),
                Color(0xFF10232D),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr(
                  'كرة القدم بين يديك',
                  'Le football à portée de main',
                ),
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                tr(
                  'المغرب والبطولات العالمية',
                  'Maroc et championnats mondiaux',
                ),
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: 65,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (context, index) {
              final day = DateTime.now().add(
                Duration(days: index - 3),
              );

              final selected = DateUtils.isSameDay(
                day,
                selectedDate,
              );

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDate = day;
                    loadMatches();
                  });
                },
                child: Container(
                  width: 60,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF16C784)
                        : const Color(0xFF10232D),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      DateFormat('dd/MM').format(day),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selected
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Text(
                tr('المباريات', 'MATCHS'),
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '${matches.length}',
                style: const TextStyle(
                  color: Color(0xFF16C784),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: matches.isEmpty
              ? Center(
                  child: Text(
                    tr(
                      'لا توجد مباريات متاحة',
                      'Aucun match disponible',
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: refreshMatches,
                  child: ListView(
                    children: grouped.entries.map((entry) {
                      return Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            color: const Color(0xFF183541),
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              entry.key,
                              style: const TextStyle(
                                color: Color(0xFF16C784),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          ...entry.value.map((match) {
                            return MatchCard(
                              match: match,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        MatchDetailsScreen(
                                      match: match,
                                      isArabic: isArabic,
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        ],
                      );
                    }).toList(),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _errorWidget(String error) {
    final missing = error.contains('API_KEY_MISSING');

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.cloud_off,
              size: 55,
              color: Color(0xFF16C784),
            ),
            const SizedBox(height: 15),
            Text(
              missing
                  ? tr(
                      'يجب ربط مفتاح API أولاً',
                      'Ajoutez votre clé API',
                    )
                  : tr(
                      'تعذر تحميل المباريات',
                      'Impossible de charger les matchs',
                    ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              missing
                  ? 'API_FOOTBALL_KEY'
                  : error,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: refreshMatches,
              child: Text(
                tr('إعادة المحاولة', 'Réessayer'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
