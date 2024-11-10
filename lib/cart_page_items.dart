import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app_demo/recipe_data/item_with_count.dart';
import 'package:food_app_demo/view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'common_widgets/custom_network_cached_widget.dart';

class CartPage extends StatefulHookConsumerWidget {
  const CartPage({super.key});
  @override
  CartPageState createState() => CartPageState();
}
class CartPageState extends ConsumerState<CartPage> {
  // num totalAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> vnCheck = useState<bool>(false);
    // final List<ItemWithCount> allItemsList = ref.read(mListItems.notifier).state ;
    final List<ItemWithCount> allItemsList = ref.read(foodDeliveryViewModel).pListItems;
    // allItemsList.forEach((e)=>totalAmount = totalAmount + (e.foodItems.price * e.count));
    return  Container(
        padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 14),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
        ),
        height: MediaQuery.of(context).size.height*0.9,
        child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            onPressed: (){
             if(ref.read(foodDeliveryViewModel).pTotalAmount.toStringAsFixed(2) =="0.00"){
               Navigator.of(context).pop();
             }
            },
            label: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ref.read(foodDeliveryViewModel).pTotalAmount.toStringAsFixed(2) =="0.00"?const Text(
                'Add Items',
                style: TextStyle(color: Colors.white),
              ):Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pay',
                    style: TextStyle(color: Colors.white),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.white, size: 18),
                      const SizedBox(width: 4),
                      const Text(
                        '24 min',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        '• \$${ref.read(foodDeliveryViewModel).pTotalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(ref.read(foodDeliveryViewModel).pTotalAmount.toStringAsFixed(2) !="0.00")...[
                const SizedBox(height: 50,),
              const Text('We will deliver in 24 minutes to the address:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              const SizedBox(height: 20,),
              const Text("100a Ealing Rd",style: TextStyle(fontSize: 12),),
              const SizedBox(height: 20,),
              ListView.builder(
                  itemCount: allItemsList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index ){
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex:1,
                          child: CircularCachedNetwork(
                            radius: 30,
                            imageUrl: allItemsList[index].foodItems.imageUrl,
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(allItemsList[index].foodItems.recipeName,style: const TextStyle(fontSize: 14),),
                              Row(
                                children: [
                                  IconButton(
                                      style: IconButton.styleFrom(
                                        backgroundColor: Colors.grey[200],
                                        fixedSize: const Size(15, 15),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
                                        ),
                                      ),
                                  onPressed: (){
                                    // ref.read(mListItems.state).state[index].count --;
                                    ref.read(foodDeliveryViewModel).itemDecrement(index);
                                    vnCheck.value = !vnCheck.value;
                                  }, icon: SvgPicture.asset(
                                    'assets/images/minus.svg',
                                    width: 12,
                                    height: 12,
                                  ),
                                  ),
                                  Text('${allItemsList[index].count}',style: const TextStyle(fontSize: 16),),
                                  IconButton(
                                      style: IconButton.styleFrom(
                                        backgroundColor: Colors.grey[200],
                                          // maximumSize:Size(10, 10),
                                        fixedSize: const Size(10, 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
                                        ),
                                      ),
                                      onPressed: (){
                                    // ref.read(mListItems.state).state[index].count ++;
                                    ref.read(foodDeliveryViewModel).itemIncrement(index);
                                    vnCheck.value = !vnCheck.value;
                                  }, icon: const Icon(Icons.add))
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "\$${allItemsList[index].foodItems.price * allItemsList[index].count} ",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Delivery',style: TextStyle(fontSize: 14),),
                        Text('Free Delivery From \$30',style: TextStyle(fontSize: 12,color: Colors.grey[500]),),
                      ],
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Text(
                      "\$0.00 ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),

                ],
              )
              ]else...[
                const SizedBox(height: 50,),
                const Align(
                  alignment: Alignment.center,
                    child: Text('Your Cart is Empty',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),)),
              ]
            ],
          ),
        ),
    );
  }
}
