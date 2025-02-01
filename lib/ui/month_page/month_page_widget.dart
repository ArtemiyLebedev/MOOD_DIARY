import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:google_fonts/google_fonts.dart';
import '../mood_diary_page/mood_diary_page_widget.dart';


//Экран с календарем, где месяца в колонке.
//Одинарным нажатием на дату можно перейтди на экран "дневника настроения"
//Актуальная дата в бледно-оранжевом кружке, а оранживая точка указывает на наличие записи а в "дневника настроения"

class MonthCalendarScreen extends StatefulWidget {
  const MonthCalendarScreen({super.key});

  @override
  State<MonthCalendarScreen> createState() => _MonthCalendarScreenState();
}

class _MonthCalendarScreenState extends State<MonthCalendarScreen> {
  int selectedYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Expanded(
          child: Table(
            children: [
              TableRow(
                  children: List.generate(7, (index) {
                final weekday = DateFormat.E('ru_RU')
                    .format(DateTime(selectedYear, 1, 6 + index));
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      weekday.toUpperCase(),
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                        color: Color.fromRGBO(188, 188, 191, 1),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      )),
                    ),
                  ),
                );
              }))
            ],
          ),
        )), //number Year
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
        ),
        itemCount: 12,
        itemBuilder: (context, index) => MonthCalendar(
          year: selectedYear,
          month: index + 1,
        ),
      ),
    );
  }
}

class MonthCalendar extends StatelessWidget {
  final int year;
  final int month;

  const MonthCalendar({super.key, required this.year, required this.month});

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(year, month, 1);
    final lastDay = DateTime(year, month + 1, 0);
    final monthName = DateFormat.LLLL('ru_RU').format(firstDay);
    final capitalizedMonthName =
        monthName[0].toUpperCase() + monthName.substring(1).toLowerCase();
    final daysInMonth = lastDay.day;
    final startingWeekday = firstDay.weekday;

    final today = DateTime.now();
    return GestureDetector(
        child: Column(
      children: [
        Row(
          children: [
            Text(('$year'),
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    color: Color.fromRGBO(188, 188, 191, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                )
            )
          ],),
        Row(
          children: [
            Text(capitalizedMonthName, /////////////  MONTH name
                textAlign: TextAlign.start,
                style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                  color: Color.fromRGBO(76, 76, 105, 1),
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ))),
          ],
        ),
        Expanded(
          child: Table(
            children: [
              ...List.generate(6, (weekIndex) {
                return TableRow(
                  children: List.generate(7, (dayIndex) {
                    final dayNumber =
                        weekIndex * 7 + dayIndex + 1 - startingWeekday + 1;
                    final isCurrentDay = year == today.year &&
                        month == today.month &&
                        dayNumber == today.day;
                    if (dayNumber < 1 || dayNumber > daysInMonth) {
                      return Container();
                    }
                    return InkWell(
                      child: Container(
                        margin: EdgeInsets.all(2),
                        width: 41,
                        height: 41,
                        decoration: BoxDecoration(
                          color: isCurrentDay
                              ? Color.fromRGBO(255, 135, 2, 0.25)
                              : null,
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Номер дня
                            Text(
                              '$dayNumber',
                              style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                color: Color.fromRGBO(76, 76, 105, 1),
                                fontSize: 18,
                              )),
                            ),
                            // Оранжевая точка
                            Container(
                                child: dayNumber == today.day
                                    ? Positioned(
                                        bottom: 2, // Отступ от нижнего края
                                        child: Container(
                                          width: 5,
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      )
                                    : null),
                          ],
                        ),
                      ),
                      onTap: () { Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MoodDiaryPageScreen())); },
                    );
                  }),
                );
              }),
            ],
          ),
        ),
      ],
    ));
  }
}
