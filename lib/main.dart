import 'package:egy_us_tv_admin/controller/provider/login_provider.dart';
import 'package:egy_us_tv_admin/controller/provider/playlist_provider.dart';
import 'package:egy_us_tv_admin/view/splash.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => PlaylistProvider())
      ],

      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(textTheme).copyWith(
                // bodyMedium: GoogleFonts.poppins(textStyle: textTheme.bodyMedium),
                ),
          ),
          debugShowCheckedModeBanner: false,
          home: SplashPage(),
        );
      }),
    );
  }
}



// Model ()
// View (UI)
// Controller (Business Logic)


          // ChangeNotifierProvider(create: (context) => AuthController()),
