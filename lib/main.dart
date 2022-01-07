import 'package:flutter/material.dart';

void main() =>
    runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Home()));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1500),
        reverseDuration: const Duration(milliseconds: 1500))
      ..forward();
    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        _animationController.reverse();
      } else if (_animationController.isDismissed) {
        _animationController.forward();
      }
      setState(() {});
    });
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animation = Tween(begin: -.6, end: .4).animate(_animation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: SizedBox(
                    height: 350,
                    width: 300,
                    child: Stack(children: [
                      /// man
                      Positioned(
                          right: 10,
                          child: SizedBox(
                              width: 200,
                              child: Image.asset('assets/man.png',
                                  fit: BoxFit.fitHeight))),

                      /// fish
                      Positioned(
                          left: 74,
                          child: Transform(
                              alignment: const FractionalOffset(.55, 0),
                              transform: Matrix4.rotationZ(_animation.value),
                              child: SizedBox(
                                  width: 30,
                                  height: 250,
                                  child: Image.asset('assets/fish.png',
                                      fit: BoxFit.fitHeight))))
                    ])))));
  }
}
