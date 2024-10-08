import 'package:flutter/material.dart';
import 'package:ui/util/user_provider.dart';
import 'package:ui/views/app.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

void main() {
  Logger.root.level = Level.ALL; 
  Logger.root.onRecord.listen((record) {
    print('${record.loggerName} : [${record.level.name}] (${record.sequenceNumber}): ${record.message}');
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: Wealingo(),
    ),
  );
}

