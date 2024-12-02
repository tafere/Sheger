import 'package:flutter/material.dart';
import '../model/festival.dart';

class FestivalScreen extends StatefulWidget {
  @override
  _FestivalScreenState createState() => _FestivalScreenState();
}

class _FestivalScreenState extends State<FestivalScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Festival> festivals = [
      Festival(
        name: 'Rophnan Concert',
        date: '06/15/2024',
        price: 50.00,
        posterUrl: 'assets/images/Rophnan.jpg',
      ),
      Festival(
        name: 'Timket Festival',
        date: '07/20/2024',
        price: 30.00,
        posterUrl: 'assets/images/Timket.jpg',
      ),
      // Add more festivals here
    ];

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: festivals.length,
      itemBuilder: (context, index) {
        return ExpandableFestCard(festival: festivals[index]);
      },
    );
  }
}

class ExpandableFestCard extends StatefulWidget {
  final Festival festival;

  const ExpandableFestCard({required this.festival});

  @override
  _ExpandableFestCardState createState() => _ExpandableFestCardState();
}

class _ExpandableFestCardState extends State<ExpandableFestCard> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  Future<void> _makeTelebirrPayment(Festival festival) async {
    // Placeholder function for Telebirr payment integration
    // Replace with actual API or SDK call
    try {
      // Example: Show loading spinner during payment
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );

      // Simulate API Call or SDK invocation
      await Future.delayed(Duration(seconds: 2));

      // Close loading spinner
      Navigator.pop(context);

      // Handle payment success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment successful for ${festival.name}!')),
      );
    } catch (error) {
      // Handle payment failure
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: _toggleExpanded,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Festival Poster
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                widget.festival.posterUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Festival Title
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.festival.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // Expandable Details
            if (_isExpanded)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date: ${widget.festival.date}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Price: \$${widget.festival.price.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => _makeTelebirrPayment(widget.festival),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Pay with Telebirr'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

