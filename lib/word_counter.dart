import 'package:flutter/material.dart';

class WordCounter extends StatefulWidget {
  const WordCounter({super.key});

  @override
  State<WordCounter> createState() => _WordCounterState();
}

class _WordCounterState extends State<WordCounter> {
  final TextEditingController _controller1 = TextEditingController();
  int _result = 0;

  void countWords(String str) {
    var words = str.split(' ');
    int wordCount = words.length;
    setState(() {
      _result = wordCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "Enter your text, then tap Count Words",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
              // Text field input
              SizedBox(
                height: 120,
                child: TextField(
                  controller: _controller1,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    labelText: 'Enter Text',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                  textAlignVertical: TextAlignVertical.top,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      _controller1.clear();
                      setState(() {
                        _result = 0;
                      });
                    },
                    child: const Text(
                      "Clear",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onPressed: () {
                      setState(() {
                        String str = _controller1.text;
                        countWords(str);
                      });
                    },
                    child: Text(
                      "Count Words",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Result display
              Text(
                "Word Count: ${_result.toString()}",
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
