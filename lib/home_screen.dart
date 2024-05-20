import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = true;
  File? _image;
  List? _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  Future<void> detectImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _output = output;
      _loading = false;
    });
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _loading = true;
      });
      detectImage(_image!);
    }
  }

  Future<void> pickGalleryImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _loading = true;
      });
      detectImage(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF004242),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Text(
              "Cat and Dog Detector App",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 50),
            Center(
              child: _loading
                  ? Container(
                      width: 300,
                      height: 300,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/dog.jpg",
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        children: [
                          Container(
                            height: 250,
                            child: Image.file(_image!),
                          ),
                          SizedBox(height: 20),
                          _output != null
                              ? Text(
                                  "${_output![0]['label']}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                )
                              : Container(),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
            ),
            SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "Capture a Photo",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 7),
                  GestureDetector(
                    onTap: pickGalleryImage,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "Select a Photo",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   bool _loading = true;
//   File? _image;
//   List? _output;
//   //this will allow to pick image form the gallery
//   final picker = ImagePicker();
//    @override
//   void initState(){
//     super.initState();
//     loadModel().then((value){
//       setState(() {
        
//       });

//     });

//   }
  
//   dectectImage(File image) async {
//     var output = await Tflite.runModelOnImage(
//         path: image.path,
//         numResults: 2,
//         threshold: 0.6,
//         imageMean: 127.5,
//         imageStd: 127.5
//         );
//         setState(() {
//           _output=output;
//           _loading=false;
//         });
//   }
//   loadModel()async{
//     await Tflite.loadModel(model: "images/model_unquant.tflite",labels: "images/labels.txt");
//   }
//   @override
//   void dispose() {
    
//     super.dispose();

//   }
//   pickImage()async{
//     var image=await picker.pickImage(source: ImageSource.camera);
//     if(image==null)  return null;

//     setState(() {
//       _image=File(image.path);
//     });
//     dectectImage(_image!);
  
//   }
//     pickGalleryImage()async{
//     var image=await picker.pickImage(source: ImageSource.gallery);
//     if(image==null){
//       return null;
//     }
//     setState(() {
//       _image=File(image.path);
//     });
//     dectectImage(_image!);
  
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF004242),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 25),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 40,
//             ),
//             // Text("Coding Nouman",

//             // style: TextStyle(color: Color(0xFF709E9E),
//             // fontSize: 20,
//             // fontWeight: FontWeight.bold,
//             // ),
//             // ),
//             // SizedBox(height: 5,),
//             Text(
//               "Cat and Dog Detector App,",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 30,
//               ),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             Center(
//               child: _loading
//                   ? Container(
//                       width: 300,
//                       height: 300,
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             "images/dog.jpg",
//                             fit: BoxFit.cover,
//                           ),
//                           SizedBox(
//                             height: 40,
//                           )
//                         ],
//                       ),
//                     )
//                   : Container(
//                     //now it will display the image that user select
//                     child: Column(
//                       children: [
//                         Container(
//                           height: 250,
//                           child: Image.file(_image!),
//                         ),
//                         SizedBox(height: 20,),
//                         _output!=null?Text("${_output![0]['labels']}",style: TextStyle(color: Colors.white, fontSize: 15),)
//                         :Container(),
//                         SizedBox(height: 10,)

//                       ],
//                     ),
//                   ),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       pickImage();
//                     },
//                     child: Container(
//                       width: MediaQuery.of(context).size.width / 3,
//                       alignment: Alignment.center,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                       decoration: BoxDecoration(
//                         color: Colors.redAccent,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: Text(
//                         "Capture a Photo",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 7,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       pickGalleryImage();
//                     },
//                     child: Container(
//                       width: MediaQuery.of(context).size.width / 3,
//                       alignment: Alignment.center,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 10, vertical: 7),
//                       decoration: BoxDecoration(
//                         color: Colors.redAccent,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: Text(
//                         "Select a Photo",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
