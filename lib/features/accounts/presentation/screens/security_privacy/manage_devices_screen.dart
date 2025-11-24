import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ManageDevicesScreen extends ConsumerStatefulWidget {
  const ManageDevicesScreen({super.key});

  @override
  ConsumerState<ManageDevicesScreen> createState() =>
      _ManageDevicesScreenState();
}

class _ManageDevicesScreenState extends ConsumerState<ManageDevicesScreen> {
  // Mock Data for UI demonstration
  final List<Map<String, dynamic>> _otherDevices = [
    {
      "name": "MacBook Air M2",
      "os": "macOS Sonoma",
      "location": "Cebu City, PH",
      "lastActive": "Active 2 hours ago",
      "type": Icons.laptop_mac_rounded,
    },
    {
      "name": "Chrome on Windows",
      "os": "Windows 11",
      "location": "Davao City, PH",
      "lastActive": "Active 5 days ago",
      "type": Icons.desktop_windows_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: colorScheme.onSurface,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          "Manage Devices",
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            // 1. Header Illustration
            _buildHeader(colorScheme),

            const SizedBox(height: 30),

            // 2. Current Device Section
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 10),
              child: Text(
                "Current Device",
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildDeviceCard(
              context,
              name: "iPhone 15 Pro",
              details: "iOS 17 • Pagadian City, PH",
              status: "Active Now",
              icon: Icons.phone_iphone_rounded,
              isCurrent: true,
              colorScheme: colorScheme,
            ),

            const SizedBox(height: 25),

            // 3. Other Devices Section
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 10),
              child: Text(
                "Other Devices",
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // List of other devices
            ..._otherDevices.map(
              (device) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildDeviceCard(
                  context,
                  name: device['name'],
                  details: "${device['os']} • ${device['location']}",
                  status: device['lastActive'],
                  icon: device['type'],
                  isCurrent: false,
                  colorScheme: colorScheme,
                  onRevoke: () {
                    // Todo: Handle logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Logged out from ${device['name']}"),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 4. Sign Out All Action
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: () {
                  // TODO: Implement Sign Out All Logic
                },
                icon: Icon(Icons.shield_outlined, color: colorScheme.error),
                label: Text(
                  "Sign out all other devices",
                  style: TextStyle(
                    color: colorScheme.error,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: colorScheme.errorContainer.withValues(
                    alpha: 0.2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: colorScheme.error.withValues(alpha: 0.2),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "You will remain logged in on this device.",
              textAlign: TextAlign.center,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildHeader(ColorScheme colorScheme) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.secondaryContainer.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.devices_other_rounded,
              size: 48,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Where you're logged in",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Manage access to your account\nacross your devices.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceCard(
    BuildContext context, {
    required String name,
    required String details,
    required String status,
    required IconData icon,
    required bool isCurrent,
    required ColorScheme colorScheme,
    VoidCallback? onRevoke,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: isCurrent
            ? Border.all(
                color: colorScheme.primary.withValues(alpha: 0.3),
                width: 1.5,
              )
            : null,
      ),
      child: Row(
        children: [
          // Device Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isCurrent
                  ? colorScheme.primary.withValues(alpha: 0.1)
                  : colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isCurrent
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
              size: 24,
            ),
          ),

          const SizedBox(width: 16),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  details,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (isCurrent)
                      Container(
                        margin: const EdgeInsets.only(right: 6),
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isCurrent
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isCurrent
                            ? Colors.green
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action Button (Only for other devices)
          if (!isCurrent)
            IconButton(
              onPressed: onRevoke,
              icon: const Icon(Icons.logout_rounded),
              color: colorScheme.onSurfaceVariant,
              tooltip: "Log out device",
            ),
        ],
      ),
    );
  }
}
