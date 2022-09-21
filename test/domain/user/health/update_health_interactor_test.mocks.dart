// Mocks generated by Mockito 5.3.0 from annotations
// in virtualpilgrimage/test/domain/user/health/update_health_interactor_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:virtualpilgrimage/domain/user/health/health_info.codegen.dart'
    as _i2;
import 'package:virtualpilgrimage/domain/user/health/health_repository.dart'
    as _i3;
import 'package:virtualpilgrimage/domain/user/user_repository.dart' as _i5;
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart'
    as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeHealthInfo_0 extends _i1.SmartFake implements _i2.HealthInfo {
  _FakeHealthInfo_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [HealthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockHealthRepository extends _i1.Mock implements _i3.HealthRepository {
  MockHealthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.HealthInfo> getHealthInfo(
          {DateTime? targetDateTime, DateTime? createdAt}) =>
      (super
          .noSuchMethod(Invocation.method(#getHealthInfo, [], {#targetDateTime: targetDateTime, #createdAt: createdAt}),
              returnValue: _i4.Future<_i2.HealthInfo>.value(_FakeHealthInfo_0(
                  this,
                  Invocation.method(#getHealthInfo, [], {
                    #targetDateTime: targetDateTime,
                    #createdAt: createdAt
                  })))) as _i4.Future<_i2.HealthInfo>);
}

/// A class which mocks [UserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepository extends _i1.Mock implements _i5.UserRepository {
  MockUserRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i6.VirtualPilgrimageUser?> get(String? userId) =>
      (super.noSuchMethod(Invocation.method(#get, [userId]),
              returnValue: _i4.Future<_i6.VirtualPilgrimageUser?>.value())
          as _i4.Future<_i6.VirtualPilgrimageUser?>);
  @override
  _i4.Future<_i6.VirtualPilgrimageUser?> findWithNickname(String? nickname) =>
      (super.noSuchMethod(Invocation.method(#findWithNickname, [nickname]),
              returnValue: _i4.Future<_i6.VirtualPilgrimageUser?>.value())
          as _i4.Future<_i6.VirtualPilgrimageUser?>);
  @override
  _i4.Future<void> update(_i6.VirtualPilgrimageUser? user) =>
      (super.noSuchMethod(Invocation.method(#update, [user]),
              returnValue: _i4.Future<void>.value(),
              returnValueForMissingStub: _i4.Future<void>.value())
          as _i4.Future<void>);
}