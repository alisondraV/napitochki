import 'package:flutter/material.dart';

void main() {
  runApp(Napitochki());
}

class Napitochki extends StatelessWidget {
  const Napitochki({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Best napitochki',
      theme: ThemeData(
          primaryColor: Colors.indigo[200],
          accentColor: Colors.lightGreen[400],
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(Colors.lightGreen[400])),
          )),
      home: Navigator(
        initialRoute: WelcomePage.route,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case WelcomePage.route:
              return MaterialPageRoute(builder: (_) => WelcomePage());
            case ListViewPage.route:
              return MaterialPageRoute(builder: (_) => ListViewPage());
          }
        },
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);
  static const String route = 'welcome';

  goToListView(BuildContext context) {
    Navigator.pushNamed(context, ListViewPage.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Welcome',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the best napitochki!',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton.icon(
              onPressed: () => goToListView(context),
              icon: Icon(Icons.accessible_forward_sharp),
              label: Text('Go!'),
            )
          ],
        ),
      ),
    );
  }
}

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);
  static const String route = 'list-view';

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  List<String> _napitochki = [];

  addNewNapitochek(String name) {
    setState(() {
      _napitochki.add(name);
    });
  }

  removeNapitochek(String name) {
    setState(() {
      _napitochki.remove(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'List View',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onSubmitted: addNewNapitochek,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _napitochki.length,
                itemBuilder: (_, index) {
                  return Dismissible(
                    key: Key(_napitochki[index]),
                    child: ListTile(
                      title: Text(_napitochki[index]),
                    ),
                    onDismissed: (_) => removeNapitochek(_napitochki[index]),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
