import 'package:flutter/material.dart';

class AddBreakdown extends StatelessWidget{
  AddBreakdown({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

    renderTextFormField({
      required String label,
      required FormFieldSetter? onSaved,
      required FormFieldValidator? validator,
    }) {
      assert(onSaved != null);
      assert(validator != null);

      return Column(
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          TextFormField(
            onSaved: onSaved,
            validator: validator,
          ),
        ],
      );
    }

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
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                renderTextFormField(
                label: '내역',
                onSaved: (val) {},
                validator: (val) {
                  return null;
                },
                ),
                OutlinedButton(
      onPressed: () {},
      child: const Text(
        '저장하기!',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
              ),
              ]
            ),
          )
        )
        // child:Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     const Text('Add Breakdown')
        //   ],
        // ),
      )
    );  
  }
}