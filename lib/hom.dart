import 'package:app5/constant.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  bool isMale = true;
  double height = 170;
  int weight = 60;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'BMI Calculator',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                buildGenderCard('MALE', Icons.male, isMale, () {
                  setState(() {
                    isMale = true;
                  });
                }),
                buildGenderCard('FEMALE', Icons.female, !isMale, () {
                  setState(() {
                    isMale = false;
                  });
                }),
              ],
            ),
          ),
          Expanded(
            child: Card(
              margin: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.blue.shade50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("HEIGHT",
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                  SizedBox(height: 5),
                  Text('${height.round()} cm',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Slider(
                    value: height,
                    min: 100,
                    max: 220,
                    onChanged: (value) {
                      setState(() {
                        height = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                buildCounterCard('WEIGHT', weight, () {
                  setState(() {
                    weight--;
                  });
                }, () {
                  setState(() {
                    weight++;
                  });
                }),
                buildCounterCard('AGE', age, () {
                  setState(() {
                    age--;
                  });
                }, () {
                  setState(() {
                    age++;
                  });
                }),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
              ),
              child: Text(
                "CALCULATE BMI",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () {
                double bmi = weight / pow(height / 100, 2);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(
                      bmiValue: bmi,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Expanded buildGenderCard(
      String label, IconData icon, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          margin: EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: isSelected ? Colors.blue : Colors.grey.shade200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 80, color: isSelected ? Colors.white : Colors.grey),
              SizedBox(height: 10),
              Text(label,
                  style: TextStyle(
                      fontSize: 18,
                      color: isSelected ? Colors.white : Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildCounterCard(
      String label, int value, VoidCallback onMinus, VoidCallback onAdd) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.blue.shade50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: TextStyle(fontSize: 18, color: Colors.grey)),
            SizedBox(height: 5),
            Text('$value',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: onMinus,
                    icon: Icon(Icons.remove_circle,
                        color: Color.fromARGB(255, 232, 16, 171))),
                IconButton(
                    onPressed: onAdd,
                    icon: Icon(Icons.add_circle,
                        color: Color.fromARGB(255, 244, 6, 160))),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final double bmiValue;

  const ResultPage({super.key, required this.bmiValue});

  String getBmiStatus(double bmi) {
    if (bmi < 16)
      return 'Extreme';
    else if (bmi < 18.5)
      return 'Underweight';
    else if (bmi < 25)
      return 'Normal';
    else if (bmi < 30)
      return 'Overweight';
    else
      return 'Obese';
  }

  String getImagePath(String status) {
    switch (status) {
      case 'Extreme':
        return 'assets/extreme.png';
      case 'Underweight':
        return 'assets/underweight.png';
      case 'Normal':
        return 'assets/normal.png';
      case 'Overweight':
        return 'assets/overweight.png';
      case 'Obese':
        return 'assets/obese.png';
      default:
        return 'assets/default.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = getBmiStatus(bmiValue);
    final imagePath = getImagePath(status);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('BMI Result'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Your BMI value is',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            Text(
              bmiValue.toStringAsFixed(1),
              style: const TextStyle(fontSize: 40, color: Colors.green),
            ),
            Text(
              status,
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(height: 20),
            Image.asset(imagePath,
                height: 200), // Replace with your actual image
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Calculate Again',
                  style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
