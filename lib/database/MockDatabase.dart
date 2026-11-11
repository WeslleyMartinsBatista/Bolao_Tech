import '../model/UserModel.dart';
import '../model/PartidaModel.dart';
import '../model/LigaModel.dart';
import '../model/PalpiteModel.dart';

class MockDatabase {
  //Usuarios
  static List<UserModel> usuarios = [
    UserModel(
      id: "01",
      nome: "Antonio",
      email: "antonio@gmail.com",
      senha: "adm",
      cargo: Cargo.Administrador,
    ),
  ];

  //Partidas
  static List<Partidamodel> partidas = [
    Partidamodel(
      id: "01",
      timeA: "Gremio",
      timeB: "Internacional",
      dataHora: "18:00",
      placarA: "",
      placarB: "",
      status: Status.ABERTO,
    ),
    Partidamodel(
      id: "02",
      timeA: "Flamengo",
      timeB: "Palmeiras",
      dataHora: "19:00",
      placarA: "",
      placarB: "",
      status: Status.ABERTO,
    ),
    Partidamodel(
      id: "03",
      timeA: "Corinthians",
      timeB: "São Paulo",
      dataHora: "20:00",
      placarA: "",
      placarB: "",
      status: Status.ABERTO,
    ),
    Partidamodel(
      id: "04",
      timeA: "Botafogo",
      timeB: "Fluminense",
      dataHora: "20:00",
      placarA: "",
      placarB: "",
      status: Status.ANDAMENTO,
    ),
    Partidamodel(
      id: "04",
      timeA: "Red Bull Bragantino",
      timeB: "Cuiabá",
      dataHora: "20:00",
      placarA: "1",
      placarB: "2",
      status: Status.FECHADO,
    ),
  ];

  //Liga
  static List<LigaModel> Ligas = [
    LigaModel(
      id: "01",
      id_criador: "01",
      nome: "Antonio Clube",
      token_acesso: "123",
    ),
  ];
}
