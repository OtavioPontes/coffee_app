import 'package:coffee_app/src/domain/entities/coffee.dart';
import 'package:coffee_app/src/presentation/pages/coffee_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const _duration = Duration(milliseconds: 300);
const _initialPage = 8.0;

class CoffeePage extends StatefulWidget {
  @override
  _CoffeePageState createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage> {
  final PageController _pageController = PageController(
    viewportFraction: 0.35,
    initialPage: _initialPage.toInt(),
  );
  final PageController _pageTextController = PageController(
    initialPage: _initialPage.toInt(),
  );

  double _currentPage = _initialPage;
  double _textPage = _initialPage;

  void _coffeeScrollListener() {
    setState(() {
      _currentPage = _pageController.page!;
    });
  }

  void _coffeeTextScrollListener() {
    setState(() {
      _textPage = _currentPage;
    });
  }

  @override
  void initState() {
    _pageController.addListener(_coffeeScrollListener);
    _pageTextController.addListener(_coffeeTextScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_coffeeScrollListener);
    _pageController.dispose();
    _pageTextController.removeListener(_coffeeTextScrollListener);
    _pageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            left: 20,
            right: 20,
            bottom: -size.height * 0.22,
            height: size.height * 0.3,
            child: DecoratedBox(
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                  color: Colors.brown,
                  blurRadius: 90,
                  offset: Offset.zero,
                  spreadRadius: 45,
                )
              ]),
            ),
          ),
          Transform.scale(
            scale: 1.7,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
              onPageChanged: (value) {
                if (value < coffees.length) {
                  _pageTextController.animateToPage(
                    value,
                    duration: _duration,
                    curve: Curves.easeOut,
                  );
                }
              },
              controller: _pageController,
              itemCount: coffees.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return SizedBox.shrink();
                }
                final coffee = coffees[index - 1];
                final result = _currentPage - index + 1;
                final value = -0.4 * result + 1;
                final opacity = value.clamp(0.0, 1.0);

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 650),
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return FadeTransition(
                              opacity: animation,
                              child: CoffeeDetails(
                                coffee: coffee,
                              ),
                            );
                          }),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..translate(
                          0.0,
                          size.height / 2.6 * (1 - value).abs(),
                        )
                        ..scale(value),
                      child: Opacity(
                        opacity: opacity,
                        child: Hero(
                          tag: coffee.image,
                          child: Image.asset(
                            coffee.image,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            height: 100,
            child: TweenAnimationBuilder<double>(
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0.0, -100 * value),
                  child: child!,
                );
              },
              tween: Tween(begin: 1.0, end: 0.0),
              duration: _duration,
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageTextController,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: coffees.length,
                      itemBuilder: (context, index) {
                        final opacity =
                            (1 - (index - _textPage).abs()).clamp(0.0, 1.0);
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.2),
                          child: Opacity(
                            opacity: opacity,
                            child: Hero(
                              tag: "text_${coffees[index].name}",
                              child: Text(
                                coffees[index].name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  AnimatedSwitcher(
                    key: Key(coffees[_currentPage.toInt()].name),
                    duration: _duration,
                    child: Text(
                      "R\$ ${coffees[_currentPage.toInt()].price.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
