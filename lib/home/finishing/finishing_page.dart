import 'package:flutter/material.dart';

import '../../dialogs.dart';
import '../../models/finishing.dart';

class FinishingScreen extends StatelessWidget {
  final int id;
  const FinishingScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          id == 0
              ? "Flooring"
              : id == 1
                  ? "Paints and Polishes"
                  : id == 2
                      ? "Doors and Accessories"
                      : id == 3
                          ? "Lighting"
                          : id == 4
                              ? "Kitchen"
                              : id == 5
                                  ? "Bathroom"
                                  : "Materials",
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black54),
      ),
      body: id == 0
          ? SingleChildScrollView(
              // scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  FinishingList(
                    materialList: flooringItalian,
                    name: "Italian Marbles",
                  ),
                  FinishingList(
                    materialList: flooringGranite,
                    name: "Granites",
                  ),
                  FinishingList(
                    materialList: flooringOnyx,
                    name: "Onyx Marbles",
                  ),
                  FinishingList(
                    materialList: flooringSize,
                    name: "Tiles by Size",
                  ),
                  FinishingList(
                    materialList: flooringBrand,
                    name: "Tiles by Brand",
                  ),
                ],
              ),
            )
          : id == 1
              ? SingleChildScrollView(
                  // scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      FinishingList(
                        materialList: paintDiv,
                        name: "Paints Diversification",
                      ),
                      FinishingList(
                        materialList: paintBrand,
                        name: "Brands",
                      ),
                    ],
                  ),
                )
              : id == 2
                  ? SingleChildScrollView(
                      // scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          FinishingList(
                            materialList: doors,
                            name: "Doors",
                          ),
                          FinishingList(
                            materialList: doorFrames,
                            name: "Door & Window Frames",
                          ),
                          FinishingList(
                            materialList: doorsLatest,
                            name: "Latest Accessories",
                          ),
                          FinishingList(
                            materialList: doorsCube,
                            name: "Cube Shelvings",
                          ),
                          FinishingList(
                            materialList: doorsLight,
                            name: "Furniture Lights",
                          ),
                        ],
                      ),
                    )
                  : id == 3
                      ? SingleChildScrollView(
                          // scrollDirection: Axis.horizontal,
                          child: Column(
                            children: [
                              FinishingList(
                                materialList: LightTechnologies,
                                name: "Lighting Technologies",
                              ),
                              FinishingList(
                                materialList: LightChandeliers,
                                name: "Chandeliers",
                              ),
                              FinishingList(
                                materialList: LightPandent_lamp,
                                name: "Pendant Lamps",
                              ),
                              FinishingList(
                                materialList: Lightbrand,
                                name: "Brands",
                              ),
                            ],
                          ),
                        )
                      : id == 4
                          ? SingleChildScrollView(
                              // scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [
                                  FinishingList(
                                    materialList: kitchenLatest,
                                    name: "Latest Technologies",
                                  ),
                                  FinishingList(
                                    materialList: kitchenType,
                                    name: "Types",
                                  ),
                                  FinishingList(
                                    materialList: kitchenBrands,
                                    name: "Brands",
                                  ),
                                ],
                              ),
                            )
                          : SingleChildScrollView(
                              // scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [
                                  FinishingList(
                                    materialList: bathSpecial,
                                    name: "Facelift Specialties",
                                  ),
                                  FinishingList(
                                    materialList: bathColor,
                                    name: "Colors",
                                  ),
                                  FinishingList(
                                    materialList: bathBrands,
                                    name: "Brands",
                                  ),
                                ],
                              ),
                            ),
    );
  }
}

class FinishingList extends StatelessWidget {
  final List<FinishingMaterial> materialList;
  final String name;
  const FinishingList({
    Key? key,
    required this.materialList,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16),
            child: Text(
              name,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 8, left: 4),
            height: name == "Doors" ? size.width * 0.6 : size.width * 0.5,
            // height: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: materialList.length,
              itemBuilder: (context, index) => FinishingPageCard(
                material: materialList[index],
                door: name == "Doors",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FinishingPageCard extends StatelessWidget {
  final FinishingMaterial material;
  final bool door;
  const FinishingPageCard({
    Key? key,
    required this.material,
    required this.door,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => showImageDialogBox(context, material.image, false),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(24),
              shadowColor: Colors.white,
              child: SizedBox(
                height: door ? size.width * 0.5 : size.width * 0.35,
                width: size.width * 0.35,
                // color: Colors.black12,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    material.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          material.name != ""
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: SizedBox(
                    width: size.width * 0.31,
                    child: Text(
                      material.name,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
