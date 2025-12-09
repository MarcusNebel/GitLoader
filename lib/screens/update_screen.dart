import 'package:flutter/material.dart';
import 'package:gitloader/gen_l10n/app_localizations.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.update),
        centerTitle: true,
      ),
      
      body: Center(
        
      ),
    );
  }
}
