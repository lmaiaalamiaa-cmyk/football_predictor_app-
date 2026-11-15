import 'package:flutter/material.dart';

void main() => runApp(FootballApp());

class FootballApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Football Predictor',
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Color(0xFFF5F5F5)),
      home: HomeScreen(),
    );
  }
}

class Match {
  final String league, country, home, away, time, status;
  final int? homeScore, awayScore;
  final String prediction, expertAnalysis, aiAnalysis;
  final int homeWin, draw, awayWin;
  Match({required this.league, required this.country, required this.home, required this.away, required this.time, required this.status, this.homeScore, this.awayScore, required this.prediction, required this.expertAnalysis, required this.aiAnalysis, required this.homeWin, required this.draw, required this.awayWin});
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedDay = 3;
  List<String> days = ['ME 11.9', 'JE 12.9', 'VE 13.9', 'AJD 14.9', 'DI 15.9', 'LU 16.9', 'MA 17.9'];

  List<Match> matches = [
    Match(league: 'Botola Pro', country: 'MAROC', home: 'Raja Casablanca', away: 'Renaissance Zemamra', time: "88'", status: 'live', homeScore: 3, awayScore: 1, prediction: '3 - 1', expertAnalysis: 'الرجاء مسيطر على المباراة، هجومه قوي في الشوط الثاني وخبرة لاعبيه تحسم.', aiAnalysis: 'الذكاء الاصطناعي: الرجاء سجل في آخر 5 مباريات 11 هدف، والخصم ضعيف دفاعيا خارج ملعبه.', homeWin: 65, draw: 20, awayWin: 15),
    Match(league: 'Botola Pro', country: 'MAROC', home: 'Wydad', away: 'COD Meknes', time: "87'", status: 'live', homeScore: 2, awayScore: 0, prediction: '2 - 0', expertAnalysis: 'الوداد يلعب بضغط عالي والمكناس متراجع.', aiAnalysis: 'الذكاء الاصطناعي يتوقع فوز الوداد بنسبة عالية بسبب الاستحواذ 68%.', homeWin: 70, draw: 18, awayWin: 12),
    Match(league: 'Botola Pro', country: 'MAROC', home: 'FAR Rabat', away: 'Tanger', time: "77'", status: 'live', homeScore: 1, awayScore: 1, prediction: '1 - 1', expertAnalysis: 'مباراة متكافئة، الجيش قوي في الهجوم وطنجة يدافع جيدا.', aiAnalysis: 'التوقع: تعادل، الفريقين متساويين في آخر المواجهات.', homeWin: 40, draw: 35, awayWin: 25),
    Match(league: 'Botola Pro', country: 'MAROC', home: 'Berkane', away: 'Maghreb Fez', time: '18:30', status: 'upcoming', prediction: '2 - 1', expertAnalysis: 'بركان على أرضه لا يخسر بسهولة، والمغرب الفاسي يعاني خارج ملعبه.', aiAnalysis: 'الذكاء الاصطناعي: بركان فاز في 4 من آخر 5 مباريات على ملعبه.', homeWin: 58, draw: 24, awayWin: 18),
    Match(league: 'Premier League', country: 'ANGLETERRE', home: 'Manchester City', away: 'West Ham', time: "68'", status: 'live', homeScore: 3, awayScore: 0, prediction: '4 - 0', expertAnalysis: 'السيتي مسيطر بالكامل، هالاند في يومه.', aiAnalysis: 'الذكاء الاصطناعي: السيتي سدد 14 تسديدة مقابل 2.', homeWin: 82, draw: 10, awayWin: 8),
    Match(league: 'Premier League', country: 'ANGLETERRE', home: 'Arsenal', away: 'Newcastle', time: "67'", status: 'live', homeScore: 1, awayScore: 0, prediction: '2 - 0', expertAnalysis: 'أرسنال يلعب بتوازن كبير ودفاعه صلب.', aiAnalysis: 'الذكاء الاصطناعي: أرسنال حافظ على شباكه في 3 مباريات متتالية.', homeWin: 62, draw: 22, awayWin: 16),
    Match(league: 'Premier League', country: 'ANGLETERRE', home: 'Liverpool', away: 'Tottenham', time: "69'", status: 'live', homeScore: 2, awayScore: 1, prediction: '3 - 1', expertAnalysis: 'ليفربول في الأنفيلد مرعب، وسرعة صلاح تحسم.', aiAnalysis: 'الذكاء الاصطناعي: ليفربول سجل +2.5 هدف في 80% من مبارياته على ملعبه.', homeWin: 68, draw: 18, awayWin: 14),
    Match(league: 'LaLiga', country: 'ESPAGNE', home: 'Real Madrid', away: 'Barcelona', time: '21:00', status: 'upcoming', prediction: '2 - 2', expertAnalysis: 'كلاسيكو متكافئ، الريال قوي هجوميا وبرشلونة يملك الاستحواذ.', aiAnalysis: 'الذكاء الاصطناعي: آخر 5 كلاسيكو انتهت بأهداف من الفريقين.', homeWin: 38, draw: 30, awayWin: 32),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF0A2A3A), title: Row(children: [Icon(Icons.sports_soccer), SizedBox(width: 8), Text('Football ▼'), Spacer(), Icon(Icons.search)])),
      body: Column(
        children: [
          Container(height: 55, color: Colors.white, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: days.length, itemBuilder: (c, i) => GestureDetector(onTap: () => setState(() => selectedDay = i), child: Container(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: selectedDay == i ? Colors.red : Colors.transparent, width: 3))), child: Column(children: [Text(days[i].split(' ')[0], style: TextStyle(fontWeight: FontWeight.bold, color: selectedDay == i ? Colors.red : Colors.grey)), Text(days[i].split(' ')[1], style: TextStyle(fontSize: 12))]))))),
          Expanded(child: ListView.builder(itemCount: matches.length, itemBuilder: (c, index) {
            var m = matches[index];
            bool showLeague = index == 0 || matches[index-1].league != m.league;
            return Column(children: [
              if (showLeague) Container(width: double.infinity, padding: EdgeInsets.all(10), color: Color(0xFFFFF3CD), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(m.league, style: TextStyle(fontWeight: FontWeight.bold)), Text(m.country, style: TextStyle(fontSize: 11, color: Colors.grey))])),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsScreen(match: m))),
                child: Container(color: Colors.white, padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10), child: Row(children: [
                  Icon(Icons.star_border, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(m.home, style: TextStyle(fontWeight: FontWeight.w500)), SizedBox(height: 6), Text(m.away)])),
                  Column(children: [Text(m.status == 'live' ? m.time : m.time, style: TextStyle(color: m.status == 'live' ? Colors.red : Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)), SizedBox(height: 4), if (m.status == 'upcoming') Container(padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(6)), child: Text('توقع AI', style: TextStyle(color: Colors.blue, fontSize: 10, fontWeight: FontWeight.bold)))]),
                  SizedBox(width: 12),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text(m.homeScore?.toString() ?? '', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)), SizedBox(height: 6), Text(m.awayScore?.toString() ?? '', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))]),
                ])),
              ),
            ]);
          })),
        ],
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final Match match;
  DetailsScreen({required this.match});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF0A2A3A), title: Text('${match.home} vs ${match.away}')),
      body: SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(child: Column(children: [Text(match.league, style: TextStyle(color: Colors.grey)), SizedBox(height: 12), Row(mainAxisAlignment: MainAxisAlignment.center, children: [Expanded(child: Text(match.home, textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))), Text(match.prediction, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.red)), Expanded(child: Text(match.away, textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))]), SizedBox(height: 6), Text('توقع النتيجة', style: TextStyle(color: Colors.grey))])),
        SizedBox(height: 20),
        Text('نسبة التوقع', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        _bar('فوز ${match.home}', match.homeWin, Colors.green),
        _bar('تعادل', match.draw, Colors.grey),
        _bar('فوز ${match.away}', match.awayWin, Colors.blue),
        SizedBox(height: 20),
        _card('🎓 تحليل الخبراء', match.expertAnalysis),
        _card('🤖 تحليل الذكاء الاصطناعي', match.aiAnalysis),
      ])),
    );
  }
  Widget _bar(String label, int pct, Color color) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('$label - $pct%'), SizedBox(height: 4), LinearProgressIndicator(value: pct/100, color: color, backgroundColor: Colors.grey.shade200, minHeight: 10), SizedBox(height: 12)]);
  Widget _card(String title, String body) => Container(margin: EdgeInsets.only(bottom: 12), padding: EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), SizedBox(height: 8), Text(body, style: TextStyle(height: 1.5))]));
}
