import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/screens/auth/login.dart';
import 'package:flutter_app/screens/auth/register.dart';
import 'package:flutter_app/screens/categories/categories_list.dart';
import 'package:flutter_app/providers/transaction_provider.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/providers/category_provider.dart'; 
void main() {
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<CategoryProvider>(
                    create: (context) => CategoryProvider(authProvider)),
                ChangeNotifierProvider<TransactionProvider>(
                    create: (context) => TransactionProvider(authProvider)),
              ],
              child: MaterialApp(
                title: 'Welcome to Flutter', routes: {
                  '/': (context) {
                    final authProvider = Provider.of<AuthProvider>(context);
                    // return authProvider.isAuthenticated ? CategoriesList() : Login();
                    return authProvider.isAuthenticated ? Home() : Login();
                  },
                  '/login': (context) => Login(),
                  '/register': (context) => Register(),
                  '/home': (context) => Home(),
                  '/categories': (context) => CategoriesList(),
              }));
        }));  }
}