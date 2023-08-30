import 'package:flutter/material.dart';
import 'package:hotshot/constants/colors.dart';

import '../constants/loader.dart';
import '../model/orderInfo.dart';
import '../services/orderServ.dart';
import '../widgets/acceptedOrderCard.dart';
import '../widgets/my_shopkeeper_drawer.dart';
import '../widgets/sideDrawerShopkeeper.dart';

class AcceptedOrdersScreen extends StatefulWidget {
  const AcceptedOrdersScreen({super.key});

  @override
  State<AcceptedOrdersScreen> createState() => _AcceptedOrdersScreenState();
}

class _AcceptedOrdersScreenState extends State<AcceptedOrdersScreen>
    with SingleTickerProviderStateMixin {
  List<Order>? order;
  final OrderServ restServ = OrderServ();
  fetchacceptedorder() async {
    order = await restServ.fetchAcceptedOrders(context);
    setState(() {});
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late TabController _tabController;
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchacceptedorder();
    _tabController = TabController(vsync: this, length: 3);
  }

  var status = "Ready?";
  bool _hasBeenPressed = false;
  var items = List<String>.generate(100, (i) => 'Item $i');
  var itemsList = List<List<String>>.generate(
      100, (i) => ['Item $i', 'Item ${(i + 1)}', 'Item ${(i + 2)}']);
  @override
  Widget build(BuildContext context) {
    fetchacceptedorder();
    return order == null
        ? Loader()
        : Scaffold(
            appBar: AppBar(
              actions: const [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/droppedImage.jpg'),
                  backgroundColor: greenColor,
                ),
              ],
              title: const Text(
                'Accepted Orders',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  // color: Colors.black,
                ),
              ),
              centerTitle: true,
              elevation: 5,
            ),
            drawer: MyShopkeeperDrawer(),
            body: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: order!.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemBuilder: (context, index) {
                return AcceptedOrderCard(data: order![index]);
                // return Container(
                //     height: 114,
                //     decoration: BoxDecoration(
                //         // color: Colors.green[100],
                //         border: Border.all(
                //           color: blackColor,
                //         ),
                //         borderRadius: const BorderRadius.all(Radius.circular(20))),
                //     child: Column(
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                //           child: Align(
                //             alignment: Alignment.topCenter,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Text(
                //                   "Order ID: ${items[index]}",
                //                   style: const TextStyle(
                //                     fontSize: 20,
                //                   ),
                //                 ),
                //                 const Text(
                //                   "Time",
                //                   style: TextStyle(
                //                     fontSize: 20,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //         Row(children: [
                //           Expanded(
                //             child: Align(
                //                 alignment: Alignment.bottomLeft,
                //                 child: Text(
                //                   'Order Items: ${itemsList[index]}',
                //                   style: const TextStyle(fontSize: 20),
                //                   maxLines: 1,
                //                   softWrap: false,
                //                   overflow: TextOverflow.ellipsis,
                //                 )),
                //           ),
                //         ]),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           // alignment: Alignment.bottomRight,
                //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             //   OutlinedButton(
                //             //       style: OutlinedButton.styleFrom(
                //             //         backgroundColor: _hasBeenPressed
                //             //             ? Colors.green.shade100
                //             //             : Colors.grey,
                //             //         //foregroundColor: _hasBeenPressed ? Colors.green : Colors.grey,
                //             //       ),
                //             //       onPressed: () => {
                //             //             setState(() {
                //             //               _hasBeenPressed = !_hasBeenPressed;
                //             //               _hasBeenPressed
                //             //                   ? (status = 'Order is Ready!')
                //             //                   : status = 'Ready?';
                //             //             })
                //             //           },
                //             //       child: Text(status)),
                //             Builder(
                //               builder: ((context) {
                //                 return TextButton(
                //                   onPressed: () {
                //                     showModalBottomSheet(
                //                         // backgroundColor: Colors.green.shade100,
                //                         context: context,
                //                         builder: (context) {
                //                           return Wrap(
                //                             children: [
                //                               ListTile(
                //                                 leading: const Icon(
                //                                     Icons.pending_actions_sharp),
                //                                 title: Text(
                //                                   'Order is not yet delivered',
                //                                   style: TextStyle(
                //                                       color: Colors.red.shade300),
                //                                 ),
                //                               ),
                //                               ListTile(
                //                                 leading: const Icon(Icons.note),
                //                                 title: Text(
                //                                     'Order ID: ${items[index]}'),
                //                               ),
                //                               // ignore: prefer_const_constructors
                //                               ListTile(
                //                                 leading:
                //                                     const Icon(Icons.lock_clock),
                //                                 // ignore: prefer_const_constructors
                //                                 title: Text('Time: 9:05 PM'),
                //                               ),
                //                               const ListTile(
                //                                 leading: Icon(Icons.money),
                //                                 title: Text(
                //                                     'Total Price: Rupees 439/-'),
                //                               ),
                //                               ListTile(
                //                                 isThreeLine: true,
                //                                 leading:
                //                                     const Icon(Icons.list_sharp),
                //                                 title: const Text('Order Items: '),
                //                                 subtitle:
                //                                     Text('${itemsList[index]}'),
                //                               ),
                //                             ],
                //                           );
                //                         });
                //                   },
                //                   child: const Text('See More'),
                //                   // style: TextButton.styleFrom(
                //                   //   maximumSize: const Size(10, 10),
                //                   // ),
                //                 );
                //               }),
                //             ),
                //           ],
                //         ),
                //         // TextButton(
                //         //     onPressed: () {}, child: Text('See More'))),
                //       ],
                //     )
                //     //Text("\tOrder ID: ${items[index]}"),
                //     );
              },
            ));
  }
}
