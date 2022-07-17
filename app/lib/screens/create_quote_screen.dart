import 'package:app/screens/quote_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/quote_controller.dart';
import '../models/quote_model.dart';
import '../providers/input_provider.dart';

class CreateQuoteScreen extends StatefulWidget {
  const CreateQuoteScreen({Key? key}) : super(key: key);

  @override
  State<CreateQuoteScreen> createState() => _CreateQuoteScreenState();
}

class _CreateQuoteScreenState extends State<CreateQuoteScreen> {

  final QuoteController _quoteController = QuoteController();

  void _createQuote(String text, String? name) {
    context.read<InputProvider>().reset();
    if ('' == text) return;
    name = name ?? 'Unknown';
    Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
            builder: (context) {
              return const QuoteScreen(
                  quote : Quote(
                      id: 1, text: 'lol', name: 'lol'
                  )
              );
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Quote'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                const TextInputWidget(),
                Expanded(
                  flex: 3,
                  child: Container(),
                ),
                const NameInputWidget(),
                Expanded(
                  flex: 3,
                  child: Container(),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _createQuote(
                                context.read<InputProvider>().getText,
                                context.read<InputProvider>().getName
                            );
                            },
                          child: const Text('save')
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            context.read<InputProvider>().reset();
                            Navigator.pop(context);
                            },
                          child: const Text('close')
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(),
                      ),
                    ]
                ),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
              ]
          ),
        ),
      ),
    );
  }
}

class TextInputWidget extends StatefulWidget {
  const TextInputWidget({Key? key}) : super(key: key);

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: "Enter your Quote",
        helperText: "Required",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
            context.watch<InputProvider>().isTrue ? Colors.red : Colors.blue,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
            context.watch<InputProvider>().isTrue ? Colors.red : Colors.blue,
            width: 2.0,
          ),
        ),
      ),
      onChanged: (text) => setState(
              () {context.read<InputProvider>().setText(text);}
      ),
      maxLines: 5,
    );
  }
}

class NameInputWidget extends StatefulWidget {
  const NameInputWidget({Key? key}) : super(key: key);

  @override
  State<NameInputWidget> createState() => _NameInputWidgetState();
}

class _NameInputWidgetState extends State<NameInputWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Enter your Name",
        helperText: "Optional",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
      onChanged: (text) => setState(
              () {context.read<InputProvider>().setName(text);}
      ),
    );
  }
}


