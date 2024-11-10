

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:food_app_demo/recipe_data/item_with_count.dart';
import 'package:food_app_demo/recipe_data/model_food_items.dart';
import 'package:food_app_demo/view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'common_widgets/custom_network_cached_widget.dart';

class SingleFoodItemDetails extends StatefulHookConsumerWidget {
  final FoodItems foodItems;
  const SingleFoodItemDetails({super.key, required this.foodItems});

  @override
  SingleFoodItemDetailsState createState() => SingleFoodItemDetailsState();
}
class SingleFoodItemDetailsState extends ConsumerState<SingleFoodItemDetails> {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> vnCheck = useState<bool>(false);
    // final List<ItemWithCount> allItemsList = ref.read(mListItems.notifier).state ;
    final List<ItemWithCount> allItemsList = ref.read(foodDeliveryViewModel).pListItems;
    final mainIndex =  allItemsList.indexWhere((e)=>e.foodItems.id == widget.foodItems.id);
    final ValueNotifier<int> countFoodItem = useState<int>(mainIndex==-1?0:allItemsList[mainIndex].count);
    var mValueStyle = const TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.black);
    var mLabelStyle = TextStyle(fontSize: 12,fontWeight: FontWeight.w100,color: Colors.grey[500]);
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 7),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
        ),
        height: MediaQuery.of(context).size.height*0.9,
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomSheet: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){
                      countFoodItem.value--;
                    }, icon: const Icon(Icons.minimize)),
                    Text('${countFoodItem.value}'),
                    IconButton(onPressed: (){
                      countFoodItem.value++;
                    }, icon: const Icon(Icons.add))
                  ],
                ),
              ),

              ElevatedButton(onPressed: (){
                // ref.read(mListItems.notifier).state.add( ItemWithCount(foodItems: widget.foodItems, count: countFoodItem.value));
                // ref.read(mListItems.notifier).state.forEach((e)=>print("ItemName - ${e.foodItems.recipeName} and count ${e.count}"));
                ref.read(foodDeliveryViewModel).addItem(ItemWithCount(foodItems: widget.foodItems, count: countFoodItem.value));
                ref.read(foodDeliveryViewModel).calculateTotalAmount();
                debugPrint("TOTAL AMOUNT is ---> ${ref.read(foodDeliveryViewModel).pTotalAmount}");
                Navigator.of(context).pop();

              },style: ElevatedButton.styleFrom(
                backgroundColor:Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                // minimumSize: Size(MediaQuery.of(context).size.width,50),
                // minimumSize:  Size(widget.width! == null?299:widget.width!,widget.height! == null?47:widget.height!),
              ), child: Text('${mainIndex==-1?"Add":"Update"} to Cart ${(widget.foodItems.price * countFoodItem.value).toStringAsFixed(2) }',

              ),)
            ],
          ),
          body: Column(
            children: [
              const SizedBox(height: 40,),
              CircularCachedNetwork(
                radius: 100,
                imageUrl: widget.foodItems.imageUrl,
              ),
              const SizedBox(height: 40,),
              Align(
                alignment: Alignment.centerLeft,
                  child: Text(widget.foodItems.recipeName,style: const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500),)),
              const SizedBox(height: 10,),
              Text(widget.foodItems.description,style: const TextStyle(fontSize: 14,color: Colors.grey),),
              const SizedBox(height: 10,),
              Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[100]!, width: 2),  // Add grey border
                  borderRadius: BorderRadius.circular(8.0),


                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${widget.foodItems.nutrition.kcal}",style: mValueStyle,),
                        Text("${widget.foodItems.nutrition.grams}",style: mValueStyle,),
                        Text("${widget.foodItems.nutrition.protein}",style: mValueStyle,),
                        Text("${widget.foodItems.nutrition.fats}",style: mValueStyle,),
                        Text("${widget.foodItems.nutrition.carbs}",style: mValueStyle,)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("kcal",style: mLabelStyle,),
                        Text("grams",style: mLabelStyle,),
                        Text("proteins",style: mLabelStyle,),
                        Text("fats",style: mLabelStyle,),
                        Text("carbs",style: mLabelStyle,)
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Add in poke'),
                  Icon(Icons.keyboard_arrow_right)
                ],
              )
            ],
          ),
        ),
      );
  }
}



