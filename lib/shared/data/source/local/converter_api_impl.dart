import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:kgk/core/helper/converter_helper.dart';
import 'package:kgk/core/utils/constants/app_types.dart';
import 'package:kgk/shared/data/source/local/converter_api.dart';

class ConverterAPIImpl extends ConverterAPI {
  @override
  Future<List<Json>> convert({required String filePath}) async {
    List<Json> jsonData = [];

    ByteData byteData = await rootBundle.load(filePath);

    Uint8List raw = Uint8List.fromList(byteData.buffer.asUint8List());

    String rawDataString = utf8.decode(raw);

    List<String> listRawDataString = rawDataString.split("\n");

    // copy headers in separate variable and remove from the main list.
    List<String> headers =
        listRawDataString[0].split(",").map((e) => e.trim()).toList();
    listRawDataString.removeAt(0);

    for (String _raw in listRawDataString) {
      List<String> rawData =
          ConverterHelper.convertCommaWithUnderScore(_raw)?.split(",") ?? [];

      Json input = {};
      for (int i = 0; i < headers.length; i++) {
        if (i >= rawData.length) {
          input[headers[i]] = "";
        } else {
          input[headers[i]] =
              ConverterHelper.convertUnderScoreWithComma(rawData[i]);
        }
      }

      jsonData.add(input);
    }

    return jsonData;
  }
}
