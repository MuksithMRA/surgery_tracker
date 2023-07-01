import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'auth_provider.dart';
import 'surgery_provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<AuthProvider>(
    create: (context) => AuthProvider(),
  ),
  ChangeNotifierProvider<SurgeryProvider>(
    create: (context) => SurgeryProvider(),
  ),
];
