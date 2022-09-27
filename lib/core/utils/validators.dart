String? validateEmailField(String? email) {
  if (email == null || email.isEmpty || !email.contains('@')) {
    return 'Enter Valid Email';
  }
  return null;
}

String? validatePasswordField(String? password) {
  if (password == null || password.isEmpty || password.length < 6) {
    return 'Password must contain atleast 6 characters';
  }
  return null;
}

String? validateFullNameField(String? fullName) {
  if (fullName == null || fullName.isEmpty) {
    return 'Enter Valid Full Name';
  }
  return null;
}

String? validateCityField(String? city) {
  if (city == null || city.isEmpty) {
    return 'Enter Valid City';
  }
  return null;
}

String? validateAddressField(String? city) {
  if (city == null || city.isEmpty) {
    return 'Enter Valid Address';
  }
  return null;
}

String? validateContactField(String? contact) {
  if (contact == null || contact.isEmpty) {
    return 'Enter Valid Contact';
  }
  return null;
}

String? validateGenderField(String? gender) {
  if (gender == null || gender.isEmpty) {
    return 'Enter Valid Gender';
  }
  return null;
}
