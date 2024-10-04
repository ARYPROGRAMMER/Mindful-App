import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _googlesignin = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() {
    _googlesignin.forceCodeForRefreshToken;
    return _googlesignin.signIn();
  }

  static GoogleSignInAccount? details() => _googlesignin.currentUser;
  static Future logout() => _googlesignin.disconnect();
}
