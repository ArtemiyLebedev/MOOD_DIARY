import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MoodDiaryPageScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MoodDiaryPageScreen> {
  final _currentTime =
      DateFormat('dd MMMM HH:mm', 'ru_RU').format(DateTime.now());

  double _sliderValue1 = 0.5;
  double _sliderValue2 = 30.0;

  final TextEditingController _textController = TextEditingController();

  final List<String> _imagePaths = [
    'assets/calmness.png',
    'assets/fier.png',
    'assets/joy.png',
    'assets/rage.png',
    'assets/rage.png',
    'assets/sadness.png',
    'assets/strenght.png'
  ];

  bool _isFirstActive = true;

  void _toggleButtons() {
    setState(() {
      _isFirstActive = !_isFirstActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: 400,
            child: ListView(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(
                    _currentTime,
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        color: Color.fromRGBO(188, 188, 191, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(width: 100,),
                  Icon(
                    Icons.calendar_month,
                    color: Color.fromRGBO(188, 188, 191, 1),
                  )
                ]),
                SizedBox(
                  height: 20,
                ),
                // Switch
                SizedBox(
                  width: 300,
                  height: 60,
                  child: Stack(
                    children: [
                      _buildAnimatedButton(
                        isActive: _isFirstActive,
                        isTop: true,
                      ),
                      _buildAnimatedButton(
                        isActive: !_isFirstActive,
                        isTop: false,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Emoji Buttons Row
                SizedBox(
                  height: 100, // Фиксированная высота для списка
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _imagePaths.length,
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                    itemBuilder: (context, index) =>
                        _buildImageButton(_imagePaths[index]),
                  ),
                ),
                SizedBox(height: 30),

                // Sliders
                _buildSlider('Уровень стресса', _sliderValue1, (value) {
                  setState(() => _sliderValue1 = value);
                }),
                _buildSlider('Самооценка', _sliderValue2, (value) {
                  setState(() => _sliderValue2 = value);
                }),

                SizedBox(height: 20),

                // Text Field
                SizedBox(
                  width: 335,
                  height: 120,
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Введите заметку...',
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Text Button
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 135, 2, 1),
                    disabledBackgroundColor: Color.fromRGBO(242, 242, 242, 1),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    print('Text field value: ${_textController.text}');
                  },
                  child: Text(
                    'Сохранить',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageButton(String imagePath) {
    return InkWell(
      onTap: () => print('Image tapped: $imagePath'),
      borderRadius: BorderRadius.circular(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSlider(String label, double value, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
                color: Color.fromRGBO(188, 188, 191, 1),
                fontWeight: FontWeight.w700,
                fontSize: 16),
          ),
        ),
        Slider(
          activeColor: Colors.orange,
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

  Widget _buildAnimatedButton({
    required bool isActive,
    required bool isTop,
  }) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      left: 0,
      right: 0,
      child: SizedBox(
        width: isActive ? 400 : 800,
        child: TextButton(
          child: Text(
            isActive ? 'Дневник настроения' : 'Статистика',
            style: TextStyle(
              color: isActive ? Colors.black54 : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            isActive == !isActive;
            setState(() {});
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
