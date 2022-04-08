import 'package:facelift_constructions/home/home_page.dart';
import 'package:facelift_constructions/log_in/phone_auth_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'models/models.dart';
import 'services/auth_service.dart';
import '../constants.dart';
import 'services/databases.dart';
import 'log_in/welcome.dart';
import 'premium/new_premium_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthClass authClass = AuthClass();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  checkLogin() async {
    // authClass.signOut(context: context);
    String? tokne = await authClass.getPhone();
    if (tokne != null) {
      setState(() {
        userLogedIn = true;
        number = tokne;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userLogedIn != true) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Facelift Constructions',
        home: WelcomeScreen(),
      );
    } else {
      return StreamBuilder<UserPremiumBool>(
        stream: DatabaseService().userPremiumBoolStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && userLogedIn == true) {
            premiumUser = snapshot.data!.premium;
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Facelift Constructions',
              home: HomePage(),
            );
          } else {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          }
        },
      );
    }
  }
}

class HomeNotLoggedInScreen extends StatefulWidget {
  const HomeNotLoggedInScreen({Key? key}) : super(key: key);

  @override
  State<HomeNotLoggedInScreen> createState() => _HomeNotLoggedInScreenState();
}

class _HomeNotLoggedInScreenState extends State<HomeNotLoggedInScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: const HomeScreen(logedIn: false),
      extendBody: true,
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 20, horizontal: size.width * 0.225),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              height: 60,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.black,
                // selectedFontSize: 1,
                // unselectedFontSize: 1,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: pinkColor,
                currentIndex: iindex,
                onTap: (val) {
                  setState(() {
                    val != 1
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PhoneAuthScreen()))
                        : iindex = val;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.whatshot),
                    label: "",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: screens[iindex],
      extendBody: true,
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 20, horizontal: size.width * 0.225),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.black,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: pinkColor,
                currentIndex: iindex,
                onTap: (val) {
                  setState(() {
                    val == 2
                        ? premiumUser
                            ? iindex = val
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NewPrimiumUserScreen()))
                        : iindex = val;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.whatshot),
                    label: "",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
