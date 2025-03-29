class ConverterHelper {
  static String? convertCommaWithUnderScore(String value) {
    int numberOfQuotes = value.split("").where((e) => e == '"').length;

    if (numberOfQuotes % 2 != 0) {
      return null;
    }

    List<String> cuts = [];

    List<String> matchStack = [];

    String buffer = "";
    for (int i = 0; i < value.length; i++) {
      String char = value[i];

      if (char != '"' && char != ",") {
        buffer = buffer + char;
      }

      if (char == '"') {
        if (matchStack.isEmpty) {
          matchStack.add(char);
        } else {
          if (matchStack.last == char) {
            matchStack.removeLast();
          }
        }
      }

      if (char == ",") {
        if (matchStack.isEmpty) {
          cuts.add(buffer);
          buffer = "";
        } else {
          buffer = buffer + char;
        }
      }

      if (i == value.length - 1) {
        cuts.add(buffer);
        buffer = "";
      }
    }

    cuts = cuts.map((e) => e.replaceAll(",", "_")).toList();

    return cuts.join(",");
  }

  static String convertUnderScoreWithComma(String value) {
    return value.replaceAll("_", ",");
  }
}
