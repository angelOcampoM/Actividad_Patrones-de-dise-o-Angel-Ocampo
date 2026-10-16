import 'package:flutter/material.dart';

import 'patrones/adapter.dart';
import 'patrones/factory.dart';
import 'patrones/inyeccion_dependencias.dart';
import 'patrones/observer.dart';
import 'patrones/repository.dart';
import 'patrones/strategy.dart';

void main() {
  // Inyección de dependencias: las implementaciones concretas se crean
  // aquí, en la raíz de la app, y se entregan hacia abajo.
  final AlmacenConsumo almacen = ConsumoEnMemoria();
  final LectorMedidor lector = LectorMedidor(MedidorLegado());
  runApp(EcoTrackApp(almacen: almacen, lector: lector));
}

class EcoTrackApp extends StatelessWidget {
  const EcoTrackApp({
    super.key,
    required this.almacen,
    required this.lector,
  });

  final AlmacenConsumo almacen;
  final LectorMedidor lector;

  @override
  Widget build(BuildContext context) {
    final patrones = <(String, String, Widget)>[
      (
        'Repository',
        'Ocultar de dónde salen los datos.',
        PantallaConsumo(almacen: almacen),
      ),
      (
        'Adapter',
        'Traducir un formato ajeno al de la app.',
        PantallaMedidor(lector: lector),
      ),
      (
        'Factory',
        'Centralizar la construcción de un objeto según el caso.',
        const PantallaAviso(),
      ),
      (
        'Strategy',
        'Intercambiar una regla sin copiar if.',
        const PantallaTope(),
      ),
      (
        'Observer',
        'Avisar a varios interesados sin nombrarlos.',
        const PantallaPaneles(),
      ),
      (
        'Inyección de dependencias',
        'Entregar desde fuera el objeto del que se depende.',
        const PantallaLab(),
      ),
    ];

    return MaterialApp(
      title: 'EcoTrack',
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Patrones de EcoTrack')),
          body: ListView(
            children: [
              for (final (i, (nombre, problema, pagina)) in patrones.indexed)
                ListTile(
                  leading: CircleAvatar(child: Text('${i + 1}')),
                  title: Text(nombre),
                  subtitle: Text(problema),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => pagina),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
