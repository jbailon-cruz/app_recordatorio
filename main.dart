import 'package:flutter/material.dart';

void main() {
  runApp(const ReminderApp());
}

class ReminderApp extends StatelessWidget {
  const ReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App de Recordatorios', // ✅ TÍTULO CAMBIADO
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool reminderEnabled = false; // ✅ Para el widget nuevo (Switch)

  @override
  Widget build(BuildContext context) {
    final String reminderText = reminderEnabled
        ? 'Recordatorio ACTIVADO: Estudiar Desarrollo de Apps'
        : 'Recordatorio DESACTIVADO';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Recordatorios'), // ✅ TEXTO CAMBIADO
        backgroundColor: Colors.deepPurple, // ✅ COLOR DEL APPBAR CAMBIADO
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'No lo olvides', // ✅ TEXTO PRINCIPAL CAMBIADO
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              Text(
                reminderText,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // ✅ WIDGET NUEVO (NO visto en clase: si ya lo vieron, cámbialo por otro)
              // Función clara: activar/desactivar el recordatorio
              SwitchListTile(
                title: const Text('Activar recordatorio'),
                value: reminderEnabled,
                onChanged: (value) {
                  setState(() {
                    reminderEnabled = value;
                  });
                },
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  // ✅ SNACKBAR
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        reminderEnabled
                            ? 'Recordatorio activado correctamente'
                            : 'Recordatorio desactivado',
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );

                  // ✅ NAVEGACIÓN A SEGUNDA PANTALLA
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        reminderEnabled: reminderEnabled,
                      ),
                    ),
                  );
                },
                child: const Text('Ver detalle del recordatorio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ✅ SEGUNDA PANTALLA
class DetailPage extends StatelessWidget {
  final bool reminderEnabled;

  const DetailPage({super.key, required this.reminderEnabled});

  @override
  Widget build(BuildContext context) {
    final String detailText = reminderEnabled
        ? 'Detalle: Hoy debes practicar revisar satcom.'
        : 'Detalle: No hay recordatorios activos.';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Recordatorio'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                detailText, // ✅ TEXTO VISIBLE EN SEGUNDA PANTALLA
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // ✅ REGRESAR
                },
                child: const Text('Regresar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
