import 'package:cashcue/util/widgets.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _goToNextPage() {
    if (_currentPage < 2) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => Login()),
      // );
    }
  }

  Widget _pages(String imagePath,String title,String description) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height*.1),
        Container(
          child: Image.asset(
            imagePath,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(height: 10),
        Container(
           child: CustomText(
                text: title,
                color: Color(0xFF212325),
                fontSize: 22,
                fontweigth: FontWeight.bold,
                ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: CustomText(
                text:  description,
                color: Color(0xFF91919F),
                fontSize: 15,
                fontweigth: FontWeight.w500,
              ),
        ),
      ],
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              _pages(
                 'assets/images/',
                'Gain total control of your money',
                'Become your own money manager and make every cent count',
              ),
              _pages(
                 'assets/images/',
                'Know where your money goes',         
                 'Track your transaction easily, with categories and financial report',
              ),
              _pages(
                 'assets/images/',
                'Planning ahead',
                'Setup your budget for each category so you in control'
              ),
            ],
          ),
          Positioned(
            bottom: 120,
            left: 160,
            child: Container(
                height: 25,
                width: 70,
                //decoration: BoxDecoration(color: Colors.grey,shape: BoxShape.rectangle,borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: index == _currentPage ? Color(0xFFBA6AE7) : Color(0xFFEEE5FF),
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ),
          ),
        ],
      ),
    );
  }
}

  
