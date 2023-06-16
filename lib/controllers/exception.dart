class SignUpWithEmailAndPasswordFailure {
  final String message;

  const SignUpWithEmailAndPasswordFailure(
      [this.message = "An unknown error occurred."]);

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
            'Please enter a stronger password.');
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
            'The email address is already in use.');
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
            'Please enter a valid email address.');
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
            'This user has been disabled');
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
            'Operation is not allowed. Please contact support.');
      // Add more cases for specific error codes as needed
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}
