import 'package:get/get.dart';
import '../../../presentation/screens/navigation_menu/favorites/favorites_screen.dart';
import '../../../presentation/screens/navigation_menu/home/home_screen.dart';
import '../../../presentation/screens/navigation_menu/settings/setting_screen.dart';
import '../../../presentation/screens/navigation_menu/shop/shop_screen.dart';

class ScreenNavController extends GetxController {
  final RxInt selectedScreenIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const ShopScreen(),
    const FavoritesScreen(),
    const SettingScreen(),
  ];
}