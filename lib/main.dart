import 'package:flutter/material.dart';

const violet = Color(0xFF8B5CF6);
const violetLight = Color(0xFFF0EAFE);
const dark = Color(0xFF17151F);
const gray = Color(0xFF777381);
const background = Color(0xFFF5F4F8);
const borderColor = Color(0xFFEAE8EF);
const white = Colors.white;

void main() {
  runApp(const ClinicApp());
}

class ClinicApp extends StatelessWidget {
  const ClinicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clinic Follow-Up Reminder',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: violet,
          primary: violet,
          surface: white,
        ),
        fontFamily: 'Arial',
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: background,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: violet),
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

// LOGIN PAGE

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    if (emailController.text.trim().isEmpty ||
        !emailController.text.contains('@') ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email and password.'),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainShell()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              color: dark,
              padding: const EdgeInsets.all(48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BrandLogo(light: true),
                  const Spacer(),
                  const Text(
                    'Your health,\nour priority.',
                    style: TextStyle(
                      color: white,
                      fontSize: 46,
                      height: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Keep track of your follow-up appointments and never miss an important schedule.',
                    style: TextStyle(color: Color(0xFFB8B4C2), fontSize: 16),
                  ),
                  const SizedBox(height: 36),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF292633),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.verified_user_outlined,
                          color: violet,
                          size: 30,
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            'Your follow-up information is handled with care.',
                            style: TextStyle(color: white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'CLINIC FOLLOW-UP REMINDER SYSTEM',
                    style: TextStyle(
                      color: Color(0xFF888493),
                      fontSize: 11,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: SizedBox(
                  width: 390,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          color: violetLight,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: const Icon(
                          Icons.local_hospital_rounded,
                          color: violet,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Welcome back',
                        style: TextStyle(
                          color: dark,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Sign in to access your clinic account.',
                        style: TextStyle(color: gray),
                      ),
                      const SizedBox(height: 32),
                      const FieldLabel('Email address'),
                      const SizedBox(height: 9),
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'name@example.com',
                          prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      const SizedBox(height: 22),
                      const FieldLabel('Password'),
                      const SizedBox(height: 9),
                      TextField(
                        controller: passwordController,
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: FilledButton(
                          onPressed: login,
                          style: FilledButton.styleFrom(
                            backgroundColor: violet,
                            foregroundColor: white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Center(
                        child: Text(
                          'Clinic Follow-Up Reminder System',
                          style: TextStyle(color: gray, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// MAIN APPLICATION LAYOUT

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int selectedIndex = 0;

  final pages = const [
    DashboardPage(),
    FollowUpsPage(),
    RemindersPage(),
    ActivityPage(),
    ProfilePage(),
  ];

  final titles = [
    'Dashboard',
    'Follow-Up Schedules',
    'Reminder History',
    'Activity Logs',
    'My Profile',
  ];

  void selectPage(int index) {
    setState(() => selectedIndex = index);
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  Widget sidebar(BuildContext context) {
    final items = [
      (Icons.grid_view_rounded, 'Dashboard'),
      (Icons.calendar_month_outlined, 'Follow-Ups'),
      (Icons.notifications_none_rounded, 'Reminders'),
      (Icons.history_rounded, 'Activity Logs'),
      (Icons.person_outline_rounded, 'My Profile'),
    ];

    return Container(
      width: 245,
      color: white,
      padding: const EdgeInsets.fromLTRB(18, 26, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BrandLogo(light: false),
          const SizedBox(height: 42),
          const Padding(
            padding: EdgeInsets.only(left: 12, bottom: 12),
            child: Text(
              'MAIN MENU',
              style: TextStyle(
                color: gray,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.4,
              ),
            ),
          ),
          ...List.generate(items.length, (index) {
            final active = selectedIndex == index;
            return Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => setState(() => selectedIndex = index),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: active ? violetLight : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        items[index].$1,
                        color: active ? violet : gray,
                        size: 21,
                      ),
                      const SizedBox(width: 13),
                      Text(
                        items[index].$2,
                        style: TextStyle(
                          color: active ? violet : gray,
                          fontWeight: active
                              ? FontWeight.bold
                              : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  backgroundColor: violetLight,
                  child: Icon(Icons.person, color: violet),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Patient Account',
                        style: TextStyle(
                          color: dark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Standard user',
                        style: TextStyle(color: gray, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout, size: 18),
            label: const Text('Sign Out'),
            style: TextButton.styleFrom(foregroundColor: gray),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 850;

        return Scaffold(
          drawer: isWide ? null : Drawer(child: sidebar(context)),
          body: Row(
            children: [
              if (isWide) sidebar(context),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 76,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: const BoxDecoration(
                        color: white,
                        border: Border(bottom: BorderSide(color: borderColor)),
                      ),
                      child: Row(
                        children: [
                          if (!isWide)
                            Builder(
                              builder: (context) => IconButton(
                                onPressed: () =>
                                    Scaffold.of(context).openDrawer(),
                                icon: const Icon(Icons.menu),
                              ),
                            ),
                          Expanded(
                            child: Text(
                              titles[selectedIndex],
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: dark,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No new notifications.'),
                                ),
                              );
                            },
                            icon: const Icon(Icons.notifications_none),
                          ),
                          const SizedBox(width: 8),
                          const CircleAvatar(
                            radius: 17,
                            backgroundColor: violetLight,
                            child: Icon(Icons.person, size: 19, color: violet),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: IndexedStack(
                        index: selectedIndex,
                        children: pages,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// DASHBOARD

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Good day!',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: dark,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Here is an overview of your follow-up activities.',
            style: TextStyle(color: gray),
          ),
          const SizedBox(height: 26),
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final columns = width > 900
                  ? 4
                  : width > 560
                  ? 2
                  : 1;
              final cardWidth = (width - ((columns - 1) * 15)) / columns;

              final cards = [
                const SummaryCard(
                  title: 'Total Follow-Ups',
                  value: '08',
                  icon: Icons.calendar_month_outlined,
                  detail: 'All scheduled records',
                ),
                const SummaryCard(
                  title: 'Upcoming',
                  value: '03',
                  icon: Icons.event_available_outlined,
                  detail: 'Future appointments',
                ),
                const SummaryCard(
                  title: 'Pending Reminders',
                  value: '02',
                  icon: Icons.notifications_active_outlined,
                  detail: 'Waiting for processing',
                ),
                const SummaryCard(
                  title: 'Completed',
                  value: '05',
                  icon: Icons.check_circle_outline,
                  detail: 'Successfully completed',
                ),
              ];

              return Wrap(
                spacing: 15,
                runSpacing: 15,
                children: cards.map((card) {
                  return SizedBox(width: cardWidth, child: card);
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 30),
          const SectionHeader(
            title: 'Upcoming Follow-Ups',
            subtitle: 'Your next scheduled appointments',
          ),
          const SizedBox(height: 14),
          const FollowUpTable(),
          const SizedBox(height: 28),
          const SectionHeader(
            title: 'Recent Activity',
            subtitle: 'Latest updates on your account',
          ),
          const SizedBox(height: 14),
          const ActivityTile(
            icon: Icons.notifications_active_outlined,
            title: 'Reminder scheduled',
            subtitle: 'A follow-up reminder is waiting to be processed.',
            time: 'Today',
          ),
          const ActivityTile(
            icon: Icons.calendar_month_outlined,
            title: 'Follow-up appointment created',
            subtitle: 'Your appointment record was added.',
            time: 'Yesterday',
          ),
        ],
      ),
    );
  }
}

// FOLLOW-UP MANAGEMENT

class FollowUpsPage extends StatefulWidget {
  const FollowUpsPage({super.key});

  @override
  State<FollowUpsPage> createState() => _FollowUpsPageState();
}

class _FollowUpsPageState extends State<FollowUpsPage> {
  final List<Map<String, String>> followUps = [
    {
      'date': 'November 05, 2026',
      'time': '09:00 AM',
      'status': 'Scheduled',
      'reference': 'FU-001',
    },
    {
      'date': 'November 12, 2026',
      'time': '10:30 AM',
      'status': 'Confirmed',
      'reference': 'FU-002',
    },
    {
      'date': 'October 25, 2026',
      'time': '01:00 PM',
      'status': 'Completed',
      'reference': 'FU-003',
    },
  ];

  Future<void> addFollowUp() async {
    final dateController = TextEditingController();
    final timeController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add Follow-Up'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: 'Appointment date',
                hintText: 'e.g. November 20, 2026',
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: timeController,
              decoration: const InputDecoration(
                labelText: 'Appointment time',
                hintText: 'e.g. 09:00 AM',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (dateController.text.trim().isEmpty ||
                  timeController.text.trim().isEmpty) {
                return;
              }
              Navigator.pop(dialogContext, true);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (result == true && mounted) {
      setState(() {
        followUps.insert(0, {
          'date': dateController.text.trim(),
          'time': timeController.text.trim(),
          'status': 'Scheduled',
          'reference':
              'FU-${(followUps.length + 1).toString().padLeft(3, '0')}',
        });
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Sample follow-up added.')));
    }

    dateController.dispose();
    timeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: SectionHeader(
                  title: 'Follow-Up Schedules',
                  subtitle: 'View and manage your appointments.',
                ),
              ),
              FilledButton.icon(
                onPressed: addFollowUp,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add New'),
              ),
            ],
          ),
          const SizedBox(height: 22),
          ...followUps.map((item) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(18),
              decoration: panelDecoration,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: violetLight,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Icon(Icons.calendar_month, color: violet),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['reference']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: dark,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${item['date']} • ${item['time']}',
                          style: const TextStyle(color: gray, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  StatusBadge(status: item['status']!),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// REMINDERS

class RemindersPage extends StatelessWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reminders = [
      ('FU-001', 'November 05, 2026', 'Pending'),
      ('FU-002', 'November 12, 2026', 'Delivered'),
      ('FU-003', 'October 25, 2026', 'Delivered'),
      ('FU-004', 'October 20, 2026', 'Retrying'),
      ('FU-005', 'October 18, 2026', 'Manual Review'),
    ];

    return PageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Reminder History',
            subtitle: 'Monitor the status of your follow-up reminders.',
          ),
          const SizedBox(height: 22),
          ...reminders.map((item) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(18),
              decoration: panelDecoration,
              child: Row(
                children: [
                  const Icon(
                    Icons.notifications_none_rounded,
                    color: violet,
                    size: 25,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.$1,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: dark,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item.$2,
                          style: const TextStyle(color: gray, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  StatusBadge(status: item.$3),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ACTIVITY LOGS

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Activity Logs',
            subtitle: 'A record of recent account and reminder activities.',
          ),
          SizedBox(height: 22),
          ActivityTile(
            icon: Icons.check_circle_outline,
            title: 'Reminder delivered',
            subtitle: 'Reminder FU-002 was marked as delivered.',
            time: 'November 01, 2026',
          ),
          ActivityTile(
            icon: Icons.refresh,
            title: 'Reminder retry scheduled',
            subtitle: 'A temporary failure was recorded.',
            time: 'October 30, 2026',
          ),
          ActivityTile(
            icon: Icons.calendar_month_outlined,
            title: 'Follow-up created',
            subtitle: 'A new follow-up schedule was added.',
            time: 'October 29, 2026',
          ),
          ActivityTile(
            icon: Icons.login,
            title: 'Account accessed',
            subtitle: 'A user signed in to the system.',
            time: 'October 28, 2026',
          ),
        ],
      ),
    );
  }
}

// PROFILE

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'My Profile',
            subtitle: 'View your account information.',
          ),
          const SizedBox(height: 22),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: panelDecoration,
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 42,
                  backgroundColor: violetLight,
                  child: Icon(Icons.person, color: violet, size: 43),
                ),
                SizedBox(height: 15),
                Text(
                  'Patient Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    color: dark,
                  ),
                ),
                SizedBox(height: 5),
                Text('patient@example.com', style: TextStyle(color: gray)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const ProfileField(label: 'Full Name', value: 'Patient Account'),
          const ProfileField(
            label: 'Email Address',
            value: 'patient@example.com',
          ),
          const ProfileField(label: 'Account Role', value: 'Patient'),
        ],
      ),
    );
  }
}

// REUSABLE COMPONENTS

const panelDecoration = BoxDecoration(
  color: white,
  borderRadius: BorderRadius.all(Radius.circular(13)),
  border: Border.fromBorderSide(BorderSide(color: borderColor)),
);

class BrandLogo extends StatelessWidget {
  final bool light;

  const BrandLogo({super.key, required this.light});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: violet,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.local_hospital_rounded,
            color: white,
            size: 23,
          ),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ClinicCare',
                style: TextStyle(
                  color: light ? white : dark,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'FOLLOW-UP SYSTEM',
                style: TextStyle(
                  color: light ? Colors.white60 : gray,
                  fontSize: 9,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FieldLabel extends StatelessWidget {
  final String text;

  const FieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: dark, fontWeight: FontWeight.w600),
    );
  }
}

class PageContainer extends StatelessWidget {
  final Widget child;

  const PageContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1250),
          child: child,
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: dark,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(subtitle, style: const TextStyle(color: gray, fontSize: 13)),
      ],
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final String detail;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: panelDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(color: gray, fontSize: 12),
                ),
              ),
              Icon(icon, color: violet, size: 22),
            ],
          ),
          const SizedBox(height: 17),
          Text(
            value,
            style: const TextStyle(
              color: dark,
              fontWeight: FontWeight.bold,
              fontSize: 29,
            ),
          ),
          const SizedBox(height: 5),
          Text(detail, style: const TextStyle(color: gray, fontSize: 11)),
        ],
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color = gray;
    Color fill = background;

    if (status == 'Delivered' ||
        status == 'Completed' ||
        status == 'Confirmed') {
      color = const Color(0xFF287D55);
      fill = const Color(0xFFE7F5EC);
    } else if (status == 'Pending' || status == 'Scheduled') {
      color = violet;
      fill = violetLight;
    } else if (status == 'Retrying') {
      color = const Color(0xFF9A6B1F);
      fill = const Color(0xFFFFF4DD);
    } else if (status == 'Manual Review' || status == 'Failed') {
      color = const Color(0xFFB54747);
      fill = const Color(0xFFFFEAEA);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }
}

class FollowUpTable extends StatelessWidget {
  const FollowUpTable({super.key});

  @override
  Widget build(BuildContext context) {
    final records = [
      ('FU-001', 'November 05, 2026', '09:00 AM', 'Scheduled'),
      ('FU-002', 'November 12, 2026', '10:30 AM', 'Confirmed'),
      ('FU-003', 'October 25, 2026', '01:00 PM', 'Completed'),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: panelDecoration,
      child: Column(
        children: records.map((record) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  color: violet,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record.$1,
                        style: const TextStyle(
                          color: dark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${record.$2} • ${record.$3}',
                        style: const TextStyle(color: gray, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                StatusBadge(status: record.$4),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ActivityTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;

  const ActivityTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.all(17),
      decoration: panelDecoration,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: violetLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: violet, size: 21),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: dark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(color: gray, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(time, style: const TextStyle(color: gray, fontSize: 10)),
        ],
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final String value;

  const ProfileField({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: panelDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: gray, fontSize: 12)),
          const SizedBox(height: 7),
          Text(
            value,
            style: const TextStyle(color: dark, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
