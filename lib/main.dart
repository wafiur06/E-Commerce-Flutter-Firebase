import 'package:bloc_app/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBlocBloc(),
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Home(),
    ),
    );
  }
}


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Container(
        child: BlocConsumer<CounterBlocBloc, CounterState>(
            builder: (context, state)=> Text('Hello World!'),
            listener: (context, state)=> ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.count.toString()))),
      )),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<CounterBlocBloc>().add(Increment()),
          child: Icon(Icons.add),
        ),
      );
  }
}
