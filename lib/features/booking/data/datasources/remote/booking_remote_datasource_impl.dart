import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meeting_scheduler/core/constants/firestore_collections.dart';
import 'package:meeting_scheduler/features/booking/data/datasources/remote/booking_remote_datasource.dart';
import 'package:meeting_scheduler/features/booking/data/models/booking_model.dart';

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final db = FirebaseFirestore.instance;

  @override
  Future<void> createBooking(BookingModel booking) async {
    try {
      final docRef = db.collection('bookings').doc();
      final newBooking = booking.copyWith(bookingId: docRef.id);

      await docRef.set(newBooking.toJson());
    } on FirebaseException catch (e) {
      throw Exception('Firebase error: $e');
    } catch (e) {
      throw Exception('Error adding booking: $e');
    }
  }

  @override
  Future<void> deleteBooking(BookingModel booking) async {
    if (booking.bookingId == null) {
      throw Exception('Booking ID is null, cannot delete booking.');
    }
    try {
      await db
          .collection(FirestoreCollections.bookings)
          .doc(booking.bookingId)
          .delete();
    } on FirebaseException catch (e) {
      throw Exception('Firebase error: $e');
    } catch (e) {
      throw Exception('Error removing booking: $e');
    }
  }

  @override
  Future<List<BookingModel>> getBookings() async {
    try {
      final querySnapshot =
          await db.collection(FirestoreCollections.bookings).get();
      final bookings = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return BookingModel.fromJson(data);
      }).toList();

      return bookings;
    } on FirebaseException catch (e) {
      throw Exception('Firebase error: $e');
    } catch (e) {
      throw Exception('Error fetching bookings: $e');
    }
  }
}
