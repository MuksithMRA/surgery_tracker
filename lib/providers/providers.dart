import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:surgery_tracker/providers/user_provider.dart';

import 'auth_provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<AuthProvider>(
    create: (context) => AuthProvider(),
  ),
  ChangeNotifierProvider<UserProvider>(
    create: (context) => UserProvider(),
  ),
];
