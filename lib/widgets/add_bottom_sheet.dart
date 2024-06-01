import 'package:flutter/material.dart';
import 'package:mytodo/main.dart';

import '../model/models.dart';

class AddBottomSheet extends StatefulWidget {
  final Function() callback;

  const AddBottomSheet({super.key, required this.callback});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  final _textEditingController = TextEditingController();
  String textFieldText = '';

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
/*            const Padding(
              padding: EdgeInsets.only(bottom: 16, top: 24),
              child: Center(
                  child: Text("Yeni Abonelik",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500))),
            ),*/
            AppBar(
              centerTitle: true,
              toolbarHeight: 70,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,

              title: Text("Add To-do",
                  style: TextStyle(
                      fontSize:20,fontWeight: FontWeight.w500)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 16,top: 8),
              child: Material(
                elevation: 0,
                color: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                child:
                TextField(
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                    fontSize: 18,
                      color: Theme.of(context).colorScheme.onSurface),
                  onChanged: (value) {
                    setState(() {
                      textFieldText = value;
                    });
                  },
                  autofocus: true,
                  controller: _textEditingController,
                  maxLines: 2,
                  minLines: 1,
                  textAlignVertical: TextAlignVertical.center,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 18,vertical: 14),
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black.withOpacity(0.1)
                        : Colors.white.withOpacity(0.3),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(width: 1,color: Theme.of(context).colorScheme.outlineVariant)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(width: 1,color: Theme.of(context).colorScheme.primary)),
                    hintText: "Name",
                    hintStyle: TextStyle(
                      height: 1.2,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
                /*TextField(
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onSurface),
                  textCapitalization: TextCapitalization.words,
                  controller: _textEditingController,
                  onChanged: (value) {
                    setState(() {
                      textFieldText = value;
                    });
                  },
                  autofocus: true,
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                      label: Text('Abonelik adı')),
                ),*/
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16),
                    )),
                const SizedBox(width: 10),
                FilledButton(
                  onPressed: () {
                    if(textFieldText.trim().isNotEmpty){
                      objectbox.addTodo(
                          Todo(
                            title: textFieldText.trim(),
                            creationDate: DateTime.now(),
                          ));

                      Navigator.pop(context);
                    }
                  }, child: Text(
                  'Save',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 8)
          ],
        ));
  }
}