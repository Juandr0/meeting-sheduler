import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_scheduler/features/booking/data/datasources/remote/booking_remote_datasource_impl.dart';
import 'package:meeting_scheduler/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:meeting_scheduler/features/booking/domain/usecases/create_booking_usecase.dart';
import 'package:meeting_scheduler/features/booking/domain/usecases/delete_booking_usecase.dart';
import 'package:meeting_scheduler/features/booking/domain/usecases/get_bookings_usecase.dart';
import 'package:meeting_scheduler/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:meeting_scheduler/features/booking/presentation/screens/booking_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Skapa instanser av datalager och usecases
    final remoteDataSource = BookingRemoteDataSourceImpl();
    final repository = BookingRepositoryImpl(remoteDataSource);
    final getBookingsUseCase = GetBookingsUseCase(repository);
    final createBookingUseCase = CreateBookingUseCase(repository);
    final deleteBookingUseCase = DeleteBookingUseCase(repository);

    return MultiBlocProvider(
      providers: [
        BlocProvider<BookingBloc>(
          create: (_) => BookingBloc(
            getBookings: getBookingsUseCase,
            createBooking: createBookingUseCase,
            deleteBooking: deleteBookingUseCase,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Mötesrumsbokare',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const BookingScreen(),
      ),
    );
  }
}
