import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:war/src/models/territory/territory.dart';
import 'package:war/src/models/user/user.dart';
import 'package:war/src/services/get_correct_territory.dart';

class TerritoryItemWidget extends StatefulWidget {
  final Territory territory;
  final User? user;
  final Function() onTap;
  const TerritoryItemWidget({
    Key? key,
    required this.territory,
    required this.user,
    required this.onTap,
  }) : super(key: key);

  @override
  State<TerritoryItemWidget> createState() => _TerritoryItemWidgetState();
}

class _TerritoryItemWidgetState extends State<TerritoryItemWidget> {
  int amount = 1;
  bool isConquisted = false;
  @override
  Widget build(BuildContext context) {
    return widget.territory.offset == Offset.zero
        ? SizedBox()
        : Positioned(
            top: MediaQuery.of(context).size.height *
                (GetCorrectTerritory.get(widget.territory.id).offset.dy / 100),
            left: MediaQuery.of(context).size.width *
                (GetCorrectTerritory.get(widget.territory.id).offset.dx / 100),
            child: Container(
              color: Colors.red,
              child: Column(
                children: [
                  Center(
                    child: InkWell(
                      onTap: () {
                        // bool result = widget.onTap();
                        // if (result)
                        setState(() {
                          isConquisted = true;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            widget.territory.name,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "${widget.user?.name ?? ''}",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            widget.territory.amountSoldiers.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isConquisted,
                    child: SizedOverflowBox(
                      size: Size.zero,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100, left: 100),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Remanejar soldados'),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(Icons.arrow_back_ios),
                                      onPressed: () => setState(() {
                                        amount--;
                                      }),
                                    ),
                                    Text("$amount"),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(Icons.arrow_forward_ios),
                                      onPressed: () => setState(() {
                                        amount++;
                                      }),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () => setState(() {
                                    isConquisted = false;
                                  }),
                                  child: Text('Mover'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // territory.id == 12
            //     ? Positioned(
            //         child: SizedBox(
            //         width: MediaQuery.of(context).size.width * 0.13,
            //         height: MediaQuery.of(context).size.height * 0.23,
            //         child: SvgPicture.asset(
            //           'assets/territories/brazil.svg',
            //           color: Colors.blue,
            //         ),
            //       ))
            //     : SizedBox(),
          );
  }
}
