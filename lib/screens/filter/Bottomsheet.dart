import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetSwitch extends StatefulWidget {
  BottomSheetSwitch({required this.switchValue,
    required this.valueChanged,
    required this.list,required this.title
  });
final List<String> list;
  final bool switchValue;
  final String title;
  final ValueChanged valueChanged;

  @override
  _BottomSheetSwitch createState() => _BottomSheetSwitch();
}

class _BottomSheetSwitch extends State<BottomSheetSwitch> {
  bool ?_switchValue;

  @override
  void initState() {
    _switchValue = widget.switchValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(shrinkWrap: true,scrollDirection: Axis.vertical,
        children:[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${widget.title}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
          )
       ,   ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: widget.list.length,
          itemBuilder: (BuildContext context, int index){
        return Container(
            child: Theme(
            data: ThemeData(
            unselectedWidgetColor: Colors.grey
        ),
    child: CheckboxListTile(
          title:  Text('${widget.list[index]}'),
          value: _switchValue,
          onChanged: (bool ?value) {
            setState(() {
              _switchValue = value;
            });
          },

        ),
    ));}),
      ]));}}