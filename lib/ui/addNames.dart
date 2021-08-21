import 'package:firestore_crud_with_provider/provider/name_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewName extends StatefulWidget {
  const AddNewName({Key? key}) : super(key: key);

  @override
  _AddNewNameState createState() => _AddNewNameState();
}

class _AddNewNameState extends State<AddNewName> {
  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: formKey,
            child: TextFormField(
              validator: (value) => value!.length > 3 ? null : "name required",
              controller: nameController,
              decoration: InputDecoration(hintText: "Enter some name"),
            ),
          ),
          Expanded(
            child: Consumer<NameProvider>(
              builder: (context, name, child) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(name.namesList[index].getName),
                    );
                  },
                  itemCount: name.namesList.length,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            Provider.of<NameProvider>(context, listen: false)
                .addNames(nameController.text);
            nameController.clear();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
