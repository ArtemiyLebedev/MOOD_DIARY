



import 'package:flutter/material.dart';

class MoodDiaryPageScreen extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MoodDiaryPageScreen> {
  bool _switchValue = false;
  double _sliderValue1 = 0.5;
  double _sliderValue2 = 30.0;
  double _sliderValue3 = 70.0;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Switch
              Center(
                child: Switch(
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),

              // Emoji Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildEmojiButton('😊'),
                  _buildEmojiButton('🚀'),
                  _buildEmojiButton('🎉'),
                  _buildEmojiButton('❤️'),
                ],
              ),
              SizedBox(height: 30),

              // Sliders
              _buildSlider('Slider 1', _sliderValue1, (value) {
                setState(() => _sliderValue1 = value);
              }),
              _buildSlider('Slider 2', _sliderValue2, (value) {
                setState(() => _sliderValue2 = value);
              }),
              _buildSlider('Slider 3', _sliderValue3, (value) {
                setState(() => _sliderValue3 = value);
              }),
              SizedBox(height: 20),

              // Text Field
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Enter Text',
                  border: OutlineInputBorder(),
                  hintText: 'Type something...',
                ),
              ),
              SizedBox(height: 20),

              // Text Button
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  print('Text field value: ${_textController.text}');
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmojiButton(String emoji) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(), backgroundColor: Colors.orange.shade100,
        padding: EdgeInsets.all(20),
      ),
      onPressed: () => print('$emoji pressed'),
      child: Text(
        emoji,
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Widget _buildSlider(String label, double value, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Slider(
          value: value,
          min: 0,
          max: 100,
          divisions: 10,
          label: value.round().toString(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
