import 'package:flutter/material.dart';

class AddBreakdown extends StatelessWidget{
  AddBreakdown({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

    renderTextFormField({
      required String label,
      required FormFieldSetter onSaved,
      required FormFieldValidator validator,
    }) 
    {
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
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        onSaved: (val) {},
                        validator: (val) {
                          // return null;
                          return null;
                        },
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
                    fontWeight: FontWeight.w600,
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
      )
    );  
  }
}