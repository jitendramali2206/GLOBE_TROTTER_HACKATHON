import 'package:flutter/material.dart';

void main() {
  runApp(const GlobeTrotterApp());
}

class GlobeTrotterApp extends StatelessWidget {
  const GlobeTrotterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GlobeTrotter',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

// =============================
// 1. LOGIN / SIGNUP SCREEN
// =============================

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSignup = false;
  bool obscurePassword = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  void loginOrSignup() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all required fields"),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardScreen(
          userName: isSignup && nameController.text.isNotEmpty
              ? nameController.text
              : "Traveler",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                const Icon(
                  Icons.public,
                  size: 80,
                  color: Colors.deepPurple,
                ),

                const SizedBox(height: 15),

                const Text(
                  "GlobeTrotter",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  isSignup
                      ? "Create your account and start exploring!"
                      : "Plan your next journey with ease!",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 35),

                // Name field only for Signup
                if (isSignup)
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Full Name",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                  ),

                if (isSignup)
                  const SizedBox(height: 15),

                // Email
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                // Password
                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Login / Signup button
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: loginOrSignup,
                    child: Text(
                      isSignup ? "SIGN UP" : "LOGIN",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                TextButton(
                  onPressed: () {
                    setState(() {
                      isSignup = !isSignup;
                    });
                  },
                  child: Text(
                    isSignup
                        ? "Already have an account? Login"
                        : "Don't have an account? Sign Up",
                  ),
                ),

                if (!isSignup)
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Forgot Password feature coming soon!",
                          ),
                        ),
                      );
                    },
                    child: const Text("Forgot Password?"),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =============================
// 2. DASHBOARD / HOME SCREEN
// =============================

class DashboardScreen extends StatelessWidget {
  final String userName;

  const DashboardScreen({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GlobeTrotter"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Create Trip screen will open here"),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Plan New Trip"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Hello, $userName 👋",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Where would you like to travel next?",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            // Search
            TextField(
              decoration: InputDecoration(
                hintText: "Search destinations...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Your Upcoming Trips",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // Upcoming trip card
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      child: Icon(
                        Icons.flight_takeoff,
                        size: 30,
                      ),
                    ),

                    const SizedBox(width: 15),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ahmedabad → Mumbai",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text("15 Sep 2026 - 18 Sep 2026"),
                          SizedBox(height: 5),
                          Text("Budget: ₹10,000"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Popular Destinations",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 130,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  DestinationCard(
                    icon: Icons.beach_access,
                    name: "Goa",
                  ),
                  DestinationCard(
                    icon: Icons.landscape,
                    name: "Manali",
                  ),
                  DestinationCard(
                    icon: Icons.temple_hindu,
                    name: "Jaipur",
                  ),
                  DestinationCard(
                    icon: Icons.location_city,
                    name: "Mumbai",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (index) {},
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.luggage_outlined),
            label: "Trips",
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            label: "Explore",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

// =============================
// DESTINATION CARD
// =============================

class DestinationCard extends StatelessWidget {
  final IconData icon;
  final String name;

  const DestinationCard({
    super.key,
    required this.icon,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
