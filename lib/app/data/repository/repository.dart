import 'package:initial_app/app/data/models/token.dart';
import 'package:initial_app/app/data/provider/api_provider.dart';

class Repository {
  final ApiProvider apiProvider;
  Repository(this.apiProvider);

  Future<Token> login(Map<String, dynamic> map) => apiProvider.login(map);
}
