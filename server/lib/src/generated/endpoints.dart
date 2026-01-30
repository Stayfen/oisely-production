/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../auth/email_idp_endpoint.dart' as _i2;
import '../auth/jwt_refresh_endpoint.dart' as _i3;
import '../endpoints/animal_identification_endpoint.dart' as _i4;
import '../endpoints/behavior_analysis_endpoint.dart' as _i5;
import '../endpoints/care_plan_endpoint.dart' as _i6;
import '../endpoints/magic_link_endpoint.dart' as _i7;
import '../endpoints/nearby_services_endpoint.dart' as _i8;
import '../greetings/greeting_endpoint.dart' as _i9;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i10;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i11;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i12;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'emailIdp': _i2.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i3.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'animalIdentification': _i4.AnimalIdentificationEndpoint()
        ..initialize(
          server,
          'animalIdentification',
          null,
        ),
      'behaviorAnalysis': _i5.BehaviorAnalysisEndpoint()
        ..initialize(
          server,
          'behaviorAnalysis',
          null,
        ),
      'carePlan': _i6.CarePlanEndpoint()
        ..initialize(
          server,
          'carePlan',
          null,
        ),
      'magicLink': _i7.MagicLinkEndpoint()
        ..initialize(
          server,
          'magicLink',
          null,
        ),
      'nearbyServices': _i8.NearbyServicesEndpoint()
        ..initialize(
          server,
          'nearbyServices',
          null,
        ),
      'greeting': _i9.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i3.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['animalIdentification'] = _i1.EndpointConnector(
      name: 'animalIdentification',
      endpoint: endpoints['animalIdentification']!,
      methodConnectors: {
        'identifyAnimal': _i1.MethodConnector(
          name: 'identifyAnimal',
          params: {
            'imageBase64': _i1.ParameterDescription(
              name: 'imageBase64',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['animalIdentification']
                          as _i4.AnimalIdentificationEndpoint)
                      .identifyAnimal(
                        session,
                        params['imageBase64'],
                      ),
        ),
      },
    );
    connectors['behaviorAnalysis'] = _i1.EndpointConnector(
      name: 'behaviorAnalysis',
      endpoint: endpoints['behaviorAnalysis']!,
      methodConnectors: {
        'analyzeBehavior': _i1.MethodConnector(
          name: 'analyzeBehavior',
          params: {
            'videoBase64': _i1.ParameterDescription(
              name: 'videoBase64',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['behaviorAnalysis']
                          as _i5.BehaviorAnalysisEndpoint)
                      .analyzeBehavior(
                        session,
                        params['videoBase64'],
                      ),
        ),
      },
    );
    connectors['carePlan'] = _i1.EndpointConnector(
      name: 'carePlan',
      endpoint: endpoints['carePlan']!,
      methodConnectors: {
        'generateCarePlan': _i1.MethodConnector(
          name: 'generateCarePlan',
          params: {
            'animalIdentificationRecordId': _i1.ParameterDescription(
              name: 'animalIdentificationRecordId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'additionalNotes': _i1.ParameterDescription(
              name: 'additionalNotes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['carePlan'] as _i6.CarePlanEndpoint)
                  .generateCarePlan(
                    session,
                    animalIdentificationRecordId:
                        params['animalIdentificationRecordId'],
                    additionalNotes: params['additionalNotes'],
                  ),
        ),
        'getCarePlan': _i1.MethodConnector(
          name: 'getCarePlan',
          params: {
            'carePlanId': _i1.ParameterDescription(
              name: 'carePlanId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['carePlan'] as _i6.CarePlanEndpoint).getCarePlan(
                    session,
                    carePlanId: params['carePlanId'],
                  ),
        ),
        'listCarePlansForAnimal': _i1.MethodConnector(
          name: 'listCarePlansForAnimal',
          params: {
            'animalIdentificationRecordId': _i1.ParameterDescription(
              name: 'animalIdentificationRecordId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['carePlan'] as _i6.CarePlanEndpoint)
                  .listCarePlansForAnimal(
                    session,
                    animalIdentificationRecordId:
                        params['animalIdentificationRecordId'],
                  ),
        ),
        'archiveCarePlan': _i1.MethodConnector(
          name: 'archiveCarePlan',
          params: {
            'carePlanId': _i1.ParameterDescription(
              name: 'carePlanId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['carePlan'] as _i6.CarePlanEndpoint)
                  .archiveCarePlan(
                    session,
                    carePlanId: params['carePlanId'],
                  ),
        ),
      },
    );
    connectors['magicLink'] = _i1.EndpointConnector(
      name: 'magicLink',
      endpoint: endpoints['magicLink']!,
      methodConnectors: {
        'sendMagicLink': _i1.MethodConnector(
          name: 'sendMagicLink',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['magicLink'] as _i7.MagicLinkEndpoint)
                  .sendMagicLink(
                    session,
                    params['email'],
                  ),
        ),
        'verifyMagicLink': _i1.MethodConnector(
          name: 'verifyMagicLink',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['magicLink'] as _i7.MagicLinkEndpoint)
                  .verifyMagicLink(
                    session,
                    params['email'],
                    params['code'],
                  ),
        ),
      },
    );
    connectors['nearbyServices'] = _i1.EndpointConnector(
      name: 'nearbyServices',
      endpoint: endpoints['nearbyServices']!,
      methodConnectors: {
        'searchNearbyServices': _i1.MethodConnector(
          name: 'searchNearbyServices',
          params: {
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'radius': _i1.ParameterDescription(
              name: 'radius',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'types': _i1.ParameterDescription(
              name: 'types',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'pageToken': _i1.ParameterDescription(
              name: 'pageToken',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['nearbyServices'] as _i8.NearbyServicesEndpoint)
                      .searchNearbyServices(
                        session,
                        params['latitude'],
                        params['longitude'],
                        radius: params['radius'],
                        types: params['types'],
                        pageToken: params['pageToken'],
                      ),
        ),
        'getPlacePhotoUrl': _i1.MethodConnector(
          name: 'getPlacePhotoUrl',
          params: {
            'photoReference': _i1.ParameterDescription(
              name: 'photoReference',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'maxWidth': _i1.ParameterDescription(
              name: 'maxWidth',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['nearbyServices'] as _i8.NearbyServicesEndpoint)
                      .getPlacePhotoUrl(
                        session,
                        params['photoReference'],
                        maxWidth: params['maxWidth'],
                      ),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['greeting'] as _i9.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    modules['serverpod_auth_core'] = _i10.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_idp'] = _i11.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth'] = _i12.Endpoints()..initializeEndpoints(server);
  }
}
