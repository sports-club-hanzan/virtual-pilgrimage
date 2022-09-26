import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health/health.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  // Firebase 関連
  /// Firebase Authentication
  FirebaseAuth,
  UserCredential,
  User,
  GoogleSignIn,
  GoogleSignInAccount,
  GoogleSignInAuthentication,

  /// Cloud Firestore
  FirebaseFirestore,
  DocumentSnapshot,
  CollectionReference,
  DocumentReference,
  Query,
  QuerySnapshot,

  /// Others
  FirebaseAnalytics,
  FirebaseCrashlytics,

  // ヘルスケア
  HealthFactory,
])
void main() {}
