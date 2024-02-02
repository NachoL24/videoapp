// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

enum DropDownType { minutes , seconds , rounds}

late String dropDownValue;

var minutes = ['00','01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35','36','37','38','39','40', '41', '42', '43', '44', '45','46','47','48','49','50', '51', '52', '53', '54', '55','56','57','58','59',];

var seconds = ['00','01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35','36','37','38','39','40', '41', '42', '43', '44', '45','46','47','48','49','50', '51', '52', '53', '54', '55','56','57','58','59',];

var rounds = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30'];

class SelectTimeDropDown extends StatefulWidget {
  final deviceHeight;
  
  final deviceWidth;
  
  final colorTheme;
  
  final DropDownType dropDownType;

  final ValueChanged<String> onChanged;

  const SelectTimeDropDown({super.key, this.deviceHeight, this.deviceWidth, this.colorTheme, required this.dropDownType, required this.onChanged,});

  @override
  State<SelectTimeDropDown> createState() => _SelectTimeDropDownState();
}

class _SelectTimeDropDownState extends State<SelectTimeDropDown> {
  var dropDownValue = '00';
  @override
  Widget build(BuildContext context) {
    
    late final type;
    switch(widget.dropDownType){
      case DropDownType.minutes:
        type = minutes;
        break;
      case DropDownType.seconds:
        type = seconds;
        break;
      case DropDownType.rounds:
        type = rounds;
        break;
    }

    return FilledButton(
      onPressed: () {_displayBottomSheet(context, type);},
      style: ButtonStyle(shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),backgroundColor: MaterialStateColor.resolveWith((states) => widget.colorTheme.primary), elevation: MaterialStateProperty.resolveWith((states) => 20)),
              child: SizedBox(
                width: widget.deviceWidth / 7,
                height: widget.deviceHeight / 8,
                child: Center(child: Text(dropDownValue, style: TextStyle(fontSize: (widget.deviceWidth / 10) , color: widget.colorTheme.background),)),
              ),
    );
  }

  Future _displayBottomSheet (BuildContext context, List type){
    return showModalBottomSheet(
      //useRootNavigator: true,
      //showDragHandle: true,
      isScrollControlled: false,
      scrollControlDisabledMaxHeightRatio: 0.5,
      context: context,
      backgroundColor: widget.colorTheme.primary,
      barrierColor: Colors.black87.withOpacity(0.5),
      isDismissible: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context,) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.only(top: 15, bottom: 10), child: Container(width: 50, height: 2, color: Colors.black26,),),
          const Divider(color: Colors.black12),
          Expanded(
                child: ListView.separated(
                  itemCount: type.length,
                  itemBuilder: (BuildContext context, int index) => SizedBox(
                    height: 50,
                    child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          dropDownValue = type[index];
                        });
                        widget.onChanged(type[index]);
                        Navigator.pop(context);
                      },
                      child: Text(
                        type[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.black12),
                ),
              ),
        ],
      ),
    );
  }

  }
