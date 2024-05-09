import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class ValuePicker extends StatefulWidget {
  ValuePicker({
    super.key,
    required this.title,
    this.icon,
    required this.lowRange,
    required this.highRange,
    required this.minValue,
    required this.maxValue,
    required this.sliderValue,
    required this.onSiderValueChanged,
    required this.controller,
  });
  final String title;
  final Icon? icon;
  final String lowRange;
  final String highRange;
  final double minValue;
  final double maxValue;
  double sliderValue;
  final void Function(double) onSiderValueChanged;
  final TextEditingController controller;

  @override
  State<ValuePicker> createState() => _ValuePickerState();
}

class _ValuePickerState extends State<ValuePicker> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateSliderValue);
  }

  void _updateSliderValue() {
    double value = double.tryParse(widget.controller.text) ?? widget.minValue;
    value = value.clamp(widget.minValue, widget.maxValue);
    setState(() {
      widget.sliderValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 4.h,
                width: 35.w,
                child: TextField(
                  onChanged: (value) {
                    _updateSliderValue();
                  },
                  controller: widget.controller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(1.w),
                    prefixIcon: widget.icon,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Slider(
            value: widget.sliderValue,
            min: widget.minValue,
            max: widget.maxValue,
            onChanged: widget.onSiderValueChanged,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.lowRange),
              Text(widget.highRange),
            ],
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
