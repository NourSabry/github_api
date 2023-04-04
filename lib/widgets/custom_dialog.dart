import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final VoidCallback repoLaunch;
  final VoidCallback ownerLaunch;
  const CustomDialog({
    super.key,
    required this.ownerLaunch,
    required this.repoLaunch,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20.0,
        ),
      ), //this right here
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: repoLaunch,
                child: const Text(
                  "go to repo",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: ownerLaunch,
                child: const Text(
                  "go to owner",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}