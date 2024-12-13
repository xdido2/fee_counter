import 'package:flutter/material.dart';

void main() {
  runApp(const TipCalculatorApp());
}

class TipCalculatorApp extends StatelessWidget {
  const TipCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      home: const TipCalculatorScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class TipCalculatorScreen extends StatefulWidget {
  const TipCalculatorScreen({super.key});

  @override
  State<TipCalculatorScreen> createState() => _TipCalculatorScreenState();
}

class _TipCalculatorScreenState extends State<TipCalculatorScreen> {
  double billAmount = 0.0;
  double tipPercentage = 0.0;
  int peopleCount = 1;

  double get totalTip => billAmount * (tipPercentage / 100);

  double get totalPerPerson => (billAmount + totalTip) / peopleCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Bill Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  billAmount = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text('Tip Percentage: ${tipPercentage.toStringAsFixed(0)}%'),
                Expanded(
                  child: Slider(
                    value: tipPercentage,
                    min: 0,
                    max: 30,
                    divisions: 30,
                    label: tipPercentage.toStringAsFixed(0),
                    onChanged: (value) {
                      setState(() {
                        tipPercentage = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Number of People',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  peopleCount = int.tryParse(value) ?? 1;
                  if (peopleCount < 1) peopleCount = 1;
                });
              },
            ),
            const SizedBox(height: 16),
            Text('Total Tip: \$${totalTip.toStringAsFixed(2)}'),
            Text('Total Per Person: \$${totalPerPerson.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
