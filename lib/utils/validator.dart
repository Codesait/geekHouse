/// Class of validation functions that the app will use
///   - This class should be used as a mixin using the `with` keyword
class Validators {
  final phoneNumberRegExp = RegExp(
    r'^(\+\d{2,3}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$',
  );
  final emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  );
  final dateRegExp = RegExp(r'^\d{2}/\d{2}/\d{4}$');
  final zipCodeRegExp = RegExp(r'^[0-9]{5}(?:-[0-9]{4})?$');
  final mustContainCapital = RegExp('^(?=.*?[A-Z])');
  final mustContainNumber = RegExp('^(?=.*?[0-9])');
  final mustContainCharacter = RegExp(r'^(?=.*?[#?!@$%^&*-])');
  final achFormatAcctNumberRegExp = RegExp(r'^\d{8,17}$');
  final routingNumberRegExp = RegExp(r'^\d{9}$');

  String? validateEmail(String? value) {
    if (value!.trim().isEmpty) {
      return 'Email cannot be empty';
    } else if (!emailRegExp.hasMatch(value.trim())) {
      return 'Email is invalid';
    }
    return null;
  }

  String? validateEmailOrPhoneNumber(String? value) {
    if (emailRegExp.hasMatch(value!.trim()) ||
        phoneNumberRegExp.hasMatch(value.trim())) {
      return null;
    } else {
      return 'Enter valid Email or PhoneNumber(e.g\n123-456-7890)';
    }
  }

  String? validatePhoneNumber(String? value) {
    if (value!.trim().isEmpty) {
      return 'Phone number cannot be empty';
    } else if (!phoneNumberRegExp.hasMatch(value.trim())) {
      return 'Phone number is invalid';
    }
    return null;
  }

  String? validateAmountInput(String? value, int balance) {
    if (value!.trim().isEmpty) {
      return 'Amount cannot be empty';
    } else if (int.parse(value) > balance) {
      return 'Insufficient Balance';
    }
    return null;
  }

  String? validateAchAcctNumber(String? value) {
    if (value!.trim().isEmpty) {
      return 'This field cannot be empty';
    } else if (!achFormatAcctNumberRegExp.hasMatch(value)) {
      return 'Invalid Account Number';
    }
    return null;
  }

  String? confirmAchAcctNumber(String? value, String? newValue) {
    if (value!.trim().isEmpty) {
      return 'This field cannot be empty';
    } else if (!achFormatAcctNumberRegExp.hasMatch(value)) {
      return 'Invalid Account Number';
    } else if (value.trim() != (newValue ?? '').trim()) {
      return 'Account Number does not match';
    }
    return null;
  }

  String? validateRoutingNumber(String? value) {
    if (value!.trim().isEmpty) {
      return 'Routing Number cannot be empty';
    } else if (value.length != 9) {
      return 'Routing Number is a 9 digit number';
    }
    return null;
  }

  String? validateZip(String? value) {
    if (value!.trim().isEmpty) {
      return 'Zip code cannot be empty';
    } else if (!zipCodeRegExp.hasMatch(value.trim())) {
      return 'Zip code is invalid';
    }
    return null;
  }

  String? validateInteger(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a value';
    }
    final numericValue = int.tryParse(value);
    if (numericValue == null || numericValue <= 0) {
      return 'Please enter a positive number';
    }
    return null;
  }

  String? validateAcctNo(String? value) {
    if (value!.trim().isEmpty) {
      return 'Account Number cannot be empty';
    } else if (value.length != 10) {
      return 'Account Number is a q0 digit number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.trim().isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 8) {
      return 'Password is too short';
    } else if (!mustContainCapital.hasMatch(value.trim())) {
      return 'Password must contain at least one upper case';
    } else if (!mustContainNumber.hasMatch(value.trim())) {
      return 'Password must contain at least one digit';
    } else if (!mustContainCharacter.hasMatch(value.trim())) {
      return 'at least one special character';
    }
    return null;
  }

  String? validatePin(String? value) {
    if (value!.trim().isEmpty) {
      return 'Pin cannot be empty';
    } else if (!mustContainNumber.hasMatch(value.trim())) {
      return 'Pin must be 4 digit';
    } else if (value.length > 4) {
      return 'pin cannot be more than 4 digits';
    }
    return null;
  }

  String? confirmPin(String? value, String? newValue) {
    if (value!.trim() != (newValue ?? '').trim()) {
      return 'pin does not match';
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String? newValue) {
    if (value!.trim() != (newValue ?? '').trim()) {
      return 'Password does not match';
    }
    return null;
  }

  String? validateEmptyTextField(String? value) {
    if (value!.trim().isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  String? validateShippingAdrress({String? street}) {
    if (street == '') {
      return 'Invalid Address, please select a valid\nshipping address';
    }
    return null;
  }

  String? validateDate(String? value) {
    if (value!.trim().isEmpty) {
      return 'Date cannot be empty';
    } else if (!dateRegExp.hasMatch(value.trim())) {
      return 'Date is invalid.\nFormat: 10/05/2015(DD/MM/YYYY)';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value!.trim().isEmpty) {
      return 'This field cannot be empty';
    } else if (value.contains(' ')) {
      return 'This field cannot contain blank spaces';
    } else if (RegExp(r'[!@#,.<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
      return 'This field can only contains alphabets';
    }
    return null;
  }

  String? validateUserName(String? value) {
    if (value!.trim().isEmpty) {
      return 'This field cannot be empty';
    } else if (value.contains(' ')) {
      return 'This field cannot contain blank spaces';
    } else if (value.length <= 4) {
      return 'Username too small';
    }
    return null;
  }

  String? validateReferralCode(String? value) {
    if (value!.trim().isEmpty) {
      return 'Referral code is required';
    } else if (value.length <= 7) {
      return 'Invalid referral code';
    }
    return null;
  }
}

/// validation for cards visa or master
