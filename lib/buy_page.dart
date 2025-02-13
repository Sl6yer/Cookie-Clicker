import 'package:flutter/material.dart';

class BuyPage extends StatefulWidget {
  final int contador;
  final int multiplicador;
  final Set<int> itensComprados;

  const BuyPage({
    Key? key,
    required this.contador,
    required this.multiplicador,
    required this.itensComprados, // Recebe os itens comprados
  }) : super(key: key);

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  late int _contador;
  late int _multiplicador;
  late Set<int> _itensComprados;

  @override
  void initState() {
    super.initState();
    _contador = widget.contador;
    _multiplicador = widget.multiplicador;
    _itensComprados =
        Set<int>.from(widget.itensComprados); // Clona os itens comprados
  }

  void _comprar(int id, int preco, int multiplicadorGanho) {
    if (_contador >= preco && !_itensComprados.contains(id)) {
      setState(() {
        _contador -= preco;
        _multiplicador *= multiplicadorGanho;
        _itensComprados.add(id);
      });

      // Retorna os valores atualizados para a Home
      Navigator.pop(context, {
        'contador': _contador,
        'multiplicador': _multiplicador,
        'itensComprados': _itensComprados,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Compras",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          BuildContainer(1, 20, 2, '2x Click', '20'),
          BuildContainer(2, 200, 4, '4x Click', '200'),
          BuildContainer(3, 1000, 6, '6x Click', '1K'),
          BuildContainer(4, 10000, 8, '10x Click', '10K'),
          BuildContainer(5, 100000, 10, '10x Click', '100K'),
          BuildContainer(6, 1000000, 12, '12x Click', '1M'),
          BuildContainer(7, 10000000, 14, '14x Click', '10M'),
          BuildContainer(8, 100000000, 16, '16x Click', '100M'),
          BuildContainer(9, 2000000000, 18, '18x Click', '2B'),
          BuildContainer(10, 100000000000, 20, '20x Click', '100B'),
          BuildContainer(11, 1000000000000, 22, '22x Click', '1T'),
          BuildContainer(12, 100000000000000, 24, '24x Click', '100T'),
        ],
      ),
    );
  }

  Widget BuildContainer(
      int id, int preco, int multiplicador, String texto, String texto2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 100,
        color: Color.fromRGBO(62, 39, 35, 0.8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${texto}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            ElevatedButton(
              onPressed: _itensComprados.contains(id)
                  ? null
                  : () => _comprar(id, preco, multiplicador),
              child: Text(
                "${texto2}",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
