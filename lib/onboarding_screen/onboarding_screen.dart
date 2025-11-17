import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingPagePresenter(
        pages: [
          OnboardingPageModel(
            title: 'Track Your Expenses',
            description: 'Keep all your daily expenses organized in one place.',
            imageUrl: 'assets/expenses.png',
          ),
          OnboardingPageModel(
            title: 'Plan Your Budget',
            description:
                'Set budgets for your categories and stick to them easily.',
            imageUrl: 'assets/finance.png',
          ),
          OnboardingPageModel(
            title: 'Monitor Spending',
            description: 'Visual charts help you analyze your spending habits.',
            imageUrl: 'assets/location.png',
          ),
          OnboardingPageModel(
            title: 'Save More',
            description: 'Track your progress and save more efficiently.',
            imageUrl: 'assets/start.png',
          ),
        ],
      ),
    );
  }
}

class OnboardingPagePresenter extends StatefulWidget {
  final List<OnboardingPageModel> pages;

  const OnboardingPagePresenter({super.key, required this.pages});

  @override
  State<OnboardingPagePresenter> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPagePresenter> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.pages.length,
                onPageChanged: (idx) {
                  setState(() {
                    _currentPage = idx;
                  });
                },
                itemBuilder: (context, idx) {
                  final item = widget.pages[idx];
                  return Column(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Image.asset(item.imageUrl),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                item.title,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: item.textColor,
                                    ),
                              ),
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 280),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 8,
                              ),
                              child: Text(
                                item.description,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: item.textColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.pages.map((item) {
                final idx = widget.pages.indexOf(item);
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: _currentPage == idx ? 30 : 8,
                  height: 8,
                  margin: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: _currentPage == idx ? Colors.blue[700] : Colors.grey,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                );
              }).toList(),
            ),

            // Bottom buttons
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.comfortable,
                      foregroundColor: Colors.black,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      context.go("/Login");
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        color: Color(0xFF313131),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.comfortable,
                      foregroundColor: Colors.black,
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      if (_currentPage == widget.pages.length - 1) {
                        context.go("/Login");
                      } else {
                        _pageController.animateToPage(
                          _currentPage + 1,
                          curve: Curves.easeInOutCubic,
                          duration: const Duration(milliseconds: 250),
                        );
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          _currentPage == widget.pages.length - 1
                              ? "Finish"
                              : "Next",
                          style: TextStyle(
                            color: Color(0xFF313131),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          _currentPage == widget.pages.length - 1
                              ? Icons.done
                              : Icons.arrow_forward,
                          color: Color(0xFF313131),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPageModel {
  final String title;
  final String description;
  final String imageUrl;
  final Color textColor;

  OnboardingPageModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    this.textColor = Colors.black, // fixed color
  });
}
