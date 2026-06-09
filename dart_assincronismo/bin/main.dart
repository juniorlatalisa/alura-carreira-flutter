import 'package:dart_assincronismo/api_key.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  print('Olá mundo');
  // requestData();
  // requestDataAsync();
  sendDataAsync({
    "id": "NEW001", //
    "name": "Flutter", //
    "lastName": "Dart", //
    "balance": 5000, //
  });
}

const gist = "https://api.github.com/gists/257d666dcebae2ff43fba7881628b21c";
const url =
    'https://gist.githubusercontent.com/juniorlatalisa/257d666dcebae2ff43fba7881628b21c/raw/b816f4c76a2e6c2c2a1afa2e96df212854353396/accounts.json';

void requestData() {
  final futureResponse = http.get(Uri.parse(url));

  futureResponse.then((response) {
    // print(response.body);
    final List<dynamic> listAccounts = json.decode(response.body);
    final Map<String, dynamic> mapCarla = listAccounts.firstWhere(
      (element) => element['name'] == 'Carla',
    );
    print(mapCarla['balance']);
  });

  print('Última coisa a acontecer na função');
}

Future<List<dynamic>> requestDataAsync() async {
  final response = await http.get(Uri.parse(url));

  List<dynamic> lista = json.decode(response.body);

  print(lista[0]);

  print('De fato a última coisa a acontecer na função');

  return lista;
}

void sendDataAsync(Map<String, dynamic> mapAccount) async {
  List<dynamic> listAccounts = await requestDataAsync();
  listAccounts.add(mapAccount);
  String content = json.encode(listAccounts);
  // print(content);

  final response = await http.post(
    Uri.parse(gist),
    headers: {"Authorization": "Bearer $githubApiKey"},
    body: json.encode({
      "description": "accounts.json", //
      "public": true,
      "files": {
        "accounts.json": {
          "content": content, //
        },
      },
    }), //
  );

  // https://cursos.alura.com.br/classpage/dart-dominando-assincronismo-criando-comunicacao-apis/task/166429

  print(response.statusCode);
}
