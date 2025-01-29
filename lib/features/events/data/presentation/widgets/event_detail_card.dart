import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventTicketScreen extends StatefulWidget {
  const EventTicketScreen({super.key});

  @override
  State<EventTicketScreen> createState() => _EventTicketScreenState();
}

class _EventTicketScreenState extends State<EventTicketScreen> {
  int? selectedTicketIndex;

  final List<TicketOption> ticketOptions = [
    TicketOption(
      title: 'Regular Access',
      description: 'Standard entry to all pool activities',
      price: 9.99,
    ),
    TicketOption(
      title: 'VIP Experience',
      description: 'Premium seating, complimentary drinks',
      price: 24.99,
    ),
    TicketOption(
      title: 'Cabana Package',
      description: 'Private cabana, full service, premium drinks',
      price: 49.99,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF483D8B),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Splash & Chill',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Eagle King ent.',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Welcome to the most fun filled hangout. Brace yourself for an extraordinary experience. There will be swimming, BBQ, Snooker, etc...',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(height: 24),
              _buildInfoRow(
                Icons.location_on,
                'Venue',
                'Stella Maris Hotel, Quatier Jak, Cotonou',
              ),
              const SizedBox(height: 16),
              _buildInfoRow(
                Icons.calendar_today,
                'Date',
                '22 December 2024',
              ),
              const SizedBox(height: 32),
              Text(
                'Select Ticket Type',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: ticketOptions.length,
                  itemBuilder: (context, index) {
                    return _buildTicketOption(index);
                  },
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: selectedTicketIndex != null
                      ? () {
                    // Handle ticket purchase
                    final selectedTicket = ticketOptions[selectedTicketIndex!];
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Selected ${selectedTicket.title} ticket for \$${selectedTicket.price}',
                        ),
                      ),
                    );
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF69B4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xFFFF69B4),
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
              ),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTicketOption(int index) {
    final ticket = ticketOptions[index];
    final isSelected = selectedTicketIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTicketIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF69B4) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Radio(
              value: index,
              groupValue: selectedTicketIndex,
              onChanged: (value) {
                setState(() {
                  selectedTicketIndex = value as int;
                });
              },
              activeColor: const Color(0xFFFF69B4),
              fillColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return const Color(0xFFFF69B4);
                  }
                  return Colors.grey;
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket.title,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    ticket.description,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '\$${ticket.price}',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFF69B4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TicketOption {
  final String title;
  final String description;
  final double price;

  TicketOption({
    required this.title,
    required this.description,
    required this.price,
  });
}