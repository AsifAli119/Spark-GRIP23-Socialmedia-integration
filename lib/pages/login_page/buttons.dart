import 'package:flutter/material.dart';
class Buttons extends StatelessWidget {
  const Buttons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.deepPurpleAccent,
                boxShadow: [
            BoxShadow(
            color: Color.fromARGB(125, 95, 27, 3),
      blurRadius: 20,
      offset: Offset(0, 10),
    )
    ]
            ),
            child: Center(
              child: Text(
                "LinkedIn",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        SizedBox(width: 25,),
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(125, 95, 27, 3),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  )
                ]
            ),
            child: Center(
              child: Text(
                "Github",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),

          ),
        ),
      ],
    );
  }
}