import 'package:flutter/material.dart';
import 'package:hotshot/screens/PendingOrders.dart';
import 'package:hotshot/screens/feedback.dart';
// import 'package:navigation_drawer_example/page/favourites_page.dart';
// import 'package:navigation_drawer_example/page/people_page.dart';
// import 'package:navigation_drawer_example/page/user_page.dart';
import 'package:hotshot/screens/ordHistory.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final name = 'Sarah Abs';
    final email = 'sarah@abs.com';
    final urlImage =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

    return Drawer(
      child: Material(
        color: const Color(0xff307A59),
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () => {}
              //     Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => UserPage(
              //     name: 'Sarah Abs',
              //     urlImage: urlImage,
              //   ),
              // )),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Order History',
                    icon: Icons.history_outlined,
                    onClicked: () => {
                    Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context) => OrdHistory())
                    )
                    },
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Pending Orders',
                    icon: Icons.pending_actions,
                    onClicked: () =>{
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (BuildContext context) => PendHistory())
                      )
                    },
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Share',
                    icon: Icons.share,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Rate/Feedback',
                    icon: Icons.star_rate_outlined,
                    onClicked: () =>  {
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (BuildContext context) => feedback())
                      )
                    },
                  ),

                  const SizedBox(height: 24),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      child: Text("Logout", style: TextStyle(fontSize: 20),),
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    )  ,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              // Spacer(),
              // CircleAvatar(
              //   radius: 24,
              //   backgroundColor: Color.fromRGBO(30, 60, 168, 1),
              //   child: Icon(Icons.add_comment_outlined, color: Colors.white),
              // )
            ],
          ),
        ),
      );

  // Widget buildSearchField() {
  //   final color = Colors.white;
  //
  //   return TextField(
  //     style: TextStyle(color: color),
  //     decoration: InputDecoration(
  //       contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  //       hintText: 'Search',
  //       hintStyle: TextStyle(color: color),
  //       prefixIcon: Icon(Icons.search, color: color),
  //       filled: true,
  //       fillColor: Colors.white12,
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(5),
  //         borderSide: BorderSide(color: color.withOpacity(0.7)),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(5),
  //         borderSide: BorderSide(color: color.withOpacity(0.7)),
  //       ),
  //     ),
  //   );
  // }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => PeoplePage(),
        // ));
        break;
      case 1:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => FavouritesPage(),
        // ));
        break;
    }
  }
}