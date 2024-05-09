import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'loan_event.dart';
part 'loan_state.dart';

class LoanBloc extends Bloc<LoanEmiEvent, LoanEmiState> {
  LoanBloc() : super(LoanEmiInitial()) {
    double calculateEMI(double principal, int tenure, double interestRate) {
      double emi =
          (principal * interestRate * (pow(1 + interestRate, tenure))) /
              ((pow(1 + interestRate, tenure)) - 1);
      return emi;
    }

    on<CalculateEmiEvent>((event, emit) {
      try {
        double emi = calculateEMI(
          event.principal,
          (event.tenure * 12),
          event.interestRate / 12 / 100,
        );
        double totalPay = emi * event.tenure * 12;
        if (kDebugMode) {
          print(emi.toString());
        }
        emit(LoanEmiCalculatedState(emi: emi, totalPay: totalPay));
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    });
  }
}
