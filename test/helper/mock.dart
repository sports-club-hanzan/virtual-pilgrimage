import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health/health.dart';
import 'package:http/http.dart' as http;
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
  Reference,
  Query,
  QuerySnapshot,

  /// Firebase Storage
  FirebaseStorage,
  UploadTask,
  TaskSnapshot,

  /// Others
  FirebaseAnalytics,
  FirebaseCrashlytics,

  // ヘルスケア
  HealthFactory,

  // Others
  File,
  http.Client,
])
void main() {}
