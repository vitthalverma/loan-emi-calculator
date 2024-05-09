import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_emi/bloc/loan_bloc.dart';
import 'package:loan_emi/presentation/widgets/value_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _currentLoanValue = 100000;
  int _currentYearsValue = 1;
  double _currentInterestValue = 0.5;
  final _loanController = TextEditingController();
  final _yearsController = TextEditingController();
  final _interestController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        centerTitle: true,
        title: const Text(
          'Loan EMI Calculator',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            //   fontSize: 16.sp,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 14.w),
        child: Column(
          children: [
            ValuePicker(
              controller: _loanController,
              title: 'Loan Amount',
              lowRange: '₹ 1 Lac',
              highRange: '₹ 1 Cr',
              icon: Icon(
                Icons.currency_rupee_rounded,
                size: 16.sp,
              ),
              minValue: 100000,
              maxValue: 10000000,
              sliderValue: _currentLoanValue,
              onSiderValueChanged: (value) {
                setState(() {
                  _currentLoanValue = value;
                  _loanController.text = _currentLoanValue.toInt().toString();
                });
              },
            ),
            ValuePicker(
              controller: _yearsController,
              title: 'Tenure(Years)',
              lowRange: '1',
              highRange: '30',
              maxValue: 30,
              minValue: 1,
              sliderValue: _currentYearsValue.toDouble(),
              onSiderValueChanged: (value) {
                setState(() {
                  _currentYearsValue = value.toInt();
                  _yearsController.text = _currentYearsValue.toInt().toString();
                });
              },
            ),
            ValuePicker(
              controller: _interestController,
              title: 'Interest Rate(% P.A)',
              lowRange: '0.5',
              highRange: '15',
              minValue: 0.5,
              maxValue: 15,
              sliderValue: _currentInterestValue,
              onSiderValueChanged: (value) {
                setState(() {
                  _currentInterestValue = value;
                  _interestController.text =
                      _currentInterestValue.toStringAsFixed(1);
                });
              },
            ),
            SizedBox(height: 3.h),
            InkWell(
              onTap: () {
                context.read<LoanBloc>().add(CalculateEmiEvent(
                      interestRate: _currentInterestValue,
                      tenure: _currentYearsValue,
                      principal: _currentLoanValue,
                    ));
              },
              child: Container(
                height: 6.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.w),
                  color: Colors.brown,
                ),
                child: const Center(
                  child: Text(
                    'Calculate EMI',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Monthly Home Loan EMI :'),
                BlocBuilder<LoanBloc, LoanEmiState>(
                  builder: (context, state) {
                    if (state is LoanEmiCalculatedState) {
                      return Text(
                        '₹ ${state.emi.toInt()}',
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 17.sp,
                        ),
                      );
                    }
                    if (state is LoanEmiInitial) {
                      return Text(
                        '₹ ${state.emi.toInt()}',
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 17.sp,
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount Payable :',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                BlocBuilder<LoanBloc, LoanEmiState>(
                  builder: (context, state) {
                    if (state is LoanEmiCalculatedState) {
                      return Text(
                        '₹${state.totalPay!.toInt()}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                          fontSize: 18.sp,
                        ),
                      );
                    }
                    return Text(
                      '₹' '0',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                        fontSize: 18.sp,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
