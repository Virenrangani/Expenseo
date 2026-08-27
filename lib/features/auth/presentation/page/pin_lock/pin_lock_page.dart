import 'package:expenseo/core/extension/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_plus_keyboard/pin_plus_keyboard.dart';

import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/gap/app_gap.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/security/logic/security_cubit.dart';
import '../../../../../core/security/logic/security_state.dart';

class PinLockPage extends StatefulWidget {
  final bool isSetupMode;

  const PinLockPage({super.key, this.isSetupMode = false});

  @override
  State<PinLockPage> createState() => _PinLockPageState();
}

class _PinLockPageState extends State<PinLockPage>
    with SingleTickerProviderStateMixin {
  final PinInputController _pinInputController = PinInputController(length: 4);
  String _firstPin = '';
  bool _isConfirming = false;
  String _errorMessage = '';

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _shakeAnimation =
        Tween<double>(
            begin: 0,
            end: 12,
          ).chain(CurveTween(curve: Curves.elasticIn)).animate(_shakeController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _shakeController.reverse();
            }
          });
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _pinInputController.dispose();
    super.dispose();
  }

  Future<void> _handlePinComplete() async {
    final enteredPin = _pinInputController.text;
    final cubit = context.read<SecurityCubit>();

    if (widget.isSetupMode) {
      if (!_isConfirming) {
        setState(() {
          _firstPin = enteredPin;
          _pinInputController.clear();
          _isConfirming = true;
        });
      } else {
        if (enteredPin == _firstPin) {
          await cubit.setupPin(enteredPin);
          if (mounted && Navigator.canPop(context)) context.pop(context);
        } else {
          _triggerError(context.l10n.pinsDoNotMatch);
          setState(() {
            _isConfirming = false;
            _firstPin = '';
            _pinInputController.clear();
          });
        }
      }
    } else {
      await cubit.authenticateWithPin(enteredPin);
    }
  }

  void _triggerError(String message) {
    HapticFeedback.vibrate();
    _shakeController.forward(from: 0);
    setState(() {
      _errorMessage = message;
      _pinInputController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: BlocListener<SecurityCubit, SecurityState>(
          listener: (context, state) {
            if (state is SecurityError) {
              _triggerError(state.message);
            }
            if (state is SecurityLocked) {
              setState(() {
                _pinInputController.clear();
                _errorMessage = '';
                _isConfirming = false;
                _firstPin = '';
              });
            }
          },
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                const Icon(
                  Icons.lock_outline_rounded,
                  size: 68,
                  color: AppColor.primary,
                ),
                AppGap.g24,
                Text(
                  _getTitle(),
                  style: AppTextStyles.h4().copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                AppGap.g8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    _getSubTitle(),
                    style: AppTextStyles.bodyMedium(),
                    textAlign: TextAlign.center,
                  ),
                ),
                AppGap.g32,

                AnimatedBuilder(
                  animation: _shakeAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_shakeAnimation.value, 0),
                      child: child,
                    );
                  },
                  child: Container(
                    width: screenWidth,
                    alignment: Alignment.center,
                    child: PinPlusKeyBoardPackage(
                      pinInputController: _pinInputController,
                      spacing: screenWidth * 0.08,
                      keyboardButtonShape: KeyboardButtonShape.circular,
                      buttonFillColor: Colors.grey.shade50,
                      btnElevation: 0,
                      btnTextColor: AppColor.textPrimary,

                      enableBiometric: !widget.isSetupMode,
                      biometricReason: context.l10n.authenticateToAccess,
                      onBiometricSuccess: () {
                        context.read<SecurityCubit>().markAuthenticated();
                      },

                      onSubmit: _handlePinComplete,
                    ),
                  ),
                ),

                if (_errorMessage.isNotEmpty) ...[
                  AppGap.g16,
                  Text(
                    _errorMessage,
                    style: AppTextStyles.bodySmall(color: AppColor.error),
                    textAlign: TextAlign.center,
                  ),
                ],

                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTitle() => widget.isSetupMode
      ? (_isConfirming ? context.l10n.confirmPin : context.l10n.secureYourApp)
      : context.l10n.welcomeBack;
  String _getSubTitle() => widget.isSetupMode
      ? context.l10n.create4DigitPin
      : context.l10n.enterPinToUnlock;
}
