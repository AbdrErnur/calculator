import 'package:calculator/operation_enum.dart';
import 'package:flutter/material.dart';

final styleButton = ElevatedButton.styleFrom(
  minimumSize: const Size(80, 60),
  shape: const CircleBorder(),
  padding: const EdgeInsets.all(7.0),
  primary: Colors.black,
);
const styleText = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  num currentValue = 0.0;
  OperationEnum currentOperation = OperationEnum.equal;
  OperationEnum lastOperation = OperationEnum.equal;

  num num1 = 0, result = 0;

  void onNumberPressed(int i) {
    setState(() {
      if (currentOperation != OperationEnum.equal && num1 == currentValue) {
        currentValue = 0; //8
      }
      if (currentValue == 0) {
        currentValue = i;
      } else {
        currentValue = currentValue * 10 + i;
      }
    });
  }

  void onOperationPressed(OperationEnum element) {
    if(currentOperation!=OperationEnum.equal){
      lastOperation = currentOperation;
    }
    if(element!=OperationEnum.equal){
      num1 = currentValue;
    } else {
      fn();
    }
    currentOperation = element;
    setState(() {});
  }

  void fn() {
    switch (currentOperation) {
      case OperationEnum.plus:
        {
          currentValue += num1;
        }
      case OperationEnum.minus:
        {
          currentValue = num1 - currentValue;
        }
      case OperationEnum.multiply:
        {
          currentValue *= num1;
        }
      case OperationEnum.divide:
        {
          currentValue /= num1;
        }
      case OperationEnum.equal:{
        switch(lastOperation){
          case OperationEnum.plus:
            currentValue += num1;
          case OperationEnum.minus:
            currentValue -= num1;
          case OperationEnum.multiply:
            currentValue *= num1;
          case OperationEnum.divide:
            currentValue /= num1;
          case OperationEnum.equal:
        }
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    final String cur = currentValue % 1 == 0.0
        ? '${currentValue.toInt()}'
        : currentValue.toString();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Text(
            cur,
            style: const TextStyle(color: Colors.white, fontSize: 42),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ElevatedButton(
                      onPressed: () {
                        currentValue = 0;
                        num1 = 0;
                        currentOperation = OperationEnum.equal;
                        lastOperation = OperationEnum.equal;
                        setState(() {});
                      },
                      style: styleButton,
                      child: Text('C',
                          style: styleText.copyWith(color: Colors.yellow)),
                    ),
                  ),
                  for (final i in [7, 4, 1])
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                          style: styleButton,
                          onPressed: () => onNumberPressed(i),
                          child: Text(
                            '$i',
                            style: styleText,
                          )),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: styleButton,
                      child: const Text('хз'),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ElevatedButton(
                      onPressed: () {
                        currentValue = currentValue ~/ 10;
                        setState(() {});
                      },
                      style: styleButton,
                      child: const Icon(Icons.backspace_outlined),
                    ),
                  ),
                  for (final i in [8, 5, 2, 0])
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                          style: styleButton,
                          onPressed: () => onNumberPressed(i),
                          child: Text(
                            '$i',
                            style: styleText,
                          )),
                    ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: styleButton,
                      child: const Icon(Icons.percent),
                    ),
                  ),
                  for (final i in [9, 6, 3])
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                          style: styleButton,
                          onPressed: () => onNumberPressed(i),
                          child: Text(
                            '$i',
                            style: styleText,
                          )),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: styleButton,
                      child: const Text('.'),
                    ),
                  ),
                ],
              ),
              Column(
                children: OperationEnum.values
                    .map((element) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () => onOperationPressed(element),
                            style: styleButton,
                            child: Text(
                              element.sign,
                              style: styleText.copyWith(
                                  color: currentOperation == element &&
                                          currentOperation !=
                                              OperationEnum.equal
                                      ? Colors.red
                                      : Colors.white),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          )
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
