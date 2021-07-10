import 'package:coffee_app/src/domain/entities/coffee.dart';
import 'package:flutter/material.dart';

class CoffeeDetails extends StatelessWidget {
  final Coffee coffee;

  const CoffeeDetails({
    Key? key,
    required this.coffee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.2,
            ),
            child: Hero(
              tag: "text${coffee.name}",
              child: Material(
                child: Text(
                  coffee.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: size.height * 0.4,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Hero(
                      tag: coffee.image,
                      child: Image.asset(
                        coffee.image,
                        fit: BoxFit.fitHeight,
                      )),
                ),
                Positioned(
                  left: size.width * 0.05,
                  bottom: 0,
                  child: Text(
                    "R\$ ${coffee.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          spreadRadius: 20,
                        )
                      ],
                      fontSize: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
