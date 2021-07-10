import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Libmot_Mobile/repository/theme_provider.dart';

class ChangeModeButton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
   final  themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
      value: themeProvider.isDarkMode ,
      onChanged: (value){
        final provider = Provider.of<ThemeProvider>(context,listen:false );
        provider.toggleTheme(value);
      },
      
    );
  }
}