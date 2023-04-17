import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nymble_app/routers/routes.dart';

class DialodWithCelebration extends StatefulWidget {
  final String title;
  final String content;
  const DialodWithCelebration(
      {super.key, required this.title, required this.content});

  @override
  State<DialodWithCelebration> createState() => _DialodWithCelebrationState();
}

class _DialodWithCelebrationState extends State<DialodWithCelebration> {
  late ConfettiController confettiController;

  @override
  initState() {
    super.initState();
    confettiController = ConfettiController(
      duration: const Duration(milliseconds: 800),
    );
    confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
          title: Text(widget.title),
          content: Text(widget.content),
          actions: [
            Stack(
              children: [
                FilledButton.tonalIcon(
                  icon: const Icon(Icons.home_outlined),
                  label: const Text("Back to Home"),
                  onPressed: () {
                    context.go(homeRoute);
                  },
                ),
                Align(
                  alignment: Alignment.center,
                  child: ConfettiWidget(
                    confettiController: confettiController,
                    blastDirection: 270,
                    numberOfParticles: 20,
                    blastDirectionality: BlastDirectionality.explosive,
                    gravity: 0.1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
