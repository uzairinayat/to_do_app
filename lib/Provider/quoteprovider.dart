import 'package:flutter/material.dart';
import 'package:to_do_app/Model/quote_model.dart';


class QuoteProvider with ChangeNotifier {
  Quote? _currentQuote;  // Changed from late to nullable
  DateTime _lastUpdated = DateTime.now();
  List<Quote> _quotes = [...motivationalQuotes];

  Quote get currentQuote {
    if (_currentQuote == null) {
      _updateQuote();
    }
    return _currentQuote!;
  }

  QuoteProvider() {
    _updateQuote();
  }

  void _updateQuote() {
    final now = DateTime.now();
    // Check if it's a new day or if we need to initialize
    if (_currentQuote == null || 
        _lastUpdated.year != now.year ||
        _lastUpdated.month != now.month ||
        _lastUpdated.day != now.day) {
      _lastUpdated = now;
      _currentQuote = _quotes[now.day % _quotes.length];
      notifyListeners();
    }
  }

  void refreshQuote() {
    _updateQuote();
  }

  String get currentDate {
    final now = DateTime.now();
    return "${now.day}/${now.month}/${now.year}";
  }
}