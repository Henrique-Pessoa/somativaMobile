import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Somativa'),
    );
  }
}

class CardWidget extends StatefulWidget {
  CardWidget({
    Key? key,
    required this.imageURL,
    required this.location,
    required this.price,
    required int quantidadeDias,
    required int quantidadePessoas,
    required this.incrementDias,
    required this.incrementPessoas,
    required this.limparQuantidadeDias,
    required this.valorPorPessoa,
    required this.valorDiaria,
    required this.description,
  })  : _quantidadeDias = quantidadeDias,
        _quantidadePessoas = quantidadePessoas,
        super(key: key);

  final String imageURL;
  final String location;
  final String description;
  final String price;
  final VoidCallback incrementDias;
  final VoidCallback incrementPessoas;
  final VoidCallback limparQuantidadeDias;
  final double valorPorPessoa;
  final double valorDiaria;

  int _quantidadeDias;
  int _quantidadePessoas;
  double _valorTotal = 0.0;

  int get quantidadeDias => _quantidadeDias;
  set quantidadeDias(int value) => _quantidadeDias = value;

  int get quantidadePessoas => _quantidadePessoas;
  set quantidadePessoas(int value) => _quantidadePessoas = value;

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
          child: Image.network(widget.imageURL),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
          child: Text(
            widget.location,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
          child: Text(
            widget.price,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
          child: Text(
            widget.description,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 50),
          child: Container(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Text(
                  "Quatidade de dias:${widget._quantidadeDias}",
                  style: const TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: ElevatedButton(
                    onPressed: widget.incrementDias,
                    child: const Text("+1"),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 50),
          child: Container(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Text(
                  "Quatidade de pessoas:${widget._quantidadePessoas}",
                  style: const TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: ElevatedButton(
                    onPressed: widget.incrementPessoas,
                    child: const Text("+1"),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Text(
            "Valor total: ${widget._valorTotal}",
            style: const TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 90),
          child: Container(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _calcularValorTotal();
                  },
                  child: const Text("Calcular"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ElevatedButton(
                    onPressed: widget.limparQuantidadeDias,
                    child: const Text("Limpar"),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void _calcularValorTotal() {
    setState(() {
      widget._valorTotal += widget._quantidadeDias * widget.valorDiaria +
          widget._quantidadePessoas * widget.valorPorPessoa;
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> quantidadeDiasList = List.generate(10, (index) => 0);
  List<int> quantidadePessoasList = List.generate(10, (index) => 0);
  List<double> _valoresDiarias = [
    384,
    571,
    534,
    348,
    401,
    546,
    616,
    504,
    478,
    446
  ];
  List<double> _valoresPorPessoa = [
    70,
    75,
    65,
    85,
    85,
    95,
    105,
    110,
    85,
    95,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              CardWidget(
                imageURL:
                    'https://brazilexpedition.com/wp-content/uploads/2021/09/Lagoa-Azul3-625x430.jpg',
                location: 'Angra dos Reis',
                price: 'RS 384/dia - RS 70/pessoa',
                description:
                    '1 Quarto, banheiro, televisão, WiFi, ar-condicionado',
                quantidadeDias: quantidadeDiasList[0],
                quantidadePessoas: quantidadePessoasList[0],
                valorDiaria: _valoresDiarias[0],
                valorPorPessoa: _valoresPorPessoa[0],
                incrementDias: () {
                  _incrementDias(0);
                },
                limparQuantidadeDias: () {
                  _limparQuantidadeDias(0);
                },
                incrementPessoas: () {
                  _incrementPessoas(0);
                },
              ),
              CardWidget(
                imageURL:
                    'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1a/62/7e/46/caption.jpg?w=1200&h=-1&s=1',
                location: 'Jericoacoara',
                price: 'RS 571/dia - RS 75/pessoa',
                description: '2 Quartos, banheiro, cozinha, WiFi',
                quantidadeDias: quantidadeDiasList[1],
                quantidadePessoas: quantidadePessoasList[1],
                valorDiaria: _valoresDiarias[1],
                valorPorPessoa: _valoresPorPessoa[1],
                incrementDias: () {
                  _incrementDias(1);
                },
                limparQuantidadeDias: () {
                  _limparQuantidadeDias(1);
                },
                incrementPessoas: () {
                  _incrementPessoas(1);
                },
              ),
              CardWidget(
                imageURL:
                    'https://a.cdn-hotels.com/gdcs/production149/d708/3200849d-b05f-4650-839a-87c743802f46.jpg?impolicy=fcrop&w=800&h=533&q=medium',
                location: 'Arraial do cabo',
                price: 'RS 534/dia - RS 65/pessoa',
                description: '2 Quartos, banheiro, cozinha, WiFi',
                quantidadeDias: quantidadeDiasList[2],
                quantidadePessoas: quantidadePessoasList[2],
                valorDiaria: _valoresDiarias[2],
                valorPorPessoa: _valoresPorPessoa[2],
                incrementDias: () {
                  _incrementDias(2);
                },
                limparQuantidadeDias: () {
                  _limparQuantidadeDias(2);
                },
                incrementPessoas: () {
                  _incrementPessoas(2);
                },
              ),
              CardWidget(
                imageURL:
                    'https://blog.123milhas.com/wp-content/uploads/2023/03/aniversario-de-florianopolis-cinco-curiosidades-sobre-a-cidade-conexao123.jpg',
                location: 'Florianópolis',
                price: 'RS 348/dia - RS 85/pessoa',
                description: '2 Quartos, banheiro, cozinha, WiFi',
                quantidadeDias: quantidadeDiasList[3],
                quantidadePessoas: quantidadePessoasList[3],
                valorDiaria: _valoresDiarias[3],
                valorPorPessoa: _valoresPorPessoa[3],
                incrementDias: () {
                  _incrementDias(3);
                },
                limparQuantidadeDias: () {
                  _limparQuantidadeDias(3);
                },
                incrementPessoas: () {
                  _incrementPessoas(3);
                },
              ),
              CardWidget(
                imageURL:
                    'https://destinosnotaveis.com.br/wp-content/uploads/2021/06/madri-espanha-1024x612.jpg',
                location: 'Madri',
                price: 'RS 401/dia - RS 85/pessoa',
                description: '2 Quartos, banheiro, cozinha, WiFi',
                quantidadeDias: quantidadeDiasList[4],
                quantidadePessoas: quantidadePessoasList[4],
                valorDiaria: _valoresDiarias[4],
                valorPorPessoa: _valoresPorPessoa[4],
                incrementDias: () {
                  _incrementDias(4);
                },
                limparQuantidadeDias: () {
                  _limparQuantidadeDias(4);
                },
                incrementPessoas: () {
                  _incrementPessoas(4);
                },
              ),
              CardWidget(
                imageURL:
                    'https://viagemeturismo.abril.com.br/wp-content/uploads/2016/11/thinkstockphotos-4549879531.jpeg',
                location: 'Paris',
                price: 'RS 546/dia - RS 95/pessoa',
                description: '2 Quartos, banheiro, cozinha, WiFi',
                quantidadeDias: quantidadeDiasList[5],
                quantidadePessoas: quantidadePessoasList[5],
                valorDiaria: _valoresDiarias[5],
                valorPorPessoa: _valoresPorPessoa[5],
                incrementDias: () {
                  _incrementDias(5);
                },
                limparQuantidadeDias: () {
                  _limparQuantidadeDias(5);
                },
                incrementPessoas: () {
                  _incrementPessoas(5);
                },
              ),
              CardWidget(
                imageURL:
                    'https://imgmd.net/images/v1/guia/1685173/orlando-73-c.jpg',
                location: 'Orlando',
                price: 'RS 616/dia - RS 105/pessoa',
                description: '2 Quartos, banheiro, cozinha, WiFi',
                quantidadeDias: quantidadeDiasList[6],
                quantidadePessoas: quantidadePessoasList[6],
                valorDiaria: _valoresDiarias[6],
                valorPorPessoa: _valoresPorPessoa[6],
                incrementDias: () {
                  _incrementDias(6);
                },
                limparQuantidadeDias: () {
                  _limparQuantidadeDias(6);
                },
                incrementPessoas: () {
                  _incrementPessoas(6);
                },
              ),
              CardWidget(
                imageURL:
                    'https://a57.foxnews.com/static.foxnews.com/foxnews.com/content/uploads/2023/11/896/500/Las-Vegas-F1-Grand-Prix.jpg?ve=1&tl=1',
                location: 'Las Vegas',
                price: 'RS 504/dia - RS 110/pessoa',
                description: '2 Quartos, banheiro, cozinha, WiFi',
                quantidadeDias: quantidadeDiasList[7],
                quantidadePessoas: quantidadePessoasList[7],
                valorDiaria: _valoresDiarias[7],
                valorPorPessoa: _valoresPorPessoa[7],
                incrementDias: () {
                  _incrementDias(7);
                },
                limparQuantidadeDias: () {
                  _limparQuantidadeDias(7);
                },
                incrementPessoas: () {
                  _incrementPessoas(7);
                },
              ),
              CardWidget(
                imageURL:
                    'https://res.cloudinary.com/hello-tickets/image/upload/c_limit,f_auto,q_auto,w_1300/v1640835927/o3pfl41q7m5bj8jardk0.jpg',
                location: 'Roma',
                price: 'RS 478/dia - RS 85/pessoa',
                description: '2 Quartos, banheiro, cozinha, WiFi',
                quantidadeDias: quantidadeDiasList[8],
                quantidadePessoas: quantidadePessoasList[8],
                valorDiaria: _valoresDiarias[8],
                valorPorPessoa: _valoresPorPessoa[8],
                incrementDias: () {
                  _incrementDias(8);
                },
                limparQuantidadeDias: () {
                  _limparQuantidadeDias(8);
                },
                incrementPessoas: () {
                  _incrementPessoas(8);
                },
              ),
              CardWidget(
                imageURL:
                    'https://img.nsctotal.com.br/wp-content/uploads/2022/10/santiago_0.jpg',
                location: 'Chile',
                price: 'RS 446/dia - RS 95/pessoa',
                description: '2 Quartos, banheiro, cozinha, WiFi',
                quantidadeDias: quantidadeDiasList[9],
                quantidadePessoas: quantidadePessoasList[9],
                valorDiaria: _valoresDiarias[9],
                valorPorPessoa: _valoresPorPessoa[9],
                incrementDias: () {
                  _incrementDias(9);
                },
                limparQuantidadeDias: () {
                  _limparQuantidadeDias(9);
                },
                incrementPessoas: () {
                  _incrementPessoas(9);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _incrementDias(int index) {
    setState(() {
      quantidadeDiasList[index]++;
    });
  }

  void _incrementPessoas(int index) {
    setState(() {
      quantidadePessoasList[index]++;
    });
  }

  void _limparQuantidadeDias(int index) {
    setState(() {
      quantidadeDiasList[index] = 0;
      quantidadePessoasList[index] = 0;
    });
  }
}
