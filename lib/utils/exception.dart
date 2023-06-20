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
class LoginWithEmailAndPasswordFailure {
  final String message;

  const LoginWithEmailAndPasswordFailure(
      [this.message = "An unknown error occurred."]);

  factory LoginWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LoginWithEmailAndPasswordFailure(
            'Please enter a valid email address.');
      case 'user-not-found':
        return const LoginWithEmailAndPasswordFailure(
            'User not found. Please check your email address.');
      case 'wrong-password':
        return const LoginWithEmailAndPasswordFailure(
            'Invalid password. Please try again.');
      case 'user-disabled':
        return const LoginWithEmailAndPasswordFailure(
            'This user has been disabled.');
      case 'too-many-requests':
        return const LoginWithEmailAndPasswordFailure(
            'Too many unsuccessful login attempts. Please try again later.');
      // Add more cases for specific error codes as needed
      default:
        return const LoginWithEmailAndPasswordFailure();
    }
  }
}
