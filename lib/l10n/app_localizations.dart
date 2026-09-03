import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('hi'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Expenseo'**
  String get appName;

  /// No description provided for @totalBalance.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get totalBalance;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expense;

  /// No description provided for @recentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get recentTransactions;

  /// No description provided for @showAll.
  ///
  /// In en, this message translates to:
  /// **'Show All'**
  String get showAll;

  /// No description provided for @splitBill.
  ///
  /// In en, this message translates to:
  /// **'Split Bill'**
  String get splitBill;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving'**
  String get saving;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get personalInfo;

  /// No description provided for @myWallets.
  ///
  /// In en, this message translates to:
  /// **'My Wallets'**
  String get myWallets;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @supportAndLegal.
  ///
  /// In en, this message translates to:
  /// **'Support & Legal'**
  String get supportAndLegal;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @guestUser.
  ///
  /// In en, this message translates to:
  /// **'Guest User'**
  String get guestUser;

  /// No description provided for @loginRequired.
  ///
  /// In en, this message translates to:
  /// **'Login Required'**
  String get loginRequired;

  /// No description provided for @signInNow.
  ///
  /// In en, this message translates to:
  /// **'Sign In Now'**
  String get signInNow;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get hindi;

  /// No description provided for @key.
  ///
  /// In en, this message translates to:
  /// **'•'**
  String get key;

  /// No description provided for @key_2.
  ///
  /// In en, this message translates to:
  /// **'🇮🇳'**
  String get key_2;

  /// No description provided for @key_3.
  ///
  /// In en, this message translates to:
  /// **'🇸🇦'**
  String get key_3;

  /// No description provided for @key_4.
  ///
  /// In en, this message translates to:
  /// **'🇺🇸'**
  String get key_4;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @completeYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete Your Profile'**
  String get completeYourProfile;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @selectGender.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get selectGender;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtn;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get continueAsGuest;

  /// No description provided for @otpVerified.
  ///
  /// In en, this message translates to:
  /// **'OTP is verified'**
  String get otpVerified;

  /// No description provided for @addExpense.
  ///
  /// In en, this message translates to:
  /// **'Add Expense'**
  String get addExpense;

  /// No description provided for @expenseRemoved.
  ///
  /// In en, this message translates to:
  /// **'Expense Removed...!'**
  String get expenseRemoved;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered email address and we\'ll send you a verification code to reset your password.'**
  String get forgotPasswordDescription;

  /// No description provided for @sendOtp.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOtp;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @resetPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Create a new password for your account.\nMake sure it is strong and easy for you to remember.'**
  String get resetPasswordDescription;

  /// No description provided for @enterOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enterOtp;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// No description provided for @myBalance.
  ///
  /// In en, this message translates to:
  /// **'My Balance'**
  String get myBalance;

  /// No description provided for @totalIncome.
  ///
  /// In en, this message translates to:
  /// **'Total Income'**
  String get totalIncome;

  /// No description provided for @totalExpense.
  ///
  /// In en, this message translates to:
  /// **'Total Expense'**
  String get totalExpense;

  /// No description provided for @accessControl.
  ///
  /// In en, this message translates to:
  /// **'Access Control'**
  String get accessControl;

  /// No description provided for @appLockPin.
  ///
  /// In en, this message translates to:
  /// **'App Lock (PIN)'**
  String get appLockPin;

  /// No description provided for @biometricAuthentication.
  ///
  /// In en, this message translates to:
  /// **'Biometric Authentication'**
  String get biometricAuthentication;

  /// No description provided for @accountSecurity.
  ///
  /// In en, this message translates to:
  /// **'Account Security'**
  String get accountSecurity;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @twoFactorAuthentication.
  ///
  /// In en, this message translates to:
  /// **'Two-Factor Authentication'**
  String get twoFactorAuthentication;

  /// No description provided for @securityRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Protecting your financial data is our top priority. We recommend enabling Biometric Authentication for maximum security.'**
  String get securityRecommendation;

  /// No description provided for @disableAppLockTitle.
  ///
  /// In en, this message translates to:
  /// **'Disable App Lock?'**
  String get disableAppLockTitle;

  /// No description provided for @disableAppLockContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove the security PIN?'**
  String get disableAppLockContent;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @disable.
  ///
  /// In en, this message translates to:
  /// **'Disable'**
  String get disable;

  /// No description provided for @appIntro.
  ///
  /// In en, this message translates to:
  /// **'Enter your fluid vault.'**
  String get appIntro;

  /// No description provided for @logInIntro.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your\nAccount'**
  String get logInIntro;

  /// No description provided for @logInSubIntro.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and password to log in'**
  String get logInSubIntro;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get email;

  /// No description provided for @nameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameInvalid;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get signInWithGoogle;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAnAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @alReadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alReadyHaveAnAccount;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @signUpIntro.
  ///
  /// In en, this message translates to:
  /// **'Create your \n Narrative'**
  String get signUpIntro;

  /// No description provided for @signUpSubIntro.
  ///
  /// In en, this message translates to:
  /// **'Start your journey to financial clarity.'**
  String get signUpSubIntro;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @userNotVerify.
  ///
  /// In en, this message translates to:
  /// **'User is not verified'**
  String get userNotVerify;

  /// No description provided for @userLogin.
  ///
  /// In en, this message translates to:
  /// **'User is Logged In Successfully'**
  String get userLogin;

  /// No description provided for @verifyEmail.
  ///
  /// In en, this message translates to:
  /// **'Verify your email..!!'**
  String get verifyEmail;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Mail'**
  String get emailHint;

  /// No description provided for @emailNotContainsSpace.
  ///
  /// In en, this message translates to:
  /// **'Email should not contain spaces'**
  String get emailNotContainsSpace;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get emailInvalid;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get passwordHint;

  /// No description provided for @passwordNotContainsSpace.
  ///
  /// In en, this message translates to:
  /// **'Password should not contain spaces'**
  String get passwordNotContainsSpace;

  /// No description provided for @passwordMinChar.
  ///
  /// In en, this message translates to:
  /// **'Minimum 8 characters required'**
  String get passwordMinChar;

  /// No description provided for @atLeastOneUpperCase.
  ///
  /// In en, this message translates to:
  /// **'Add at least one uppercase letter'**
  String get atLeastOneUpperCase;

  /// No description provided for @atLeastOneLowerCase.
  ///
  /// In en, this message translates to:
  /// **'Add at least one lowercase letter'**
  String get atLeastOneLowerCase;

  /// No description provided for @atLeastOneNumber.
  ///
  /// In en, this message translates to:
  /// **'Add at least one number'**
  String get atLeastOneNumber;

  /// No description provided for @atLeastOneSpecialChar.
  ///
  /// In en, this message translates to:
  /// **'Add at least one special character'**
  String get atLeastOneSpecialChar;

  /// No description provided for @googleSignInFailed.
  ///
  /// In en, this message translates to:
  /// **'Google sign in failed'**
  String get googleSignInFailed;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User is not found'**
  String get userNotFound;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get invalidEmail;

  /// No description provided for @userDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled'**
  String get userDisabled;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password'**
  String get wrongPassword;

  /// No description provided for @emailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'Email is already registered'**
  String get emailAlreadyInUse;

  /// No description provided for @operationNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Operation not allowed'**
  String get operationNotAllowed;

  /// No description provided for @accountExistsWithDifferentCredential.
  ///
  /// In en, this message translates to:
  /// **'Account exists with different sign-in method'**
  String get accountExistsWithDifferentCredential;

  /// No description provided for @invalidCredential.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials'**
  String get invalidCredential;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @goodNight.
  ///
  /// In en, this message translates to:
  /// **'Good Night 🌛'**
  String get goodNight;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning ☀️'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon 🌤️'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening 🌙'**
  String get goodEvening;

  /// No description provided for @recentTransaction.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get recentTransaction;

  /// No description provided for @allExpenses.
  ///
  /// In en, this message translates to:
  /// **'All Expenses'**
  String get allExpenses;

  /// No description provided for @addIncome.
  ///
  /// In en, this message translates to:
  /// **'Add Income'**
  String get addIncome;

  /// No description provided for @addAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter Amount'**
  String get addAmount;

  /// No description provided for @split.
  ///
  /// In en, this message translates to:
  /// **'Split'**
  String get split;

  /// No description provided for @invest.
  ///
  /// In en, this message translates to:
  /// **'Investment'**
  String get invest;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @permissionDenied.
  ///
  /// In en, this message translates to:
  /// **'This account uses Google Sign-In. Please continue with Google.'**
  String get permissionDenied;

  /// No description provided for @dataNotFound.
  ///
  /// In en, this message translates to:
  /// **'Requested data was not found.'**
  String get dataNotFound;

  /// No description provided for @dataAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'This data already exists.'**
  String get dataAlreadyExists;

  /// No description provided for @resourceExhausted.
  ///
  /// In en, this message translates to:
  /// **'Service limit reached. Please try again later.'**
  String get resourceExhausted;

  /// No description provided for @serviceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Service is currently unavailable. Please try again later.'**
  String get serviceUnavailable;

  /// No description provided for @operationCancelled.
  ///
  /// In en, this message translates to:
  /// **'Operation was cancelled. Please try again.'**
  String get operationCancelled;

  /// No description provided for @timeout.
  ///
  /// In en, this message translates to:
  /// **'Request timed out. Please check your internet connection.'**
  String get timeout;

  /// No description provided for @invalidArgument.
  ///
  /// In en, this message translates to:
  /// **'Invalid data provided. Please check and try again.'**
  String get invalidArgument;

  /// No description provided for @operationAborted.
  ///
  /// In en, this message translates to:
  /// **'Operation failed. Please try again.'**
  String get operationAborted;

  /// No description provided for @amountRequired.
  ///
  /// In en, this message translates to:
  /// **'Amount is required'**
  String get amountRequired;

  /// No description provided for @amountInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid amount'**
  String get amountInvalid;

  /// No description provided for @amountGreaterThanZero.
  ///
  /// In en, this message translates to:
  /// **'Amount must be greater than 0'**
  String get amountGreaterThanZero;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @titleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Lunch, Salary...'**
  String get titleHint;

  /// No description provided for @titleInvalid.
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get titleInvalid;

  /// No description provided for @expenseAdded.
  ///
  /// In en, this message translates to:
  /// **'Expense is added..!'**
  String get expenseAdded;

  /// No description provided for @noExpenseYet.
  ///
  /// In en, this message translates to:
  /// **'No expenses yet'**
  String get noExpenseYet;

  /// No description provided for @addFirstExpense.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add your first expense'**
  String get addFirstExpense;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @emailVarification.
  ///
  /// In en, this message translates to:
  /// **'Email Verification'**
  String get emailVarification;

  /// No description provided for @emailVarificationInto.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit OTP sent to your registered email address.'**
  String get emailVarificationInto;

  /// No description provided for @verifyOtp.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get verifyOtp;

  /// No description provided for @otpExpireIn10Min.
  ///
  /// In en, this message translates to:
  /// **'OTP expires within 10 minutes'**
  String get otpExpireIn10Min;

  /// No description provided for @notReceivingOtp.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the OTP? '**
  String get notReceivingOtp;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtp;

  /// No description provided for @groupName.
  ///
  /// In en, this message translates to:
  /// **'Group name'**
  String get groupName;

  /// No description provided for @groupHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Goa Trip, Flatmates...'**
  String get groupHint;

  /// No description provided for @addMember.
  ///
  /// In en, this message translates to:
  /// **'Add Members'**
  String get addMember;

  /// No description provided for @createGroup.
  ///
  /// In en, this message translates to:
  /// **'Create Group'**
  String get createGroup;

  /// No description provided for @youCanNotAddYourSelf.
  ///
  /// In en, this message translates to:
  /// **'You can not add yourself'**
  String get youCanNotAddYourSelf;

  /// No description provided for @groupCreated.
  ///
  /// In en, this message translates to:
  /// **'Group is created successfully'**
  String get groupCreated;

  /// No description provided for @addAtLeastOneMember.
  ///
  /// In en, this message translates to:
  /// **'Add at least one member'**
  String get addAtLeastOneMember;

  /// No description provided for @enterGroupName.
  ///
  /// In en, this message translates to:
  /// **'Enter group name'**
  String get enterGroupName;

  /// No description provided for @settled.
  ///
  /// In en, this message translates to:
  /// **'Settled'**
  String get settled;

  /// No description provided for @youOwed.
  ///
  /// In en, this message translates to:
  /// **'you are owed'**
  String get youOwed;

  /// No description provided for @owe.
  ///
  /// In en, this message translates to:
  /// **'you owe'**
  String get owe;

  /// No description provided for @owesYou.
  ///
  /// In en, this message translates to:
  /// **'Owes You'**
  String get owesYou;

  /// No description provided for @noGroups.
  ///
  /// In en, this message translates to:
  /// **'No groups yet'**
  String get noGroups;

  /// No description provided for @noExpense.
  ///
  /// In en, this message translates to:
  /// **'No expenses yet'**
  String get noExpense;

  /// No description provided for @createYourGroup.
  ///
  /// In en, this message translates to:
  /// **'Tap + to create your first group'**
  String get createYourGroup;

  /// No description provided for @addYourFirstExpense.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add your first expense'**
  String get addYourFirstExpense;

  /// No description provided for @myGroups.
  ///
  /// In en, this message translates to:
  /// **'My Groups'**
  String get myGroups;

  /// No description provided for @paidBy.
  ///
  /// In en, this message translates to:
  /// **'Paid by'**
  String get paidBy;

  /// No description provided for @splitType.
  ///
  /// In en, this message translates to:
  /// **'Split Type'**
  String get splitType;

  /// No description provided for @splitAmong.
  ///
  /// In en, this message translates to:
  /// **'Split Among'**
  String get splitAmong;

  /// No description provided for @splitAmountNotEquals.
  ///
  /// In en, this message translates to:
  /// **'Split amounts must equal'**
  String get splitAmountNotEquals;

  /// No description provided for @splitAmountMust100Per.
  ///
  /// In en, this message translates to:
  /// **'Percentages must add up to 100%'**
  String get splitAmountMust100Per;

  /// No description provided for @allSettleUp.
  ///
  /// In en, this message translates to:
  /// **'All settled up!'**
  String get allSettleUp;

  /// No description provided for @settleUp.
  ///
  /// In en, this message translates to:
  /// **'Settle up'**
  String get settleUp;

  /// No description provided for @markSettle.
  ///
  /// In en, this message translates to:
  /// **'Mark as settled?'**
  String get markSettle;

  /// No description provided for @settleBalance.
  ///
  /// In en, this message translates to:
  /// **'Settlement Balance!'**
  String get settleBalance;

  /// No description provided for @groupDeleted.
  ///
  /// In en, this message translates to:
  /// **'Group deleted!'**
  String get groupDeleted;

  /// No description provided for @goal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get goal;

  /// No description provided for @goalImage.
  ///
  /// In en, this message translates to:
  /// **'Goal Image'**
  String get goalImage;

  /// No description provided for @goalHint.
  ///
  /// In en, this message translates to:
  /// **'Name of goal'**
  String get goalHint;

  /// No description provided for @targetAmount.
  ///
  /// In en, this message translates to:
  /// **'Target Amount'**
  String get targetAmount;

  /// No description provided for @targetAmountGoal.
  ///
  /// In en, this message translates to:
  /// **'Target amount for goal'**
  String get targetAmountGoal;

  /// No description provided for @newSavingGoal.
  ///
  /// In en, this message translates to:
  /// **'New Saving Goal'**
  String get newSavingGoal;

  /// No description provided for @addGoal.
  ///
  /// In en, this message translates to:
  /// **'Add Goal'**
  String get addGoal;

  /// No description provided for @goalRequired.
  ///
  /// In en, this message translates to:
  /// **'Goal is required'**
  String get goalRequired;

  /// No description provided for @goalImageRequired.
  ///
  /// In en, this message translates to:
  /// **'Goal image is required'**
  String get goalImageRequired;

  /// No description provided for @goalCreate.
  ///
  /// In en, this message translates to:
  /// **'Goal is created!'**
  String get goalCreate;

  /// No description provided for @addSaving.
  ///
  /// In en, this message translates to:
  /// **'Add Saving'**
  String get addSaving;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @savingAmountAdded.
  ///
  /// In en, this message translates to:
  /// **'Saving amount is added..!!'**
  String get savingAmountAdded;

  /// No description provided for @pinsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'PINs do not match. Start over.'**
  String get pinsDoNotMatch;

  /// No description provided for @authenticateToAccess.
  ///
  /// In en, this message translates to:
  /// **'Authenticate to access Expenseo'**
  String get authenticateToAccess;

  /// No description provided for @confirmPin.
  ///
  /// In en, this message translates to:
  /// **'Confirm PIN'**
  String get confirmPin;

  /// No description provided for @secureYourApp.
  ///
  /// In en, this message translates to:
  /// **'Secure Your App'**
  String get secureYourApp;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @create4DigitPin.
  ///
  /// In en, this message translates to:
  /// **'Create a 4-digit PIN'**
  String get create4DigitPin;

  /// No description provided for @enterPinToUnlock.
  ///
  /// In en, this message translates to:
  /// **'Enter PIN to unlock'**
  String get enterPinToUnlock;

  /// No description provided for @searchYourExpense.
  ///
  /// In en, this message translates to:
  /// **'Search your Expense..'**
  String get searchYourExpense;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get food;

  /// No description provided for @shopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get shopping;

  /// No description provided for @transport.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get transport;

  /// No description provided for @health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// No description provided for @entertainment.
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get entertainment;

  /// No description provided for @salary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get salary;

  /// No description provided for @rent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get rent;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @upi.
  ///
  /// In en, this message translates to:
  /// **'Upi'**
  String get upi;

  /// No description provided for @card.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get card;

  /// No description provided for @netBanking.
  ///
  /// In en, this message translates to:
  /// **'NetBanking'**
  String get netBanking;

  /// No description provided for @passwordResetLinkSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset link sent to your email'**
  String get passwordResetLinkSent;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @savings.
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get savings;

  /// No description provided for @savingGoals.
  ///
  /// In en, this message translates to:
  /// **'Saving Goals'**
  String get savingGoals;

  /// No description provided for @depositHistory.
  ///
  /// In en, this message translates to:
  /// **'Deposit History'**
  String get depositHistory;

  /// No description provided for @goalDetails.
  ///
  /// In en, this message translates to:
  /// **'Goal Details'**
  String get goalDetails;

  /// No description provided for @savingsJourneyLaunchpad.
  ///
  /// In en, this message translates to:
  /// **'Your savings journey is waiting on the launchpad.\nSet your first goal and let\'s take off!'**
  String get savingsJourneyLaunchpad;

  /// No description provided for @addGroupExpense.
  ///
  /// In en, this message translates to:
  /// **'Add Group Expense....'**
  String get addGroupExpense;

  /// No description provided for @members.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get members;

  /// No description provided for @newSplit.
  ///
  /// In en, this message translates to:
  /// **'New Split'**
  String get newSplit;

  /// No description provided for @whatWasThisFor.
  ///
  /// In en, this message translates to:
  /// **'What was this for?'**
  String get whatWasThisFor;

  /// No description provided for @noGroupsYet.
  ///
  /// In en, this message translates to:
  /// **'No groups yet'**
  String get noGroupsYet;

  /// No description provided for @allBalancesSettled.
  ///
  /// In en, this message translates to:
  /// **'All balances are settled! 🎉'**
  String get allBalancesSettled;

  /// No description provided for @totalGroupExpense.
  ///
  /// In en, this message translates to:
  /// **'Total Group Expense'**
  String get totalGroupExpense;

  /// No description provided for @youOwe.
  ///
  /// In en, this message translates to:
  /// **'You Owe'**
  String get youOwe;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @splitBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Split breakdown'**
  String get splitBreakdown;

  /// No description provided for @noExpensesYet.
  ///
  /// In en, this message translates to:
  /// **'No expenses yet!'**
  String get noExpensesYet;

  /// No description provided for @membersLabel.
  ///
  /// In en, this message translates to:
  /// **'Members:'**
  String get membersLabel;

  /// No description provided for @createdLabel.
  ///
  /// In en, this message translates to:
  /// **'Created:'**
  String get createdLabel;

  /// No description provided for @amountExceeded.
  ///
  /// In en, this message translates to:
  /// **'Amount Exceeded'**
  String get amountExceeded;

  /// No description provided for @perfectlySplit.
  ///
  /// In en, this message translates to:
  /// **'Perfectly Split'**
  String get perfectlySplit;

  /// No description provided for @remainingAmount.
  ///
  /// In en, this message translates to:
  /// **'Remaining Amount'**
  String get remainingAmount;

  /// No description provided for @equal.
  ///
  /// In en, this message translates to:
  /// **'Equal'**
  String get equal;

  /// No description provided for @unequal.
  ///
  /// In en, this message translates to:
  /// **'Unequal'**
  String get unequal;

  /// No description provided for @percent.
  ///
  /// In en, this message translates to:
  /// **'Percent'**
  String get percent;

  /// No description provided for @sessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please log in again.'**
  String get sessionExpired;

  /// No description provided for @invalidPin.
  ///
  /// In en, this message translates to:
  /// **'Invalid PIN. Please try again.'**
  String get invalidPin;

  /// Message shown when a guest tries to access a restricted feature
  ///
  /// In en, this message translates to:
  /// **'To use {featureName}, you need to sign in to your account. This ensures your data is saved securely.'**
  String loginRequiredDescription(String featureName);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
