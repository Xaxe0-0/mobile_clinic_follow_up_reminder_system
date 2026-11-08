import 'package:flutter/material.dart';

import 'services/api_service.dart';

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
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || !email.contains('@') || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email and password.'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await ApiService.login(email: email, password: password);

      if (!mounted) return;

      final user = Map<String, dynamic>.from(response['user']);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MainShell(user: user)),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceFirst('Exception: ', '')),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 850;

          final loginForm = Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 390),
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
                    const SizedBox(height: 25),
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
                    const SizedBox(height: 30),
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
                        onPressed: isLoading ? null : login,
                        style: FilledButton.styleFrom(
                          backgroundColor: violet,
                          foregroundColor: white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: white,
                                ),
                              )
                            : const Text(
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
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );

          if (isWide) {
            return Row(
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
                          style: TextStyle(
                            color: Color(0xFFB8B4C2),
                            fontSize: 16,
                          ),
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
                Expanded(flex: 5, child: loginForm),
              ],
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 35, 24, 30),
                  color: dark,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BrandLogo(light: true),
                      SizedBox(height: 25),
                      Text(
                        'Your health,\nour priority.',
                        style: TextStyle(
                          color: white,
                          fontSize: 28,
                          height: 1.2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Keep track of your follow-up appointments and never miss an important schedule.',
                        style: TextStyle(
                          color: Color(0xFFB8B4C2),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                loginForm,
              ],
            ),
          );
        },
      ),
    );
  }
}

// MAIN APPLICATION LAYOUT

class MainShell extends StatefulWidget {
  final Map<String, dynamic> user;

  const MainShell({super.key, required this.user});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int selectedIndex = 0;
  bool isLoggingOut = false;

  late final List<Widget> pages = [
    const DashboardPage(),
    const FollowUpsPage(),
    const RemindersPage(),
    const ActivityPage(),
    ProfilePage(user: widget.user),
  ];

  final titles = [
    'Dashboard',
    'Follow-Up Schedules',
    'Reminder History',
    'Activity Logs',
    'My Profile',
  ];

  String get userName => widget.user['name']?.toString() ?? 'Patient Account';

  String get userEmail => widget.user['email']?.toString() ?? '';

  Future<void> signOut() async {
    if (isLoggingOut) return;

    setState(() {
      isLoggingOut = true;
    });

    try {
      await ApiService.logout();

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logout failed: $error'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoggingOut = false;
        });
      }
    }
  }

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
                onTap: () {
                  if (context.findAncestorWidgetOfExactType<Drawer>() != null) {
                    Navigator.pop(context);
                  }
                  setState(() => selectedIndex = index);
                },
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
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: violetLight,
                  child: Icon(Icons.person, color: violet),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: dark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.user['role']?.toString() ?? 'User',
                        style: const TextStyle(color: gray, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: isLoggingOut ? null : signOut,
            icon: isLoggingOut
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.logout, size: 18),
            label: Text(isLoggingOut ? 'Signing Out...' : 'Sign Out'),
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
  List<Map<String, dynamic>> followUps = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadFollowUps();
  }

  Future<void> loadFollowUps() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await ApiService.get('follow-ups');

      List<dynamic> records;

      if (response is List) {
        records = response;
      } else if (response is Map && response['data'] is List) {
        records = response['data'] as List;
      } else {
        throw Exception('Unexpected follow-up response format.');
      }

      if (!mounted) return;

      setState(() {
        followUps = records
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        errorMessage = error.toString().replaceFirst('Exception: ', '');
        isLoading = false;
      });
    }
  }

  String formatDate(dynamic value) {
    if (value == null) return 'Date not available';

    final date = DateTime.tryParse(value.toString());
    if (date == null) return value.toString();

    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String formatTime(dynamic value) {
    if (value == null) return 'Time not available';

    final date = DateTime.tryParse(value.toString());
    if (date == null) return value.toString();

    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  String referenceFor(Map<String, dynamic> item) {
    final id = item['id'];

    if (id == null) return 'Follow-Up';

    return 'FU-${id.toString().padLeft(3, '0')}';
  }

  String statusFor(Map<String, dynamic> item) {
    final status = item['status']?.toString() ?? 'Scheduled';

    if (status.isEmpty) return 'Scheduled';

    return status[0].toUpperCase() + status.substring(1).replaceAll('_', ' ');
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
                  subtitle: 'View your saved follow-up appointments.',
                ),
              ),
              IconButton(
                tooltip: 'Refresh',
                onPressed: isLoading ? null : loadFollowUps,
                icon: const Icon(Icons.refresh, color: violet),
              ),
            ],
          ),
          const SizedBox(height: 22),

          if (isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(35),
                child: CircularProgressIndicator(color: violet),
              ),
            )
          else if (errorMessage != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: panelDecoration,
              child: Column(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 35),
                  const SizedBox(height: 12),
                  const Text(
                    'Unable to load follow-ups',
                    style: TextStyle(color: dark, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: gray, fontSize: 12),
                  ),
                  const SizedBox(height: 14),
                  OutlinedButton.icon(
                    onPressed: loadFollowUps,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try Again'),
                  ),
                ],
              ),
            )
          else if (followUps.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: panelDecoration,
              child: const Column(
                children: [
                  Icon(Icons.calendar_month_outlined, color: violet, size: 42),
                  SizedBox(height: 12),
                  Text(
                    'No follow-up schedules yet.',
                    style: TextStyle(color: dark, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Your saved appointments will appear here.',
                    style: TextStyle(color: gray, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            ...followUps.map((item) {
              final scheduledAt = item['scheduled_at'];
              final date = formatDate(scheduledAt);
              final time = formatTime(scheduledAt);
              final status = statusFor(item);

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
                            referenceFor(item),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: dark,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '$date • $time',
                            style: const TextStyle(color: gray, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    StatusBadge(status: status),
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

// REMINDERS

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  List<Map<String, dynamic>> reminders = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadReminders();
  }

  Future<void> loadReminders() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await ApiService.get('reminders');

      if (response is! Map || response['data'] is! List) {
        throw Exception('Unexpected reminder response format.');
      }

      final records = response['data'] as List;

      if (!mounted) return;

      setState(() {
        reminders = records
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        errorMessage = error.toString().replaceFirst('Exception: ', '');
        isLoading = false;
      });
    }
  }

  String formatDate(dynamic value) {
    if (value == null) return 'Date not available';

    final date = DateTime.tryParse(value.toString());
    if (date == null) return value.toString();

    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String referenceFor(Map<String, dynamic> item) {
    final followUpId = item['follow_up_id'] ?? item['follow_up']?['id'];

    if (followUpId == null) return 'Reminder';

    return 'FU-${followUpId.toString().padLeft(3, '0')}';
  }

  String statusFor(Map<String, dynamic> item) {
    final status = item['status']?.toString() ?? 'Pending';

    if (status.isEmpty) return 'Pending';

    return status[0].toUpperCase() + status.substring(1).replaceAll('_', ' ');
  }

  String dateFor(Map<String, dynamic> item) {
    final reminderDate =
        item['reminder_at'] ??
        item['scheduled_at'] ??
        item['sent_at'] ??
        item['created_at'] ??
        item['follow_up']?['scheduled_at'];

    return formatDate(reminderDate);
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
                  title: 'Reminder History',
                  subtitle: 'Monitor the status of your follow-up reminders.',
                ),
              ),
              IconButton(
                tooltip: 'Refresh',
                onPressed: isLoading ? null : loadReminders,
                icon: const Icon(Icons.refresh, color: violet),
              ),
            ],
          ),
          const SizedBox(height: 22),

          if (isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(35),
                child: CircularProgressIndicator(color: violet),
              ),
            )
          else if (errorMessage != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: panelDecoration,
              child: Column(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 35),
                  const SizedBox(height: 12),
                  const Text(
                    'Unable to load reminders',
                    style: TextStyle(color: dark, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: gray, fontSize: 12),
                  ),
                  const SizedBox(height: 14),
                  OutlinedButton.icon(
                    onPressed: loadReminders,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try Again'),
                  ),
                ],
              ),
            )
          else if (reminders.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: panelDecoration,
              child: const Column(
                children: [
                  Icon(
                    Icons.notifications_none_rounded,
                    color: violet,
                    size: 42,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'No reminders available.',
                    style: TextStyle(color: dark, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Your reminder records will appear here.',
                    style: TextStyle(color: gray, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            ...reminders.map((item) {
              final reference = referenceFor(item);
              final date = dateFor(item);
              final status = statusFor(item);

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(18),
                decoration: panelDecoration,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        color: violetLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.notifications_none_rounded,
                        color: violet,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reference,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: dark,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            date,
                            style: const TextStyle(color: gray, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    StatusBadge(status: status),
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

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  List<Map<String, dynamic>> activities = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadActivities();
  }

  Future<void> loadActivities() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await ApiService.get('activity-logs');

      List<dynamic> records;

      if (response is List) {
        records = response;
      } else if (response is Map && response['data'] is List) {
        records = response['data'] as List;
      } else {
        throw Exception('Unexpected activity log response format.');
      }

      if (!mounted) return;

      setState(() {
        activities = records
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        errorMessage = error.toString().replaceFirst('Exception: ', '');
        isLoading = false;
      });
    }
  }

  String formatDate(dynamic value) {
    if (value == null) return 'Date not available';

    final date = DateTime.tryParse(value.toString());

    if (date == null) return value.toString();

    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '${months[date.month - 1]} ${date.day}, ${date.year} • $hour:$minute $period';
  }

  String activityTitle(Map<String, dynamic> item) {
    final event = item['event_type']?.toString() ?? 'Activity';

    return event
        .replaceAll('_', ' ')
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  IconData activityIcon(Map<String, dynamic> item) {
    final event = item['event_type']?.toString().toLowerCase() ?? '';

    if (event.contains('login')) return Icons.login;
    if (event.contains('logout')) return Icons.logout;
    if (event.contains('reminder')) return Icons.notifications_active_outlined;
    if (event.contains('follow')) return Icons.calendar_month_outlined;
    if (event.contains('complete')) return Icons.check_circle_outline;
    if (event.contains('cancel')) return Icons.cancel_outlined;
    if (event.contains('update')) return Icons.edit_outlined;

    return Icons.history_rounded;
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
                  title: 'Activity Logs',
                  subtitle: 'A record of recent account and system activities.',
                ),
              ),
              IconButton(
                tooltip: 'Refresh',
                onPressed: isLoading ? null : loadActivities,
                icon: const Icon(Icons.refresh, color: violet),
              ),
            ],
          ),
          const SizedBox(height: 22),

          if (isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(35),
                child: CircularProgressIndicator(color: violet),
              ),
            )
          else if (errorMessage != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: panelDecoration,
              child: Column(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 35),
                  const SizedBox(height: 12),
                  const Text(
                    'Unable to load activity logs',
                    style: TextStyle(color: dark, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: gray, fontSize: 12),
                  ),
                  const SizedBox(height: 14),
                  OutlinedButton.icon(
                    onPressed: loadActivities,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try Again'),
                  ),
                ],
              ),
            )
          else if (activities.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: panelDecoration,
              child: const Column(
                children: [
                  Icon(Icons.history_rounded, color: violet, size: 42),
                  SizedBox(height: 12),
                  Text(
                    'No activity records available.',
                    style: TextStyle(color: dark, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Your recorded activities will appear here.',
                    style: TextStyle(color: gray, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            ...activities.map((item) {
              final title = activityTitle(item);
              final description =
                  item['description']?.toString() ?? 'Activity recorded.';
              final time = formatDate(item['created_at']);

              return ActivityTile(
                icon: activityIcon(item),
                title: title,
                subtitle: description,
                time: time,
              );
            }),
        ],
      ),
    );
  }
}

// PROFILE

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> user;

  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final name = user['name']?.toString() ?? 'Patient Account';
    final email = user['email']?.toString() ?? 'Not available';
    final role = user['role']?.toString() ?? 'patient';

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
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 42,
                  backgroundColor: violetLight,
                  child: Icon(Icons.person, color: violet, size: 43),
                ),
                const SizedBox(height: 15),
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    color: dark,
                  ),
                ),
                const SizedBox(height: 5),
                Text(email, style: const TextStyle(color: gray)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ProfileField(label: 'Full Name', value: name),
          ProfileField(label: 'Email Address', value: email),
          ProfileField(label: 'Account Role', value: role),
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
