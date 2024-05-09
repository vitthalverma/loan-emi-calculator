part of 'loan_bloc.dart';

sealed class LoanEmiEvent {}

final class CalculateEmiEvent extends LoanEmiEvent {
  CalculateEmiEvent({
    required this.interestRate,
    required this.tenure,
    required this.principal,
  });
  final double principal;
  final double interestRate;
  final int tenure;
}
