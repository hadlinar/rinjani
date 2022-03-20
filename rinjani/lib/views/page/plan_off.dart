import 'package:flutter/material.dart';

import '../../utils/global.dart';
import '../../utils/global_state.dart';

class Off extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _Off();
  }
}

final GlobalState store = GlobalState.instance;

class _Off extends State<Off> {
  String? offType;
  String? descFilled;

  @override
  Widget build(BuildContext context) {
    store.set("descOff", descFilled);
    store.set("offType", offType);
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
            padding: const EdgeInsets.only(top: 17, right: 21, left: 21, bottom: 17),
            child: Column(
                children: <Widget> [
                  DropdownButtonFormField<String>(
                    hint: Text("Choose"),
                    dropdownColor: Colors.white,
                    style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
                    value: offType,
                    items: ["Izin", "Sakit", "Other"].map((e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        offType = value;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only( top: 10, bottom: 10, left: 12, right: 12),
                      labelText: "Type",
                      labelStyle: const TextStyle(
                          color: Color(0xff757575),
                          fontSize: 15,
                          fontFamily: 'medium'),
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(10),
                          borderSide: BorderSide()
                      ),
                    ),
                  ),
                  offType == "Other" ? Container(
                    padding: const EdgeInsets.only(top: 17),
                    child: TextFormField(
                      style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
                      maxLines: 4,
                      maxLength: 150,
                      onChanged: (text) {
                        setState(() {
                          descFilled = text;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Description",
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius .circular(10),
                            borderSide: BorderSide()),
                      ),
                    ),
                  ) : Container()
                ]
            )
        )
    );
  }
}