import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medic/providers/education_provider.dart';
import 'package:medic/providers/login_provider.dart';
import 'package:medic/providers/medical_staff_provider.dart';
import 'package:medic/providers/order_provider.dart';
import 'package:medic/providers/products_provider.dart';
import 'package:medic/providers/register_provider.dart';
import 'package:provider/provider.dart';
import '/screens/login_screen.dart';
import '/theme/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => RegisterProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => LoginProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => EducationProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ProductsProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => OrderProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => MedicalStaffProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'E-Medic',
          theme: lightTheme(context),
          home: LoginScreen(),
        ),
      ),
    );
  }
}
