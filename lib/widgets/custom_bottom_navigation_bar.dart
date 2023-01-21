import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      color: Colors.white,
      padding: const EdgeInsets.only(top: 20.0),
      child: Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.white,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.purple,
            bottomAppBarColor: Colors.purple,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: const TextStyle(color: Colors.grey))),
        // sets the inactive color of the `BottomNavigationBar`
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: 0,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'first',
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'first',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'second',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity),
                label: 'third',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz),
                label: 'fourth',
              ),
            ]),
      ),
    );
  }
}
