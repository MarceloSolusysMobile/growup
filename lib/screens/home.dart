import 'package:flutter/material.dart';
import '../model/gasto.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
    Gasto(dia: '01', mes: 'Agosto', ano: '2023', valor: 4500),
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
            content: const Column(
              children: [Text('Cadastro de Gastos')],
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
      body: SingleChildScrollView(
        child: Container(
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.blueGrey],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                          labelStyle: const TextStyle(color: Colors.white)),
                      primaryYAxis: NumericAxis(
                        minimum: 1000,
                        maximum: 20000,
                        interval: 5000,
                        labelPosition: ChartDataLabelPosition.outside,
                        labelAlignment: LabelAlignment.end,
                        rangePadding: ChartRangePadding.additional,
                        labelStyle:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      series: <ChartSeries>[
                        ColumnSeries<Gasto, String>(
                            dataSource: listaGastos,
                            xValueMapper: (Gasto gasto, _) => gasto.mes,
                            yValueMapper: (Gasto gasto, _) => gasto.valor,
                            color: Colors.white)
                      ],
                      // Configurando a propriedade tooltipBehavior
                      tooltipBehavior: TooltipBehavior(
                        enable: true,
                        header: '',
                        canShowMarker: false,
                        builder: (dynamic data, dynamic point, dynamic series,
                            int pointIndex, int seriesIndex) {
                          return Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: const [
                                BoxShadow(color: Colors.grey, blurRadius: 3)
                              ],
                            ),
                            child: Text('R\$${point.y}'),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              //Lista de Gastos
              ListView.builder(
                padding: const EdgeInsets.only(bottom:50),
                shrinkWrap: true,
                itemCount: listaGastos.length,
                itemBuilder: ((context, index) {
                  return Card(
                    margin: const EdgeInsets.only(top: 2, left: 8, right: 8),
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
            ],
          ),
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
