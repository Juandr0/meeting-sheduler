import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_scheduler/features/booking/domain/usecases/create_booking_usecase.dart';
import 'package:meeting_scheduler/features/booking/domain/usecases/delete_booking_usecase.dart';
import 'package:meeting_scheduler/features/booking/domain/usecases/get_bookings_usecase.dart';
import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final GetBookingsUseCase getBookings;
  final CreateBookingUseCase createBooking;
  final DeleteBookingUseCase deleteBooking;

  BookingBloc({
    required this.getBookings,
    required this.createBooking,
    required this.deleteBooking,
  }) : super(BookingInitial()) {
    on<LoadBookingsEvent>((event, emit) async {
      emit(BookingLoading());
      try {
        final bookings = await getBookings.call();
        emit(BookingLoaded(bookings));
      } catch (_) {
        emit(const BookingError('Failed to load bookings'));
      }
    });

    on<CreateBookingEvent>((event, emit) async {
      emit(BookingLoading());
      try {
        await createBooking.call(event.booking);
        add(LoadBookingsEvent());
      } catch (_) {
        emit(const BookingError('Failed to create booking'));
      }
    });

    on<DeleteBookingEvent>((event, emit) async {
      emit(BookingLoading());
      try {
        await deleteBooking.call(event.booking);
        add(LoadBookingsEvent());
      } catch (_) {
        emit(const BookingError('Failed to delete booking'));
      }
    });
  }
}
