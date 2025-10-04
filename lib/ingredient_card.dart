import 'package:flutter/material.dart';

class IngredientCard extends StatelessWidget {
    const IngredientCard({
    super.key,
    required this.name,
    required this.quantity
  });

  final String name;
  final int quantity;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        //Open popup
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            children: [
              Text(name),
              Spacer(),
              Text("$quantity g")
            ],
          ),
          ), 
      )
    );
  }
}