import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean_app/domain/usecases/load_current_account.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';

class GetxSplashPresenter implements SplashPresenter {
  LoadCurrentAccount loadCurrentAccount;

  var _navigateTo = RxString();

  Stream<String> get navigateToStream => _navigateTo.stream;

  GetxSplashPresenter({@required this.loadCurrentAccount});

  Future<void> checkAccount() async {
    await loadCurrentAccount.load();
  }
}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

void main() {
  test('Should call LoadCurrentAccount', () async {
    final loadCurrentAccount = LoadCurrentAccountSpy();

    final sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);

    await sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });
}
