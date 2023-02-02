import 'package:moi_pratki/app/models/translate_model.dart';

class TranslatorHelper {
  static List<LatToCyr>? latin;

  static void init() {
    latin = [];
    latin!.add(LatToCyr("JAN", "Јануари"));
    latin!.add(LatToCyr("FEB", "Февруари"));
    latin!.add(LatToCyr("MAR", "Март"));
    latin!.add(LatToCyr("APR", "Април"));
    latin!.add(LatToCyr("MAY", "Мај"));
    latin!.add(LatToCyr("JUN", "Јуни"));
    latin!.add(LatToCyr("JUL", "Јули"));
    latin!.add(LatToCyr("AUG", "Август"));
    latin!.add(LatToCyr("SEP", "Септември"));
    latin!.add(LatToCyr("OCT", "Октомври"));
    latin!.add(LatToCyr("NOV", "Ноември"));
    latin!.add(LatToCyr("DEC", "Декември"));
    latin!.add(LatToCyr("-", " "));
    
    latin!.add(LatToCyr("Vo Posta", "Во Пошта"));

    latin!.add(LatToCyr("a", "а"));
    latin!.add(LatToCyr("b", "б"));
    latin!.add(LatToCyr("v", "в"));
    latin!.add(LatToCyr("g", "г"));
    latin!.add(LatToCyr("d", "д"));
    //latin!.add(LatToCyr("~", "ѓ"));
    latin!.add(LatToCyr("e", "е"));
    //latin!.add(LatToCyr("~", "ж"));
    latin!.add(LatToCyr("z", "з"));
    //latin!.add(LatToCyr("~", "ѕ"));
    latin!.add(LatToCyr("i", "и"));
    latin!.add(LatToCyr("j", "ј"));
    latin!.add(LatToCyr("k", "к"));
    latin!.add(LatToCyr("l", "л"));
   // latin!.add(LatToCyr("~", "љ"));
    latin!.add(LatToCyr("m", "м"));
    latin!.add(LatToCyr("n", "н"));
   // latin!.add(LatToCyr("~", "њ"));
    latin!.add(LatToCyr("o", "о"));
    latin!.add(LatToCyr("p", "п"));
    latin!.add(LatToCyr("r", "р"));
    latin!.add(LatToCyr("s", "с"));
    latin!.add(LatToCyr("t", "т"));
    latin!.add(LatToCyr("}", "ќ"));
    latin!.add(LatToCyr("u", "у"));
    latin!.add(LatToCyr("f", "ф"));
    latin!.add(LatToCyr("h", "х"));
    latin!.add(LatToCyr("c", "ц"));
    latin!.add(LatToCyr("~", "ч"));
   //latin!.add(LatToCyr(" ", "џ"));
    latin!.add(LatToCyr("{", "ш"));

    latin!.add(LatToCyr("I", "И"));
    latin!.add(LatToCyr("N", "Н"));
    latin!.add(LatToCyr("P", "П"));
    latin!.add(LatToCyr("V", "В"));
    latin!.add(LatToCyr("Z", "З"));
  }

  static transliterateToCyrillic(String text) {
    String trans = "";
    trans = text;
    for (var dto in latin!) {
      trans = trans.replaceAll(dto.code!, dto.name!);
    }
    return trans;
  }
}
