import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  var deco_expense=0.0,photo_expense=0.0,caterer_expense=0.0;

  final _formKey = GlobalKey<FormState>();
  final deco_data_controller = TextEditingController();
  final photo_data_controller = TextEditingController();
  final caterer_data_controller = TextEditingController();



  submit()
  {
    deco_expense=double.parse(deco_data_controller.text);
    photo_expense=double.parse(photo_data_controller.text);
    caterer_expense=double.parse(caterer_data_controller.text);

    deco_data_controller.clear();
    photo_data_controller.clear();
    caterer_data_controller.clear();
    _chartData = getChartData();
    print(deco_expense);
    print(photo_expense);
    print(caterer_expense);
  }

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    deco_data_controller.dispose();
    photo_data_controller.dispose();
    caterer_data_controller.dispose();
  }


  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Decorator',deco_expense),
      GDPData('Photographer', photo_expense),
      GDPData('Caterer', caterer_expense),
    ];
    return chartData;
  }

  @override
  Widget build(BuildContext context) {


    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Expenditure")),
          backgroundColor: Colors.blueGrey,
          bottom: TabBar(
            tabs: [
              Tab(text: "Input",),
              Tab(text: "Table",),
              Tab(text: "Pie Chart",),
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: TabBarView(
          children: [
            Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: deco_data_controller,
                  decoration: const InputDecoration(
                    hintText: 'Enter Decorator Expenditure',
                    labelText: 'Decorator',
                  ),

                ),
                TextFormField(
                  controller: photo_data_controller,
                  decoration: const InputDecoration(
                    hintText: 'Enter Photographer Expenditure',
                    labelText: 'Photographer',
                  ),

                ),
                TextFormField(
                  controller: caterer_data_controller,
                  decoration: const InputDecoration(
                    hintText: 'Enter Caterer Expenditure',
                    labelText: 'Caterer',
                  ),

                ),
                new Container(
                    padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                    child: new RaisedButton(
                      child: const Text('Submit'),
                      onPressed: (){
                        setState(() {
                          submit();
                        });
                      },
                    )),
              ],
            ),
          ),
        ),
            Container(
              child: DataTable(
                columns: [
                  DataColumn(label: Text("Category")),
                  DataColumn(label: Text("Expenditure")),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text("Decorator")),
                    DataCell(Text(deco_expense.toString()))
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Caterer")),
                    DataCell(Text(photo_expense.toString()))
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Photographer")),
                    DataCell(Text(caterer_expense.toString()))
                  ]),
                ],
              ),
            ),
            SfCircularChart(
              title: ChartTitle(
                  text: 'Expenditure Stats \n (In INR)'),
              legend: Legend(
                  isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
              tooltipBehavior: _tooltipBehavior,
              series: <CircularSeries>[
                PieSeries<GDPData, String>(
                    dataSource: _chartData,
                    xValueMapper: (GDPData data, _) => data.category,
                    yValueMapper: (GDPData data, _) => data.expense,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    enableTooltip: true,
                    ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}





class GDPData {
  GDPData(this.category, this.expense);
  final String category;
  final double expense;
}

