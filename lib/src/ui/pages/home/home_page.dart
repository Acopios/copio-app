import 'dart:developer';

import 'package:acopios/src/core/shared_preferences.dart';
import 'package:acopios/src/ui/pages/auth/login/login_page.dart';
import 'package:acopios/src/ui/pages/home/cubit/home_cubit.dart';
import 'package:acopios/src/ui/pages/home/historial/historial_page.dart';
import 'package:acopios/src/ui/pages/home/material_list/material_list_page.dart';
import 'package:acopios/src/ui/pages/home/minorista/minorista_page.dart';
import 'package:acopios/src/ui/pages/home/minorista/recolectores_model.dart';
import 'package:acopios/src/ui/pages/home/reportes/reporte_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController pageController;
  late HomeCubit _cubit;
  late Future<List<BodyReco>> _future;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    _cubit = HomeCubit();
    init();
  }

init(){
_future = _cubit.getRecolectores();
}
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>_cubit,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Image.asset(
                "assets/reciclar-simbolo.png",
                height: 100,
              )
            ],
          ),
        ),

        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final c = context.read<HomeCubit>();
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(children: [
                const Center(
                    child: Text(
                  "Mis Recolectores",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                )),
                FutureBuilder<List<BodyReco>>(
                    future:_future,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      return Expanded(
                          child: ListView(
                        children: List.generate(
                            snapshot.data!.length,
                            (index) => Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Nombre: ${snapshot.data![index].nombres}"),
                                        Text(
                                            "Apellidos:  ${snapshot.data![index].apellidos}"),
                                        Text(
                                            "Identificacion:  ${snapshot.data![index].identificacion}"),
                                        Text(
                                            "Apellidos:  ${snapshot.data![index].estado}"),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                              child: Text("Reportes: 1"),
                                              onPressed: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (_)=>HistoriaPage(id: snapshot.data![index].idRecolector!,)));
                                              },
                                            ),
                                            TextButton(
                                              child: Text("Agregar reporte"),
                                              onPressed: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (_)=>ReportesPage(bodyReco: snapshot.data![index],)));
                                              },
                                            ),
                                            TextButton(
                                              child: Text("Gestionar"),
                                              onPressed: () {},
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                      ));
                    })
              ]),
            );
          },
        ),
        floatingActionButton: SpeedDial(child: Icon(Icons.add), children: [
          SpeedDialChild(
            child: Icon(Icons.person_add),
            label: 'Añadir recolector',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const MinoristaPage()));
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.recycling),
            label: 'Agregar materiales',
            onTap: null,
          ),
          SpeedDialChild(
            child: Icon(Icons.monetization_on),
            label: 'Mis precios',
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>const MaterialListPage()));
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.exit_to_app),
            label: 'Cerrar sesión',
            onTap: () {
              SharedPreferencesManager("token").remove();
              SharedPreferencesManager("idUSer").remove();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                  (route) => false);
            },
          ),
        ]),
        // body: PageView(
        //   physics: const NeverScrollableScrollPhysics(),
        //   controller: pageController,
        //   children: const [
        //     MaterialListPage(),
        //     Center(child: Text("Historial")),
        //     Center(child: Text("Configuraciones???")),
        //   ],
        // ),
        // bottomSheet: Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        //   margin: EdgeInsets.only(
        //       bottom: MediaQuery.sizeOf(context).height * .05,
        //       left: 10,
        //       right: 10),
        //   height: MediaQuery.sizeOf(context).height * .06,
        //   decoration: BoxDecoration(
        //       border: Border.all(color: Colors.blue),
        //       borderRadius: BorderRadius.circular(50)),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       _icon(
        //           iconData: Icons.recycling_outlined,
        //           txt: "Materiales",
        //           action: () {
        //               pageController.jumpToPage(0);
        //           }),
        //       _icon(
        //           iconData: Icons.history_edu_outlined,
        //           txt: "Historial",
        //           action: () {
        //               pageController.jumpToPage(1);
        //           }),
        //       _icon(iconData: Icons.settings, txt: "Perfil", action: () {
        //           pageController.jumpToPage(2);
        //           log("-->");
        //       }),
        //     ],
        //   ),
        // ),
      )),
    );
  }

  Widget _icon(
          {required IconData iconData,
          required String txt,
          required Function() action}) =>
      GestureDetector(
        onTap: action,
        child: Column(
          children: [Expanded(child: Icon(iconData)), Text(txt)],
        ),
      );
}
