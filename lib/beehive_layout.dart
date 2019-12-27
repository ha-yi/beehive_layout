import 'dart:math';

import 'package:beehive_layout/helper/pair.dart';
import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class BeehiveLayout extends StatelessWidget {
  final Function(dynamic) onClick;
  final int column;
  final List<Widget> contents;
  final double size;
  final double spacing;
  final double cornerRadius;

  const BeehiveLayout({
    Key key,
    this.onClick,
    this.column = 3,
    this.contents,
    this.size = 100,
    this.spacing = 5,
    this.cornerRadius = 1,
  }) : super(key: key);

  double calculateHeight() {
    return ((contents.length / column).ceilToDouble() *
            (size - (size / 4) + (spacing))) +
        ((size / 4));
  }

  double calculateWidth() {
    double h = ((size / 2) * (sqrt(3)) + (spacing));
    return (h * column) + (size / 2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: calculateHeight(),
      width: calculateWidth(),
      child: Stack(
        fit: StackFit.loose,
        overflow: Overflow.visible,
        children: buildContent(context),
      ),
    );
  }

  Pair calculatePosition(int r, int c) {
    double h = ((size / 2) * (sqrt(3)) + (spacing));
    double topX = h * c;
    double topY = (size - (size / 4) + (spacing)) * r;

    if (r % 2 != 0) {
      topX += (h / 2);
    }

    return Pair(topX, topY);
  }

  buildContent(BuildContext context) {
    List<Widget> items = List();
    int col = 0;
    for (int i = 0; i < contents.length; i++) {
      int row = (i / column).floor();
      if (col >= column) {
        col = 0;
      }

      Pair pos = calculatePosition(row, col);
      print("r = $row c = $col");
      print("x = ${pos.first} y = ${pos.second}");

      items.add(
        Positioned(
          top: pos.second,
          left: pos.first,
          child: Container(
            width: size,
            height: size,
            child: ClipPolygon(
              sides: 6,
              borderRadius: cornerRadius,
              rotate: 0.0,
              boxShadows: [
                PolygonBoxShadow(color: Colors.black, elevation: 1.0),
                PolygonBoxShadow(color: Colors.grey, elevation: 5.0)
              ],
              child: Container(
                padding: EdgeInsets.all(5),
                color: Colors.white,
                child: ClipPolygon(
                  sides: 6,
                  borderRadius: cornerRadius, // Default 0.0 degrees
                  rotate: 0.0,
                  child: Container(
                    color: Colors.black12,
                    padding: EdgeInsets.all(1),
                    child: ClipPolygon(
                      sides: 6,
                      borderRadius: cornerRadius, // Default 0.0 degrees
                      rotate: 0.0,
                      boxShadows: [
                        PolygonBoxShadow(
                          color: Colors.grey.withAlpha(10),
                          elevation: 0.0,
                        ),
                      ],
                      child: Container(
                        color: Colors.yellow,
                        child: ClipPolygon(
                          sides: 6,
                          borderRadius: cornerRadius, // Default 0.0 degrees
                          rotate: 0.0,
                          boxShadows: [
                            PolygonBoxShadow(
                              color: Colors.grey.withAlpha(10),
                              elevation: 0.0,
                            ),
                          ],
                          child: Container(
                            child: contents[i],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      col++;
    }

    return items;
  }
}
