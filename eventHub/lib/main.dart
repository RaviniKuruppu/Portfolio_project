import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/tabs.dart';
import 'widgets/user_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Colors.blue,
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: const App(),
      ),
    ),
  );
  //runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'EventHub',
      theme: theme,
      home: FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false).loadUserIdAndRole(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                if (userProvider.userId != null) {
                  return const TabsScreen();
                } else {
                  return const LoginScreen();
                }
              },
            );
          }
        },
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:device_preview/device_preview.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'screens/login_screen.dart';
// import 'screens/tabs.dart';

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// final theme = ThemeData(
//   useMaterial3: true,
//   colorScheme: ColorScheme.fromSeed(
//     brightness: Brightness.dark,
//     //seedColor: const Color.fromARGB(255, 131, 57, 0),
//     seedColor: Colors.blue
//   ),
//   textTheme: GoogleFonts.latoTextTheme(),
// );

// void main() {
//   runApp(
//     DevicePreview(
//       enabled: true,
//       tools: const [
//         ...DevicePreview.defaultTools,
//         //const CustomPlugin(),
//       ],
//       builder: (context) => const App(),
//     ),
//   );
//   //runApp(const App());
// }

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       navigatorKey: navigatorKey,
//       title: 'EventHub',
//       theme: theme,
//       // theme: ThemeData(
        
//       //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
//       //   useMaterial3: true,
//       // ),
//       //home: const TabsScreen(),
//       home: const LoginScreen(),
      
      
//     );
//   }
// }