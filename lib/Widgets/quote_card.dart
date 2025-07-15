import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/Model/quote_model.dart';
import 'package:to_do_app/Provider/quoteprovider.dart';

class QuoteCard extends StatefulWidget {
  final Quote quote;

  const QuoteCard({required this.quote});

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600; // Typical tablet breakpoint

    Provider.of<QuoteProvider>(context, listen: false).refreshQuote();

    final quoteProvider = Provider.of<QuoteProvider>(context);
    return Card(
      color: Colors.teal,
      margin: EdgeInsets.all(isTablet ? 24 : 16),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 24 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quote of the Day',
                  style: TextStyle(
                    fontSize: isTablet ? 20 : 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: isTablet ? 18 : 14,
                      color: Colors.white,
                    ),
                    SizedBox(width: isTablet ? 8 : 4),
                    Text(
                      quoteProvider.currentDate,
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: isTablet ? 16 : 12),
            Text(
              '"${quoteProvider.currentQuote.text}"',
              style: TextStyle(
                fontSize: isTablet ? 22 : 18,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
            SizedBox(height: isTablet ? 12 : 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '- ${quoteProvider.currentQuote.author}',
                style: TextStyle(
                  fontSize: isTablet ? 16 : 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
