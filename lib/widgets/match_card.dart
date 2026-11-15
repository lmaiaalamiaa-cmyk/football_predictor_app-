
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/match.dart';

class MatchCard extends StatelessWidget {
  final FootballMatch match;
  final VoidCallback onTap;

  const MatchCard({
    super.key,
    required this.match,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final time = match.isLive
        ? "${match.elapsed ?? ''}'"
        : match.isFinished
            ? 'FT'
            : DateFormat('HH:mm').format(match.kickoff);

    return Card(
      color: const Color(0xFF10232D),
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              SizedBox(
                width: 42,
                child: Text(
                  time,
                  style: TextStyle(
                    color: match.isLive
                        ? Colors.redAccent
                        : Colors.white60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    _team(
                      match.home,
                      match.homeLogo,
                    ),
                    const SizedBox(height: 10),
                    _team(
                      match.away,
                      match.awayLogo,
                    ),
                  ],
                ),
              ),

              Column(
                children: [
                  Text(
                    '${match.homeGoals ?? '-'}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    '${match.awayGoals ?? '-'}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 8),

              const Icon(
                Icons.chevron_right,
                color: Colors.white38,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _team(String name, String? logo) {
    return Row(
      children: [
        if (logo != null)
          Image.network(
            logo,
            width: 22,
            height: 22,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.shield, size: 20),
          )
        else
          const Icon(
            Icons.shield,
            size: 20,
          ),

        const SizedBox(width: 9),

        Expanded(
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
