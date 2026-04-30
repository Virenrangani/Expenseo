import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/features/calendar/presentation/cubit/calendar_cubit.dart';
import 'package:expenseo/features/calendar/presentation/widget/year_picker_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/colour/app_color.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalendarCubit(),
      child: const Scaffold(
        backgroundColor: AppColor.primary,
        body: SafeArea(
          child: Padding(
            padding: AppPadding.edgeSymmetricHori24,
            child: Row(
              children: [
                YearPickerPopup(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
