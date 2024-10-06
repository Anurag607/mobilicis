import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/Ionicons.dart';
import 'package:mobilicis/main.dart';
import 'package:mobilicis/pages/notification_page.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  String location = "India";
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: HexColor("#2d2e42"),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Ionicons.menu_sharp,
                  color: HexColor("#f6f8fe").withOpacity(1),
                  size: 40,
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 10),
              Image.asset(
                "assets/images/logo.png",
                width: 70,
                color: Colors.white,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Row(
                children: [
                  Text(
                    location,
                    style: GoogleFonts.comfortaa(
                      textStyle: TextStyle(
                        color: Colors.white.withOpacity(1),
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Ionicons.location,
                      color: HexColor("#f6f8fe").withOpacity(1),
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  Ionicons.notifications,
                  color: HexColor("#f6f8fe").withOpacity(1),
                  size: 30,
                ),
                onPressed: () {
                  navigatorKey.currentState?.pushNamed(
                    NotificationPage.route,
                    arguments: null,
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
