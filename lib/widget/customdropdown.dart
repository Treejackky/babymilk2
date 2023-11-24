import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final Function(String?) onChanged;
  final String? value;
  final String? hintText;
  final double? width;

  CustomDropdown({
    required this.items,
    required this.onChanged,
    this.value,
    this.hintText,
    this.width,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant CustomDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      setState(() {
        dropdownValue = widget.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: dropdownValue,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue;
        });
        widget.onChanged(newValue);
      },
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8),
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: MediaQuery.of(context).size.height * 0.02,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: widget.hintText == 'เพศ' ? '' : widget.hintText,
      ),
      icon: Container(),
    );
  }
}
