import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchSomeVideos() async {
  List<dynamic> theVideos = [];
  final anValue =
      Uri.parse('https://youtube-search-and-download.p.rapidapi.com/trending');
  try {
    final anResponse = await http.get(
      anValue,
      headers: {
        'X-RapidAPI-Key': '200c82b907msh24597d44ca3e98dp1449abjsn7155f67276f3',
        'X-RapidAPI-Host': 'youtube-search-and-download.p.rapidapi.com',
        "hl": "en",
        "gl": "in",
      },
    );
    if (anResponse.statusCode == 200) {
      final datas = jsonDecode(anResponse.body);
      Map<dynamic, dynamic> anMap = datas;
      
      List<dynamic> anList = anMap["contents"];
      for (var element in anList) {
        theVideos.add(element["video"]);
      }
      return theVideos;
    }
    return [];
  } catch (e) {
    log("$e, something went wrong");
    return [];
  }
}
