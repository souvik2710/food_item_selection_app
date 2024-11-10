


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app_demo/recipe_data/item_with_count.dart';
import 'package:food_app_demo/recipe_data/model_food_items.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// final StateProvider<List<ItemWithCount>> mListItems= StateProvider<List<ItemWithCount>>((ref) => []);
// final StateProvider<bool> mCheck= StateProvider<bool>((ref) => false);
final foodDeliveryViewModel = ChangeNotifierProvider<FoodDeliveryDemoViewModel>((ref) => FoodDeliveryDemoViewModel(ref: ref));
class FoodDeliveryDemoViewModel extends ChangeNotifier {
  Ref ref;
  FoodDeliveryDemoViewModel({required this.ref});
  List<FoodItems> foodItems = [];
  List<ItemWithCount> pListItems =[];
  num pTotalAmount =0.0;

  void calculateTotalAmount(){
    pTotalAmount =0.0;
    for (var e in pListItems) {
      pTotalAmount =  pTotalAmount + e.foodItems.price * e.count;
    }
    notifyListeners();
  }
  void addItem(ItemWithCount itemWithCount){
    final cIndex = pListItems.indexWhere((e) {
      return e.foodItems.id == itemWithCount.foodItems.id;
    });
    if(itemWithCount.count>0) {
      if (cIndex == -1) {
        //If item not found in list adding that item
        pListItems.add(itemWithCount);
      } else {
        //if item already exists them just incrementing the count
        pListItems[cIndex].count = itemWithCount.count;
      }
      notifyListeners();
    }else if(itemWithCount.count ==0){
      pListItems.removeAt(cIndex);
      notifyListeners();
    }
  }
  void itemIncrement(int indexPass){
    pListItems[indexPass].count ++;
    calculateTotalAmount();
    notifyListeners();
  }
  void itemDecrement(int indexPass){
    if(pListItems[indexPass].count>0) {
      pListItems[indexPass].count --;
      calculateTotalAmount();
      //From 1 change count to zero after decrement, then removing it any item can not have zero count
      if(pListItems[indexPass].count==0) {
        pListItems.removeAt(indexPass);
      }
      notifyListeners();
    }
  }
  // Function to load food items from the JSON file
  Future<void> loadFoodItems() async {
    String jsonString = await rootBundle.loadString('assets/json/food_list.json');
    foodItems = foodItemsFromJson(jsonString);
    notifyListeners(); // Notify listeners to rebuild any listening widgets
  }
}

// ref.read(foodDeliveryViewModel)