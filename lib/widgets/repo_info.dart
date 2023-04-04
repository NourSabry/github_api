import 'package:flutter/material.dart';

class ReposInfo extends StatelessWidget {
  final String repoName;
  final String desc;
  final String ownerName;
  final Color color;
  final VoidCallback onLongPress;
  const ReposInfo({
    super.key,
    required this.desc,
    required this.ownerName,
    required this.repoName,
    required this.color,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        width: size.width,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.01,
        ),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            width: 3,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                repoName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(desc),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Owner name:"),
                Text(
                  ownerName,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
