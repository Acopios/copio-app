import 'package:acopios/src/ui/pages/home/material_list/cubit/material_cubit.dart';
import 'package:acopios/src/ui/pages/home/material_list/materiales_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaterialListPage extends StatefulWidget {
  const MaterialListPage({super.key});

  @override
  State<MaterialListPage> createState() => _MaterialListPageState();
}

class _MaterialListPageState extends State<MaterialListPage> {
  late MaterialCubit _cubit;

late Future<List<BodyMaterial>> _future;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      
      appBar: AppBar(title: Text("Materiales"),),
      body: _body(context)));
  }

@override
  void initState() {
    super.initState();
    _cubit = MaterialCubit();
    init();
  }

  init(){
_future = _cubit.obtenerMateriales();
  }
  Widget _body(BuildContext context) => BlocProvider(
        create: (context) => _cubit,
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.sizeOf(context).height * .8,
                child: FutureBuilder<List<BodyMaterial>>(
                  future: _future,
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){
                      return Center(child: const CircularProgressIndicator.adaptive());
                    }
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListView(
                        children: List.generate(snapshot.data!.length, (index) => Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              Text("Material: ${snapshot.data![index].nombre}"),
                              Text("Valor: ${snapshot.data![index].valor}"),
                              Text("Código: ${snapshot.data![index].codigo}"),
                            ],),
                          ),
                        )),
                      ),
                    );
                  }
                )),
          ],
        ),
      );

  
}
