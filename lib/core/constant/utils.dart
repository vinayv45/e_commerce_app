String getErrorMessage(String errorCode) {
  switch (errorCode) {
    case 'invalid-email':
      return 'The email address is badly formatted.';
    case 'user-disabled':
      return 'The user corresponding to the given email has been disabled.';
    case 'user-not-found':
      return 'No user corresponding to the given email.';
    case 'wrong-password':
      return 'The password is invalid for the given email.';
    case 'invalid-credential':
      return 'Invalid email or password.';
    default:
      return 'An unknown error occurred.';
  }
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) {
    return text;
  }
  return text[0].toUpperCase() + text.substring(1);
}

String normalize(String text) {
  return text.toLowerCase().trim();
}

String removeQuotes(String input) {
  return input.replaceAll(RegExp(r"^'(.*)'$"), '\$1');
}
