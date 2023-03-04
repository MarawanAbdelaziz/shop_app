import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeData(key: "token").then((value) {
    if (value) {
      navigateAndFinish(context, LoginScreen());
    }
  });
}
