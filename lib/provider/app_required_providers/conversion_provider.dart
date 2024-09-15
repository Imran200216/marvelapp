import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConversionProvider with ChangeNotifier {
  /// Duration format
  String formatDuration(Object? duration) {
    // If duration is an int, assume it's in minutes and format accordingly
    if (duration is int) {
      int totalMinutes = duration;

      // Calculate hours and minutes
      int hours = totalMinutes ~/ 60;
      int minutes = totalMinutes % 60;

      // Format the hours and minutes using Intl package
      final formattedDuration =
          "${NumberFormat('00').format(hours)}h ${NumberFormat('00').format(minutes)}m";
      return formattedDuration;
    } else if (duration is String) {
      // If it's a string, we assume it's already in a suitable format
      return duration.isNotEmpty ? duration : "Releasing soon";
    }

    // If it's neither int nor String, default to "Releasing soon"
    return "Releasing soon";
  }

  /// Date format
  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return 'Releasing soon'; // Fallback to default text if no date is provided
    }
    try {
      DateTime date = DateFormat('yyyy-MM-dd').parse(dateStr);
      String formattedDate = DateFormat('MMMM dd, yyyy').format(date); // Example: January 01, 2023
      return formattedDate;
    } catch (e) {
      return 'Releasing soon'; // Fallback if date parsing fails
    }
  }

  /// Money format (box office)
  String formatBoxOffice(String? boxOfficeStr) {
    if (boxOfficeStr == null || boxOfficeStr.isEmpty) {
      return 'Releasing soon'; // Fallback if no box office data
    }
    try {
      double boxOffice = double.parse(boxOfficeStr);
      NumberFormat currencyFormatter = NumberFormat.currency(locale: 'en_US', symbol: '\$');
      return currencyFormatter.format(boxOffice); // Example: $1,000,000.00
    } catch (e) {
      return 'Releasing soon'; // Fallback if the value can't be parsed
    }
  }
}
