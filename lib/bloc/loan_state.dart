part of 'loan_bloc.dart';

sealed class LoanEmiState {}

final class LoanEmiInitial extends LoanEmiState {
  LoanEmiInitial({this.emi = 0.0});
  final double emi;
}

final class LoanEmiCalculatedState extends LoanEmiState {
  LoanEmiCalculatedState({required this.emi, this.totalPay});
  final double emi;
  final double? totalPay;
}
