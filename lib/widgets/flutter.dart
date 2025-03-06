import 'package:permission_handler/permission_handler.dart';

// customRequestPermission(Permission.location);

void customRequestPermission(Permission permission) async {
  await Future.delayed(const Duration(seconds: 3));
  bool hasPermission = await checkAndRequestPermission(permission);
  if (hasPermission) {
    print("✅ permission granted!");
  } else {
    print("🚫 permission denied!");
  }
}

Future<bool> checkAndRequestPermission(Permission permission) async {
  var status = await permission.status;

  if (status.isGranted) {
    return true;
  } else if (status.isDenied) {
    status = await permission.request();
    return status.isGranted;
  } else if (status.isPermanentlyDenied) {
    openAppSettings();
    return false;
  }
  return false;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//
