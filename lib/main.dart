import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 200, 195, 208)),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  int result1 = 0; 
  int result2 = 0;
  int result3 = 0;
  int result4 = 0;
  int firstNum = 0; 
  int secondNum = 0; 

  // Text editing controllers for the input fields
  final TextEditingController _firstNumController = TextEditingController();
  final TextEditingController _secondNumController = TextEditingController();

  // Calculation functions
  void _calculateSum() {
    setState(() {
      result1 = firstNum + secondNum;
    });
  }

  void _calculateDifference() {
    setState(() {
      result2 = firstNum - secondNum;
    });
  }

  void _calculateProduct() {
    setState(() {
      result3 = firstNum * secondNum;
    });
  }

  void _calculateQuotient() {
    if (secondNum != 0) {
      setState(() {
        result4 = firstNum ~/ secondNum; // Integer division
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cannot divide by zero")),
      );
    }
  }

  // Clear inputs and result
  void _clearInputs() {
    setState(() {
      firstNum = 0;
      secondNum = 0;
      result1 = 0;
      result2 = 0;
      result3 = 0;
      result4 = 0;

      // Clear text field inputs
      _firstNumController.clear();
      _secondNumController.clear();
    });
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    _firstNumController.dispose();
    _secondNumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unit 5 Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // First Number and Second Number inputs
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _firstNumController, // Add controller
                    decoration: const InputDecoration(labelText: "First Number"),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        firstNum = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _secondNumController, // Add controller
                    decoration: const InputDecoration(labelText: "Second Number"),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        secondNum = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Addition Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Addition: ---->"),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _calculateSum,
                ),
                Text('= $result1'),
              ],
            ),
            const SizedBox(height: 10),

            // Subtraction Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Subtraction: ---->"),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: _calculateDifference,
                ),
                Text('= $result2'),
              ],
            ),
            const SizedBox(height: 10),

            // Multiplication Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Multiplication: ---->"),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: _calculateProduct,
                ),
                Text('= $result3'),
              ],
            ),
            const SizedBox(height: 10),

            // Division Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Division: ---->"),
                IconButton(
                  icon: const Icon(Icons.percent),
                  onPressed: _calculateQuotient,
                ),
                Text('= $result4'),
              ],
            ),
            const SizedBox(height: 30),

            // Clear Button
            ElevatedButton(
              onPressed: _clearInputs,
              child: const Text("remove"),
            ),
          ],
        ),
      ),
    );
  }
}
