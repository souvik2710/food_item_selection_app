import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:food_app_demo/single_food_item.dart';
import 'package:food_app_demo/view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'common_widgets/custom_network_cached_widget.dart';


class VerticalListFoodItems extends StatefulHookConsumerWidget {
  const VerticalListFoodItems({super.key});
  @override
  VerticalListFoodItemsState createState() => VerticalListFoodItemsState();
}

class VerticalListFoodItemsState extends ConsumerState<VerticalListFoodItems> {
  // late Future<List<FoodItems>> foodItems;
  var mLabelStyle = TextStyle(fontSize: 12,fontWeight: FontWeight.w100,color: Colors.grey[500]);


  @override
  void initState() {
    super.initState();
    // foodItems = loadFoodItems();
  }


  @override
  Widget build(BuildContext context) {
    // Call loadFoodItems once when the widget is built
    useEffect(() {
      ref.read(foodDeliveryViewModel).loadFoodItems();
      return null; // No cleanup function needed
    }, []);

    // Watch the food items list from the ViewModel
    final foodList = ref.watch(foodDeliveryViewModel).foodItems;
    return foodList.isEmpty
        ? const Center(child: CircularProgressIndicator()): ListView.separated(
            physics : const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: foodList.length,
            itemBuilder: (context, index) {
              final recipe = foodList[index];
              return InkWell(
                onTap: (){
                  showModalBottomSheet(context: context,
                      isScrollControlled:true,
                      /*      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,*/
                      builder: (BuildContext c){
                        return SingleFoodItemDetails(foodItems: recipe);
                      });
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  // width: MediaQuery.of(context).size.width * 0.9,
                  // height: MediaQuery.of(context).size.height * 0.3,
                  decoration: const BoxDecoration(
                    // color: Colors.red[100],
                    color: Colors.white
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircularCachedNetwork(
                        radius: 70,
                        imageUrl: recipe.imageUrl,
                      ),
                      // SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipe.recipeName,
                            style: const TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Text(
                                  "\$${recipe.price.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Text("${recipe.nutrition.kcal} kcal",style: mLabelStyle,),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }, separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10,);
          },
          );
        }
}
