import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hotshot/model/otherInfo.dart';
import 'package:hotshot/screens/describe.dart';
class OtherCard extends StatefulWidget {
  final OtherInfo data;
  const OtherCard({Key? key, required this.data}) : super(key: key);

  @override
  State<OtherCard> createState() => _OtherCardState();
}

class _OtherCardState extends State<OtherCard> {
  @override
  Widget build(BuildContext context) {
    var fav=false;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    describe(data: widget.data)));
      },
      // Card Wrapper
      child:
      // Stack(
      //   children: [
      Container(
        width: 220,
        height: 180,
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(widget.data.pic),
            colorFilter: (widget.data.status=='on') ? null:new ColorFilter.mode(Colors.grey, BlendMode.saturation),
            fit: BoxFit.cover,
          ),
        ),
        // Recipe Card Info
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Container(
              height: 60,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black.withOpacity(0.26),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe Title
                  Text(
                    widget.data.shopName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 14, height: 150 / 100, fontWeight: FontWeight.w600, fontFamily: 'inter'),
                  ),
                  // Recipe Calories and Time
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // SvgPicture.asset(
                        //   'assets/icons/fire-filled.svg',
                        //   color: Colors.white,
                        //   width: 12,
                        //   height: 12,
                        // ),
                        Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(Icons.location_pin, size: 12, color: Colors.white),
                              Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Text(
                                  widget.data.category,
                                  style: TextStyle(color: Colors.white, fontSize: 10),
                                ),
                              ),]
                        ),
                        //SizedBox(width: 10),


                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      //     Padding(
      //       padding: const EdgeInsets.symmetric(
      //           vertical: 8.0, horizontal: 10.0),
      //       child: Align(
      //         alignment: Alignment.topRight,
      //         child: IconButton(
      //           onPressed: () {
      //             setState(() {
      //               fav=true;
      //             });
      //           },
      //           icon:  Icon(
      //             Icons.favorite_outline_rounded,
      //             color: (fav==true)? Colors.red:Color(0xffE0E0E0),
      //           ),
      //         ),
      //       ),
      //     ),
      // ]
      // ),
    );
  }
}
