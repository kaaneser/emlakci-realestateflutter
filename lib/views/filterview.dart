import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vtysproje/constants/decoration_constants.dart';
import 'package:vtysproje/views/homeview.dart';

class FilterView extends StatefulWidget {
  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  String val = '';
  String value = "Seçim yap";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 24, left: 24, top: 32, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Aramayı Filtrele",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Fiyat Aralığı",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  onChanged: (text) {
                    if (text == "")
                      maxPrice = "";
                    else
                      minPrice = text;
                  },
                  decoration: InputDecoration(
                    hintText: "En az",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
              ),
              Text(" - ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Expanded(
                child: TextField(
                  onChanged: (text) {
                    if (text == "")
                      maxPrice = "";
                    else
                      maxPrice = text;
                  },
                  decoration: InputDecoration(
                    hintText: "En fazla",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
              ),
            ],
          ),
          DecorationConstants.instance.sizedBoxh10,
          Text(
            "Tip",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          DecorationConstants.instance.sizedBoxh10,
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: value,
                items: <String>[
                  "Seçim yap",
                  "Kiralık",
                  "Satılık",
                  "Günlük",
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
                onChanged: (status) {
                  setState(() {
                    statusDetail = status.toString();
                    value = status.toString();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
