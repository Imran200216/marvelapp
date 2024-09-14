import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:marvelapp/modals/mcu_modal.dart';

class MarvelMoviesProvider with ChangeNotifier {
  List<McuModal> mcuMoviesList = [];
  bool isLoading = true;
  String marvelApi = "https://mcuapi.herokuapp.com/api/v1/movies";

  MarvelMoviesProvider() {
    getMarvelMovies();
  }

  Future<void> getMarvelMovies() async {
    try {
      final uri = Uri.parse(marvelApi);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final decodedData = jsonDecode(responseBody);
        final List marvelData = decodedData['data'];

        mcuMoviesList = marvelData
            .map((movie) => McuModal.fromJson(movie as Map<String, dynamic>))
            .toList();
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching Marvel movies: $error");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
