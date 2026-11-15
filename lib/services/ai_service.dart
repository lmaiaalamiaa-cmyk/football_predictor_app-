
import '../models/match.dart';

class AiService {

  String analyze(FootballMatch match) {

    if (!match.isFinished &&
        !match.isLive) {
      return '''
تحليل المباراة:

الفريق الأول: ${match.home}
الفريق الثاني: ${match.away}

نحتاج إلى بيانات إضافية قبل إصدار
توقع إحصائي موثوق.

سيتم تحليل:
- آخر خمس مباريات.
- قوة الهجوم والدفاع.
- المواجهات المباشرة.
- أداء الفريق داخل وخارج ملعبه.
- الغيابات والإحصائيات المتاحة.
''';
    }

    if (match.isLive) {
      return '''
المباراة مباشرة.

${match.home}:
${match.homeGoals ?? 0}

${match.away}:
${match.awayGoals ?? 0}

يجب تحليل إحصائيات المباراة الحية
قبل تحديث التوقعات.
''';
    }

    return '''
انتهت المباراة.

النتيجة:
${match.homeGoals ?? 0} -
${match.awayGoals ?? 0}

يمكن استخدام النتيجة لتحليل
الأداء السابق للفريقين.
''';
  }

  String predictionStatus() {
    return 'WAITING_FOR_STATISTICS';
  }
}
