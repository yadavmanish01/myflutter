import 'package:flutter/material.dart';


class EmptyDataPage extends StatelessWidget {
  final String message;
  final VoidCallback? onRefresh;

  const EmptyDataPage({
    super.key,
    this.message = "No data available",
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// ICON
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.inbox_outlined,
                size: 50,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 20),


            const Text(
              "Nothing here",
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
              onPressed: onRefresh ?? () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text("Refresh",style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(height: 50),
            // ElevatedButton(
            //   onPressed: (){Get.back();},
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.red,
            //     padding: const EdgeInsets.symmetric(
            //         horizontal: 28, vertical: 12),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(25),
            //     ),
            //   ),
            //   child: const Text("Back",style: TextStyle(color: Colors.white),),
            // )
          ],
        ),
      ),
    );
  }
}
