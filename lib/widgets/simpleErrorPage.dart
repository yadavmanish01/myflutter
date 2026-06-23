import 'package:flutter/material.dart';


class SimpleErrorPage extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const SimpleErrorPage({
    super.key,
    this.message = "There is some error.\nPlease try again.",
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// ERROR ICON
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 50,
              ),
            ),

            const SizedBox(height: 20),

            /// TITLE
            const Text(
              "Oops!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 25),


            ElevatedButton(
              onPressed: onRetry ?? () {},
              style: ElevatedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                "Retry",
                style: TextStyle(fontSize: 15,color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
