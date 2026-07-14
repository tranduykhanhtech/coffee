
import 'package:coffee/features/menu/repository/coffee_menu_repository.dart';
import 'package:get/get.dart';

import '../controllers/coffee_menu_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    // 1. Nạp Repository vào bộ nhớ trước
    Get.lazyPut<CoffeeMenuRepository>( () => CoffeeMenuRepository());

    // 2. Nạp Controller và truyền (inject) cái Repository vừa tạo ở trên vào
    Get.lazyPut<CoffeeMenuController>(() => CoffeeMenuController(repository: Get.find()));
  }

}
