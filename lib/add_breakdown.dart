import 'package:flutter/material.dart';

class AddBreakdown extends StatelessWidget{
  AddBreakdown({Key? key}) : super(key: key);

    // renderTextFormField({
    //   required String label,
    //   required FormFieldSetter onSaved,
    //   required FormFieldValidator validator,
    // }) 
    // {
    //   return Column(
    //     children: [
    //       Container(
    //         padding: const EdgeInsets.all(15),
    //         child: Row(
    //         children: [
    //           // Text(
    //           //   label,
    //           //   style: const TextStyle(
    //           //     fontSize: 15.0,
    //           //     fontWeight: FontWeight.w600,
    //           //   ),
    //           // ),
    //           Expanded(
    //             // padding: const EdgeInsets.all(10.0),
    //             child: TextFormField(
    //               decoration: const InputDecoration(
    //                 labelText: 'labelText',
    //                 // suffixText: 'suffixText',
    //                 hintText: 'hintText',
    //                 // prefixText: 'prefixText'
    //               ),
    //               onSaved: onSaved,
    //               validator: validator,
    //             ),
    //           ),
    //         ],
    //       ),)

    //     ],
    //   );
    // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Breakdown"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BreakdownPage(),
    );  
  }
}

class BreakdownPage extends StatefulWidget {
  const BreakdownPage({Key? key}) : super(key:key);

  @override
  State<BreakdownPage> createState() => _BreakdownPageState();
}

class _BreakdownPageState extends State<BreakdownPage> {

  final formKey = GlobalKey<FormState>();
  TimeOfDay time = const TimeOfDay(hour: 0, minute: 0);
  DateTime _dateTime = DateTime(2022);
  final _cateList = ['식당', '카페', '베이커리', '서점'];
  var _selectedCate = '식당';
  final _tagList = {
    '용돈' : {'isSelected': false},
    '가족' : {'isSelected': false},
    '선물' : {'isSelected': false},
    '취미' : {'isSelected': false},
    '여행' : {'isSelected': false},
  };
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: '내역2',
                              hintText: 'hintText',
                              // focusColor: Colors.black12,
                              // fillColor: Colors.red,
                              // hoverColor: Colors.orange,
                            ),
                            onSaved: (val) {},
                            validator: (val) {
                              // return null;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: '금액',
                              // suffixText: 'suffixText',
                              hintText: 'hintText',
                              // prefixText: 'prefixText'
                            ),
                            onSaved: (val) {},
                            validator: (val) {
                              // return null;
                            },
                          ),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [ TextButton(
                              child: Text('${_dateTime.year} - ${_dateTime.month} - ${_dateTime.day}',
                                style: const TextStyle(fontSize: 25, color: Colors.black54),
                              ), 
                              onPressed: () async {
                                DateTime? newDate = await showDatePicker(
                                  context: context, 
                                  initialDate: _dateTime, 
                                  firstDate: DateTime(1900), 
                                  lastDate: DateTime(3000),
                                );
                                if(newDate != null) {
                                  setState(() {
                                    _dateTime = newDate;
                                  });
                                }
                              },
                              // style: TextButton.styleFrom(
                                
                              //   backgroundColor: Theme.of(context).primaryColor,
                              // ),
                            ),
                            TextButton(
                              child: Text('${time.hour.toString()}:${time.minute.toString()}',
                                style: const TextStyle(fontSize: 25, color: Colors.black54),
                              ), 
                              onPressed: () async {
                                TimeOfDay? newTime = await showTimePicker(context: context, initialTime: time);
                                if(newTime != null) {
                                  setState(() {
                                    time = newTime;
                                  });
                                }
                              },
                            ),
                          ],)

                          ),
                          DropdownButtonFormField(
                            value: _selectedCate,
                            items: _cateList.map(
                              (item) {
                                return DropdownMenuItem(value:item, child: Text(item));
                              }
                            ).toList(),
                            onChanged: (String? item) {
                              setState(() {
                                _selectedCate = item!;
                              });
                            },
                          ),
                          

                          // Row(
                          //   children: [
                          //     List.generate(_tagList.length, (index) {

                          //     })
                          //     // _tagList.map((tag) {
                          //     //   return ChoiceChip(label: Text(tag), selected: selected)
                          //     // }))
                          //   ],
                          // )
                        ],)
                      ),
                    ]
                  ),
                ),
              )
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                child: const Text(
                  '지출내역 추가하기',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () async {
                  if(formKey.currentState!.validate()) {
                    print("validate()");
                  }
                },
              ),
            ),
          ],
        )
        // child:Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     const Text('Add Breakdown')
        //   ],
        // ),
      );
  }
}