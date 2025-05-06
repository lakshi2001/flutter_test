import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: const Text('Settings'),
              stretch: true,
              backgroundColor: CupertinoColors.systemGroupedBackground,
              trailing: const Icon(CupertinoIcons.gear),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CupertinoSearchTextField(
                  placeholder: 'Search settings',
                  onChanged: (value) {},
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    _buildSettingsItem(
                      'Notifications',
                      CupertinoIcons.bell,
                      onTap: () {},
                    ),
                    _buildSettingsItem(
                      'Appearance',
                      CupertinoIcons.person,
                      onTap: () {},
                    ),
                    _buildSettingsItem(
                      'Privacy',
                      CupertinoIcons.lock,
                      onTap: () {},
                    ),
                    _buildSettingsItem(
                      'Terms & Conditions',
                      CupertinoIcons.doc_text,
                      onTap: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (_) => CupertinoActionSheet(
                            title: const Text('Terms & Conditions'),
                            message: const Text(
                              'These are placeholder Terms & Conditions.\n\nSwipe down to dismiss.',
                            ),
                            cancelButton: CupertinoActionSheetAction(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Profile Card',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(50, 173, 216, 230),
                                Color.fromARGB(80, 135, 206, 250),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Profile Card',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(String title, IconData icon, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: CupertinoColors.separator,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: CupertinoColors.activeBlue),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            const Icon(
              CupertinoIcons.chevron_right,
              color: CupertinoColors.systemGrey,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
