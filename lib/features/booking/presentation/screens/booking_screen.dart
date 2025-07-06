import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_scheduler/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:meeting_scheduler/features/booking/domain/entities/booking.dart';
import 'package:meeting_scheduler/features/booking/presentation/bloc/booking_event.dart';
import 'package:meeting_scheduler/features/booking/presentation/bloc/booking_state.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Kör initialt en LoadBookingsEvent för att hämta bokningar
    context.read<BookingBloc>().add(LoadBookingsEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mötesrum Bokningar'),
      ),
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          if (state is BookingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookingLoaded) {
            final bookings = state.bookings;

            if (bookings.isEmpty) {
              return const Center(child: Text('Inga bokningar hittades.'));
            }

            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return ListTile(
                  title: Text('Rum: ${booking.roomId}'),
                  subtitle: Text(
                      'Start: ${booking.start}\nSlut: ${booking.end}\nAnvändare: ${booking.userId}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context
                          .read<BookingBloc>()
                          .add(DeleteBookingEvent(booking));
                    },
                  ),
                );
              },
            );
          } else if (state is BookingError) {
            return Center(child: Text('Fel: ${state.message}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final now = DateTime.now();
          final newBooking = Booking(
            bookingId: null,
            roomId: 'Rum B',
            userId: 'User123',
            start: now,
            end: now.add(const Duration(hours: 1)),
          );

          context.read<BookingBloc>().add(CreateBookingEvent(newBooking));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
