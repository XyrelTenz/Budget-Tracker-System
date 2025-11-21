import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_budget_ph/core/routes/app_routes.dart';
import "package:smart_budget_ph/features/onboarding/data/onboardingpage_model.dart";

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
    // Capture theme shortcuts to keep code clean
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              bottom: 100,
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
                                // Use your Oswald Font
                                style: textTheme.titleLarge?.copyWith(
                                  color: colorScheme
                                      .onSurface, // Black in Light, White in Dark
                                  fontWeight: FontWeight.bold,
                                  height: 1.2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                item.description,
                                // Use your Merriweather Font
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme
                                      .onSurfaceVariant, // Standard "Grey" text
                                  fontSize: 16,
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

            // 2. Top Right Skip Button
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
                      color: colorScheme.onSurfaceVariant, // Adaptive Grey
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
                          // Blue if active, Grey if inactive
                          color: _currentPage == index
                              ? colorScheme.primary
                              : colorScheme
                                    .outlineVariant, // M3 Standard inactive color
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
                        color: colorScheme.primary, // Your Brand Blue
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.primary.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: isLastPage
                          ? Text(
                              "Get Started",
                              style: TextStyle(
                                color: colorScheme.onPrimary, // White text
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )
                          : Icon(
                              Icons.arrow_forward,
                              color: colorScheme.onPrimary, // White Icon
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
