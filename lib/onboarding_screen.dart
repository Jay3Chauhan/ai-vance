/*
 * Copyright (C) 2026 Jay Chauhan <contact@jaychauhan.tech>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kOnboardingCompletedKey = 'onboarding_completed';

/// Returns whether the onboarding flow has been completed on this device.
Future<bool> hasCompletedOnboarding() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_kOnboardingCompletedKey) ?? false;
}

/// Marks onboarding as completed for this device.
Future<void> setOnboardingCompleted() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_kOnboardingCompletedKey, true);
}

/// First-run onboarding flow.
///
/// This provides a short, non-interactive walkthrough and finishes by calling
/// [onComplete]. It stores completion state in `SharedPreferences`.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    super.key,
    required this.onComplete,
  });

  /// Called when onboarding finishes.
  final void Function(bool showTutorial) onComplete;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final _totalPages = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _finish(skipHelp: true);
    }
  }

  void _finish({bool skipHelp = true}) {
    setOnboardingCompleted();
    widget.onComplete(!skipHelp);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Skip button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/ai_vance_logo.png',
                        width: 32,
                        height: 32,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'AI Vance',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onSurface,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                  if (_currentPage < _totalPages - 1)
                    TextButton(
                      onPressed: () => _finish(skipHelp: true),
                      child: Text(
                        'Skip',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  else
                    const SizedBox(height: 48),
                ],
              ),
            ),

            // Page Content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: [
                  _OnboardingPage(
                    imageAsset: 'assets/ai_vance_logo.png',
                    title: 'Welcome to AI Vance',
                    subtitle: 'Private On-Device Intelligence',
                    body: 'Run state-of-the-art language models directly on your smartphone. Experience instantaneous AI assistance with zero cloud dependency and complete privacy.',
                  ),
                  _OnboardingPage(
                    icon: Icons.shield_outlined,
                    iconGradient: const [Color(0xFF00D4FF), Color(0xFF0284C7)],
                    title: '100% Private & Offline',
                    subtitle: 'Your Data Never Leaves Your Device',
                    body: 'All neural network computations happen locally on your processor. No tracking, no external servers, and no internet required once your model is loaded.',
                  ),
                  _OnboardingPage(
                    icon: Icons.memory_rounded,
                    iconGradient: const [Color(0xFF0284C7), Color(0xFF8B5CF6)],
                    title: 'Open GGUF Architecture',
                    subtitle: 'Powered by llama.cpp',
                    body: 'Download curated models tailored to your phone\'s RAM, or easily import your own favorite quantized GGUF weights from your storage.',
                  ),
                  _OnboardingPage(
                    icon: Icons.rocket_launch_rounded,
                    iconGradient: const [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                    title: 'Ready to Explore',
                    subtitle: 'Supercharge Your Workflow',
                    body: 'Load a model, customize parameters like temperature and context length, and start having deep, insightful conversations with your AI companion.',
                  ),
                ],
              ),
            ),

            // Bottom Navigation & Indicators
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
              child: Row(
                children: [
                  // Indicators
                  Row(
                    children: List.generate(_totalPages, (i) {
                      final isActive = _currentPage == i;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 6),
                        width: isActive ? 28 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isActive
                              ? colorScheme.primary
                              : colorScheme.outline.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const Spacer(),
                  // Next / Get Started Button
                  FilledButton(
                    onPressed: _next,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      _currentPage == _totalPages - 1 ? 'Get Started' : 'Next',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
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

/// Single page within the onboarding flow.
class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    this.icon,
    this.iconGradient,
    this.imageAsset,
    required this.title,
    required this.subtitle,
    required this.body,
  });

  final IconData? icon;
  final List<Color>? iconGradient;
  final String? imageAsset;
  final String title;
  final String subtitle;
  final String body;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imageAsset != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Image.asset(
                imageAsset!,
                width: 130,
                height: 130,
                fit: BoxFit.contain,
              ),
            )
          else if (icon != null)
            Container(
              padding: const EdgeInsets.all(26),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: iconGradient ?? [colorScheme.primary, colorScheme.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (iconGradient?.first ?? colorScheme.primary).withValues(alpha: 0.35),
                    blurRadius: 28,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: 58,
                color: Colors.white,
              ),
            ),
          const SizedBox(height: 36),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: colorScheme.onSurface,
              letterSpacing: -0.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            body,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              height: 1.6,
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
