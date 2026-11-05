import '../model/UserModel.dart';

class MockDatabase {
  static List<UserModel> usuarios = [
    UserModel(
      id: "01",
      nome: "Antonio",
      email: "antonio@gmail.com",
      senha: "adm",
    ),
  ];
}
