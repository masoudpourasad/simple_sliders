import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sliders')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildSlider("Default Material Slider", const SimpleSlider()),
              _buildSlider("Default iOS Slider", const IosSlider()),
              _buildSlider(
                  "Custom Colors",
                  const SimpleSlider(
                      thumbColor: Colors.green,
                      activeColor: Colors.lightGreen,
                      inactiveColor: Colors.lightGreenAccent)),
              _buildSlider("Default Slider with divisions",
                  const SimpleSlider(divisions: 5)),
              _buildSlider(
                  "Paddle Thumb Overlay",
                  const CustomThumbShape(
                      valueIndicatorShape: PaddleSliderValueIndicatorShape())),
              _buildSlider(
                  "Rectangular Thumb Overlay",
                  const CustomThumbShape(
                      valueIndicatorShape:
                          RectangularSliderValueIndicatorShape())),
            ]),
      ),
    );
  }

  Widget _buildSlider(String title, Widget child) {
    return SizedBox(
      width: double.infinity,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[Text(title), child, const Divider()]),
    );
  }
}

class SimpleSlider extends StatefulWidget {
  final Color? thumbColor, activeColor, inactiveColor;
  final int? divisions;

  const SimpleSlider(
      {super.key,
      this.thumbColor,
      this.activeColor,
      this.inactiveColor,
      this.divisions});

  @override
  State<SimpleSlider> createState() => _SimpleSliderState();
}

class _SimpleSliderState extends State<SimpleSlider> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _currentSliderValue,
      min: 0,
      max: 100,
      label: _currentSliderValue.toInt().toString(),
      thumbColor: widget.thumbColor,
      activeColor: widget.activeColor,
      inactiveColor: widget.inactiveColor,
      divisions: widget.divisions,
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
        });
      },
    );
  }
}

class IosSlider extends StatefulWidget {
  const IosSlider({super.key});

  @override
  State<IosSlider> createState() => _IosSliderState();
}

class _IosSliderState extends State<IosSlider> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return CupertinoSlider(
      value: _currentSliderValue,
      min: 0,
      max: 100,
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
        });
      },
    );
  }
}

class CustomThumbShape extends StatelessWidget {
  final SliderComponentShape valueIndicatorShape;
  const CustomThumbShape({super.key, required this.valueIndicatorShape});

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
        data: SliderTheme.of(context)
            .copyWith(valueIndicatorShape: valueIndicatorShape),
        child: const SimpleSlider(divisions: 100));
  }
}
