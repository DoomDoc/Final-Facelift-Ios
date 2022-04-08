import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../log_in/phone_auth_page.dart';
import '../../models/room.dart';
import '../../services/databases.dart';
import '../../dialogs.dart';

class RoomScreen extends StatelessWidget {
  final String name;

  final List<RoomPhotos> photos;
  const RoomScreen({Key? key, required this.photos, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _net = false;
    if (name == "House front") {
      _net = true;
    }
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 65,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title:
              Text("$name Photos", style: const TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black54),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: photos.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => PhotoBox(
                  photo: photos[index],
                  size: size,
                  photos: photos,
                  net: _net,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  name == "Living"
                      ? "Design a luxurious living room with Facelift"
                      : name == "Bathroom"
                          ? "Design a contemporary bathroom with Facelift"
                          : name == "Bedroom"
                              ? "Design a cozy bedroom with Facelift"
                              : name == "Kitchen"
                                  ? "Build a modular kitchen with Facelift"
                                  : name == "Dressing"
                                      ? "Design spacious dressing room with Facelift"
                                      : name == "House front"
                                          ? "Design a unique house front with Facelift"
                                          : "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              InkWell(
                onTap: userLogedIn
                    ? () {
                        DatabaseService()
                            .createRequest("House Room Photos", name);

                        showSimpleAnimatedDialogBox(context,
                            "More $name photos will be provided", "3.png");
                      }
                    : () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PhoneAuthScreen()));
                      },
                child: Container(
                  width: size.width * 0.7,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      border: Border.all(color: pinkColor),
                      borderRadius: BorderRadius.circular(32)),
                  child: const Center(child: Text("See More Photos")),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class PhotoBox extends StatelessWidget {
  final RoomPhotos photo;
  final bool net;
  const PhotoBox({
    Key? key,
    required this.photo,
    required this.size,
    required this.photos,
    required this.net,
  }) : super(key: key);

  final List<RoomPhotos> photos;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: net
            ? Image.network(
                photo.image,
                fit: BoxFit.cover,
                height: size.height * 0.5,
                width: size.width,
              )
            : Image.asset(
                photo.image,
                fit: BoxFit.cover,
                height: size.height * 0.5,
                width: size.width,
              ),
      ),
    );
  }
}
