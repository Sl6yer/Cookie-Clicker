import 'package:cookie_clicker/buy_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _scale = 1.0;
  int _contador = 0;
  int _multiplicador = 1;
  Set<int> _itensComprados = {}; // Agora os itens comprados são salvos

  @override
  void initState() {
    super.initState();
    loadData(); // Carrega os dados ao iniciar o aplicativo
  }

  // Salvar os Dados
  Future<void> saveData(int contador, int multiplicador) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('contador', contador);
    prefs.setInt('multiplicador', multiplicador);
  }

  // Carregar os Dados
  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _contador = prefs.getInt('contador') ?? 0;
      _multiplicador = prefs.getInt('multiplicador') ?? 1;
    });
  }

  String FormatNumber(int numero) {
    if (numero >= 1000000000000) {
      return '${(numero / 1000000000000).toStringAsFixed(1)}T';
    } else if (numero >= 1000000000) {
      return '${(numero / 1000000000).toStringAsFixed(1)}B';
    } else if (numero >= 1000000) {
      return '${(numero / 1000000).toStringAsFixed(1)}M';
    } else if (numero >= 1000) {
      return '${(numero / 1000).toStringAsFixed(1)}K';
    } else {
      return numero.toString();
    }
  }

  void _onTap() {
    setState(() {
      _scale = 0.9;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _scale = 1.0;
      });
    });
    setState(() {
      _contador += _multiplicador;
    });
  }

  void _abrirLoja() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BuyPage(
          contador: _contador,
          multiplicador: _multiplicador,
          itensComprados: _itensComprados, // Passando os itens comprados
        ),
      ),
    );

    if (resultado != null) {
      setState(() {
        _contador = resultado['contador'];
        _multiplicador = resultado['multiplicador'];
        _itensComprados = resultado['itensComprados'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cookie Clicker",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            FormatNumber(_contador),
            style: const TextStyle(fontSize: 60.0),
          ),
          const SizedBox(height: 60),
          Center(
            child: GestureDetector(
              onTap: _onTap,
              child: AnimatedScale(
                scale: _scale,
                duration: const Duration(milliseconds: 100),
                child: const CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('assets/cookie.png'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _abrirLoja,
                child: const Icon(
                  Icons.shopping_cart,
                  color: Colors.brown,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
