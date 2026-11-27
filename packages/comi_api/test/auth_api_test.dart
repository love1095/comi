import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for AuthApi
void main() {
  final instance = ComiApi().getAuthApi();

  group(AuthApi, () {
    //Future<TokenPairDto> authExchange(CustomerExchangeDto customerExchangeDto) async
    test('test authExchange', () async {
      // TODO
    });

    //Future<TokenPairDto> authLogin(StaffLoginDto staffLoginDto) async
    test('test authLogin', () async {
      // TODO
    });

    //Future authLogout(RefreshDto refreshDto) async
    test('test authLogout', () async {
      // TODO
    });

    //Future<TokenPairDto> authRefresh(RefreshDto refreshDto) async
    test('test authRefresh', () async {
      // TODO
    });

    //Future<TokenPairDto> authRegister(StaffRegisterDto staffRegisterDto) async
    test('test authRegister', () async {
      // TODO
    });

  });
}
