import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_budget_ph/routes/helper/routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPageModel> _pages = <OnboardingPageModel>[
    OnboardingPageModel(
      title: 'Track Your Expenses',
      description: 'Keep all your daily expenses organized in one place.',
      imageUrl: 'assets/expenses.png',
    ),
    OnboardingPageModel(
      title: 'Plan Your Budget',
      description: 'Set budgets for your categories and stick to them easily.',
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
  ];

  @override
  Widget build(BuildContext context) {
    bool isLastPage = _currentPage == _pages.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // 1. The Page Content
            Positioned.fill(
              bottom: 100, // Leave space for bottom bar
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (idx) {
                  setState(() {
                    _currentPage = idx;
                  });
                },
                itemBuilder: (context, index) {
                  final item = _pages[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      // Image Area
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Image.asset(
                            item.imageUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Text Area
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  height: 1.2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                item.description,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // 2. Top Right Skip Button (Hidden on last page)
            Positioned(
              top: 20,
              right: 20,
              child: AnimatedOpacity(
                opacity: isLastPage ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: TextButton(
                  onPressed: isLastPage ? null : () => context.go(Routes.login),
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            // 3. Bottom Navigation Area
            Positioned(
              bottom: 30,
              left: 30,
              right: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page Indicators (Dots)
                  Row(
                    children: List.generate(
                      _pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 6),
                        height: 6,
                        width: _currentPage == index ? 24 : 6,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? const Color(0xFF0046FF)
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      if (isLastPage) {
                        context.go(Routes.login);
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 50,
                      width: isLastPage ? 140 : 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0046FF),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF0046FF,
                            ).withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: isLastPage
                          ? const Text(
                              "Get Started",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )
                          : const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
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

// Simplified Model (removed unused textColor)
class OnboardingPageModel {
  final String title;
  final String description;
  final String imageUrl;

  OnboardingPageModel({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}
