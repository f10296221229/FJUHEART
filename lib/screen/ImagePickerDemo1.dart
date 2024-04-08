import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ImagePickerDemo1 extends StatefulWidget {
  const ImagePickerDemo1({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  createState() => _ImagePickerDemo1State();
}

class _ImagePickerDemo1State extends State<ImagePickerDemo1> {
  File? _imageFile;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  void _pickImage1() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() async {
      final response = await http.get(Uri.parse('http://localhost:8080/devmvc/resources/images/btn12.png'));
      final documentDirectory = await getApplicationDocumentsDirectory();
      final file = File(join(documentDirectory.path, 'imagetest.jpg'));

      file.writeAsBytesSync(response.bodyBytes);

      // return file;
      _imageFile = file;
    });
  }

  Future<void> _dialogBuilder(BuildContext context, String checkHint) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '錯誤',
            style: TextStyle(color: Colors.red[300], fontSize: 18),
          ),
          content: Text(checkHint),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); //弹窗消失
                },
                child: const Text('確定')),
          ],
        );
      },
    );
  }

  // void _uploadImage() async {
  //
  //   if (_imageFile == null) {
  //     return;
  //   }
  //   final request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse('你的上传地址'),
  //   );
  //   request.files.add(await http.MultipartFile.fromPath(
  //     'image',
  //     _imageFile!.path,
  //   ));
  //   final response = await request.send();
  //   if (response.statusCode == 200) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Upload success!')),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Upload failed!')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _imageFile == null
            ? const Text('No image selected.')
            : Image.file(_imageFile!),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _pickImage,
            tooltip: 'Pick Image',
            child: const Icon(Icons.add_a_photo),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            // onPressed: _uploadImage,
            onPressed:() async{
              if (_imageFile == null) {
                _dialogBuilder( context,"無上傳照片");
                return;
              }
              final request = http.MultipartRequest(
                'POST',
                Uri.parse('http://211.20.21.35:8080/fjuheart/MH200101/insertattach'),
              );
              request.files.add(await http.MultipartFile.fromPath(
                'file',
                _imageFile!.path,
              ));
              request.fields["PARENT_SYS_ID"] = "";
              request.fields["VENDOR_ID"] = "";
              request.fields["MEMO"] = "";

              final response = await request.send();
              if (response.statusCode == 200) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Upload success!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Upload failed!')),
                );
              }
            },

            tooltip: 'Upload Image',
            child: const Icon(Icons.file_upload),
          ),
        ],
      ),
    );
  }
}
