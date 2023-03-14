import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates {}

class ShopChangeBottomNavStates extends ShopStates {}

// *  HomeData  *
class ShopLoadingHomeDataStates extends ShopStates {}

class ShopSuccessHomeDataStates extends ShopStates {}

class ShopErrorHomeDataStates extends ShopStates {}

// *  Categories  *

class ShopSuccessCategoriesStates extends ShopStates {}

class ShopErrorCategoriesStates extends ShopStates {}

// *  Favorites  *

class ShopChangeFavoritesStates extends ShopStates {}

class ShopSuccessChangeFavoritesStates extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesStates(this.model);
}

class ShopErrorChangeFavoritesStates extends ShopStates {}

// *  Get Favorites  *

class ShopLoadingGetFavoritesStates extends ShopStates {}

class ShopSuccessGetFavoritesStates extends ShopStates {}

class ShopErrorGetFavoritesStates extends ShopStates {}

// *  Get User  *

class ShopLoadingUserDataStates extends ShopStates {}

class ShopSuccessUserDataStates extends ShopStates {
  final LoginModel loginModel;

  ShopSuccessUserDataStates(this.loginModel);
}

class ShopErrorUserDataStates extends ShopStates {}

// *  Update User  *

class ShopLoadingUpdateUserStates extends ShopStates {}

class ShopSuccessUpdateUserStates extends ShopStates {
  final LoginModel loginModel;

  ShopSuccessUpdateUserStates(this.loginModel);
}

class ShopErrorUpdateUserStates extends ShopStates {}
