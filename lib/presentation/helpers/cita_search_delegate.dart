import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:dental_care_app/domain/entities/cita_entitie.dart';
import 'package:dental_care_app/config/services/cita_service.dart';


class CitaSearchDelegate extends SearchDelegate {

  @override
  final String searchFieldLabel;
  CitaSearchDelegate(this.searchFieldLabel);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '', 
        icon: const Icon(Icons.clear_outlined)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => this.close(context, null), 
      icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    
    if ( query == '') return _ContainerVacio(); 

    final citaService = Provider.of<CitaService>(context);

    return FutureBuilder(
      future: citaService.obtenerCitsaPorPaciente(query),
      builder: (_, AsyncSnapshot<List<Cita>> snapshot) {
        if (snapshot.hasError) return _ContainerVacio();
        if (!snapshot.hasData) return _ContainerVacio();
        return _mostrarCitas(snapshot.data!);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _ContainerVacio();
  }

  Widget _mostrarCitas(List<Cita> citas) {
    return ListView.builder(
      itemCount: citas.length,
      itemBuilder: (BuildContext context, int i) {
        final cita = citas[i];
        return ListTile(
          title: Text(cita.paciente),
          subtitle: Text(cita.fecha!),
          leading: const Icon(Icons.calendar_month, size: 40,),
          onTap: () => close(context, cita),
        );
      },
    );
  }

  Widget _ContainerVacio() {
    return const Center(
      child: Text('Encuentra una cita..')
    );
  }

}