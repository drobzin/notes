import 'package:flutter/material.dart';
import 'package:notes/notes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyAppState extends ChangeNotifier {
  List<Note> notes = <Note>[];

  void addNote(Note note) {
    notes.add(note);
    notifyListeners();
  }

  void removeNote(Note note) {
    notes.remove(note);
    notifyListeners();
  }

  void changeNote(Note note) {
    addNote(note);
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'first',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        ),
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var appState = context.watch<MyAppState>();
    return Scaffold(
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (1 / .6),
          ),
          itemCount: appState.notes.length,
          itemBuilder: (BuildContext context, int index) {
            return NoteCard(note: appState.notes[index]);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateNote(),
              )).then((note) => appState.addNote(note));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    var appState = context.watch<MyAppState>();
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CreateNote.withValue(note.header, note.text),
            )).then((changedNote) {
          if (changedNote != null) {
            appState.removeNote(note);
            appState.addNote(changedNote);
          }
        });
      },
      onLongPress: () async {
        await showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Удаление'),
                content: Text('Вы действительно хотите удалить эту заметку'),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      appState.removeNote(note);
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.check),
                  )
                ],
              );
            });
      },
      child: Card(
        child: Center(
          child: Text(
            note.header,
            style: TextStyle(
              height: 2,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
