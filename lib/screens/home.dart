import 'package:flutter/material.dart';
import '../model/gasto.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Gasto> listaGastos = [
    Gasto(dia: '01', mes: 'janeiro', ano: '2023', valor: 12500.50),
    Gasto(dia: '02', mes: 'Fevereiro', ano: '2023', valor: 12900),
    Gasto(dia: '03', mes: 'Março', ano: '2023', valor: 11500),
    Gasto(dia: '04', mes: 'Abril', ano: '2023', valor: 10500),
    Gasto(dia: '05', mes: 'Maio', ano: '2023', valor: 2500),
    Gasto(dia: '01', mes: 'Junho', ano: '2023', valor: 2900),
    Gasto(dia: '01', mes: 'Julho', ano: '2023', valor: 9500),
    Gasto(dia: '01', mes: 'Agosto', ano: '2023', valor: 42500),
  ];

  double returnValorTotal(List<Gasto> gastos) {
    double valorTotal = 0;
    for (var gasto in gastos) {
      valorTotal += gasto.valor;
    }
    return valorTotal;
  }

  showGastoDialog(Gasto gasto) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              children: [
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.attach_money_rounded),
                    title: Text('Gastos Mês ${gasto.mes}'),
                    trailing: Text('R\$${gasto.valor}'),
                  ),
                )
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 1, 65, 3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Salvar',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          );
        });
  }

  showGastoCadastroDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              children: const [Text('Cadastro de Gastos')],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 1, 65, 3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Salvar',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 1, 65, 3),
              Color.fromARGB(255, 24, 226, 30),
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'R\$ ${returnValorTotal(listaGastos)}',
              style: const TextStyle(
                fontSize: 30,
                color: Colors.lightGreenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Gasto Total',
              style: TextStyle(
                fontSize: 20,
                color: Colors.lightGreenAccent,
              ),
            ),
            //grafico

            //Lista de Gastos
            Expanded(
              child: ListView.builder(
                itemCount: listaGastos.length,
                itemBuilder: ((context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        showGastoDialog(listaGastos[index]);
                      },
                      leading: const Icon(Icons.attach_money_rounded),
                      title: Text('Gastos Mês ${listaGastos[index].mes}'),
                      trailing: Text('R\$${listaGastos[index].valor}'),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
            backgroundColor: const Color.fromARGB(255, 1, 65, 3),
            onPressed: () {
              showGastoCadastroDialog();
            },
            label: const Icon(Icons.plus_one)),
      
    );
  }
}
