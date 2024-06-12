import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/plan_notifier.dart';
import '../services/api_service.dart';
import '../screens/clients_screen.dart';
import '../screens/cobranza_screen.dart';
import '../screens/actividades_screen.dart';
import '../screens/planes_screen.dart';
import '../screens/lineas_screen.dart';
import '../screens/reportes_screen.dart';
import '../screens/zonas_screen.dart';
import '../providers/zona_notifier.dart';
import '../providers/linea_notifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider( // = 'http://127.0.0.1:8000/'
      providers: [
        ChangeNotifierProvider(create: (_) => ZonaNotifier(ApiService('http://192.168.0.108:8000'))),
        ChangeNotifierProvider(create: (_) => LineaNotifier()),
        ChangeNotifierProvider(create: (_) => PlanNotifier()),
      ],
      child: MaterialApp(
        title: 'Newtel App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Newtel App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Newtel App', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Clientes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClientsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.money),
              title: const Text('Cobranza'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CobranzaScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.work),
              title: const Text('Actividades'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActividadesScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.business),
              title: const Text('Planes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlanesScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Zonas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ZonaScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Líneas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LineasScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Reportes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportesScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Bienvenido a Newtel App'),
      ),
    );
  }
}
