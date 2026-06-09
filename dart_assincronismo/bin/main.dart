import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  print('Olá mundo');
  // requestData();
  requestDataAsync();
}

void requestData() {
  String url =
      'https://gist.githubusercontent.com/juniorlatalisa/257d666dcebae2ff43fba7881628b21c/raw/b816f4c76a2e6c2c2a1afa2e96df212854353396/accounts.json';

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

void requestDataAsync() async {
  String url =
      'https://gist.githubusercontent.com/juniorlatalisa/257d666dcebae2ff43fba7881628b21c/raw/b816f4c76a2e6c2c2a1afa2e96df212854353396/accounts.json';

  final response = await http.get(Uri.parse(url));

  print(json.decode(response.body)[0]);

  print('De fato a última coisa a acontecer na função');
}
