import 'package:file_picker/file_picker.dart';
import 'package:film_space/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

class VideoUploadScreen extends StatefulWidget {
  @override
  _VideoUploadScreenState createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen>
    with AutomaticKeepAliveClientMixin<VideoUploadScreen> {
  @override
  bool get wantKeepAlive => true;

  String title;
  String description;
  String videoName = 'Choose your video file';
  String thumbnailImageName = 'Choose your thumbnail image';

  _openFiles(String storeVariable) async {
    if (storeVariable == 'video') {
      FilePickerResult _result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.video,
      );
      if (_result != null) {
        var fileName = _result.files.first.name.toString();
        print('$storeVariable file name : $fileName');
        setState(() {
          videoName = fileName;
        });
      }
    } else {
      FilePickerResult _result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
      );
      if (_result != null) {
        var fileName = _result.files.first.name.toString();
        print('$storeVariable file name : $fileName');
        setState(() {
          thumbnailImageName = fileName;
        });
      }
    }
  }

  Widget videoTextField(
    labelText,
    hintText,
    keyBoardType,
    icon,
    bottomPadding,
    storeVariable,
    enabled,
  ) {
    return Container(
      margin: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: bottomPadding == true ? 16.0 : 0.0,
      ),
      child: TextFormField(
        onChanged: (val) => storeVariable = val,
        maxLines: null,
        keyboardType: keyBoardType,
        readOnly: enabled,
        focusNode: FocusNode(),
        enabled: !enabled,
        enableInteractiveSelection: false,
        autofocus: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: 16.0,
            top: 16.0,
            bottom: 16.0,
            right: 16.0,
          ),
          focusColor: Colors.white,
          hoverColor: Colors.white,
          isDense: true,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: MyColors.APP_SECONDARY,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: MyColors.APP_SECONDARY,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: MyColors.APP_SECONDARY,
            ),
          ),
          hintText: hintText,
          labelText: labelText,
          suffixIcon: Icon(icon),
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'Upload your Video',
                style: GoogleFonts.ubuntu(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5),
              ),
              SizedBox(
                height: 45,
              ),
              videoTextField(
                'Video Title',
                'App Developement using Flutter',
                TextInputType.text,
                Icons.title,
                true,
                title,
                false,
              ),
              videoTextField(
                'Video Description',
                'App Developement using Flutter',
                TextInputType.multiline,
                Icons.description,
                true,
                description,
                false,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: videoTextField(
                      videoName,
                      null,
                      null,
                      null,
                      true,
                      null,
                      true,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      _openFiles('video');
                    },
                    icon: Icon(
                      Icons.upload_file,
                      color: Colors.purple.shade200,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: videoTextField(
                      thumbnailImageName,
                      null,
                      null,
                      null,
                      true,
                      null,
                      true,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      _openFiles('thumbnail_image');
                    },
                    icon: Icon(
                      Icons.upload_rounded,
                      color: Colors.purple.shade200,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 30,
                ),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.all(12.0),
                  color: MyColors.APP_SECONDARY,
                  focusColor: MyColors.APP_PRIMARY,
                  splashColor: MyColors.APP_PRIMARY,
                  onPressed: () {
                    if (title != null &&
                        description != null &&
                        videoName != null &&
                        thumbnailImageName != null) {
                      print('Accepted');
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Enter all the details before you proceed further',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                      );
                    }
                  },
                  child: Center(
                    child: Text(
                      'Upload Content',
                      style: GoogleFonts.ubuntu(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
