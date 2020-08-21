import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xlo/screens/create/widgets/image_source_sheet.dart';

class ImagesField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormField<List>(
      initialValue: [],
      builder: (state) {
        return Column(
          children: [
            Container(
              color: Colors.grey[200],
              height: 140,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.value.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.value.length) {
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => ImageSourceSheet((image) {
                                    state.didChange(state.value..add(image));
                                    Navigator.of(context).pop();
                                  }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 16, bottom: 16),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            radius: 52,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                Text(
                                  "+ Inserir",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.file(state.value[index]),
                                      FlatButton(
                                        child: Text("Excluir"),
                                        textColor: Colors.red,
                                        onPressed: () {
                                          state.didChange(
                                              state.value..removeAt(index));
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  ),
                                ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, top: 16, bottom: 16),
                        child: CircleAvatar(
                          radius: 52,
                          backgroundImage: FileImage(state.value[index]),
                        ),
                      ),
                    );
                  }),
            )
          ],
        );
      },
    );
  }
}
