import 'dart:io';

import 'package:film_space/Screens/Home/video_view.dart';
import 'package:film_space/user_files.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:video_player/video_player.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: SafeArea(
        child: ListView.builder(
            itemCount: UserFiles.title.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => VideoView(),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: width,
                      height: 200,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: const Offset(
                              0.0,
                              5.0,
                            ),
                            blurRadius: 15.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(
                            File(
                              UserFiles.selectedImage[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blue.shade100,
                          radius: 25,
                          child: FlutterLogo(
                            size: 40,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          UserFiles.title[index],
                          style: GoogleFonts.ubuntu(
                            fontSize: 20,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
