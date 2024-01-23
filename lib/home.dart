import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _speechToText = SpeechToText();
  final  _textFieldController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _speechToText.initialize();
  }


  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
  setState(() {

  });

  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {

    });

  }

  void _onSpeechResult(result) {
    setState(() {
      _textFieldController.text =result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.black45,

        ),
        backgroundColor: Colors.orange,
        title: Text(
          'Speech To Text',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [

            Container(
              padding: EdgeInsets.all(16),
              child: TextField(

                controller: _textFieldController,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                ),
                readOnly: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),


                  ),

                  labelText: 'Words Spoken',
                  suffixIcon: IconButton(
                    onPressed: _speechToText.isListening
                        ? _stopListening
                        : _startListening,
                    icon: Icon(
                      _speechToText.isNotListening
                          ? Icons.mic_off
                          :Icons.mic,

                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}