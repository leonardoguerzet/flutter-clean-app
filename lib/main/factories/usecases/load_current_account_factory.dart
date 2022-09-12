import 'package:flutter_clean_app/main/factories/cache/cache.dart';

import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';

LoadCurrentAccount makeLocalLoadCurrentAccount() {
  return LocalLoadCurrentAccount(
    fetchSecureCacheStorage: makeSecureStorageAdapter()
  );
}
