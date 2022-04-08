class RawMaterial {
  String name;
  String description;
  String image;
  String p1;
  String p2;
  String p3;
  RawMaterial({
    required this.name,
    required this.description,
    required this.image,
    required this.p1,
    required this.p2,
    required this.p3,
  });
}

List<RawMaterial> rawMaterialList = [
  RawMaterial(
    name: "Cement",
    description: """
If home is the body, cement is the blood.
At Facelift, we deliver the best in quality cement from some of the leading manufacturers directly at the construction site.""",
    image: "assets/raw/Cement/image.jpg",
    p1: "assets/raw/Cement/p1.png",
    p2: "assets/raw/Cement/p2.jpg",
    p3: "assets/raw/Cement/p3.jpg",
  ),
  RawMaterial(
    name: "Bricks",
    description: """
Compressive strength-tested bricks are available for a house's perfect shape & strength.
We provide 'First-class' red bricks, large 'Concrete blocks', and 'engineering bricks'.""",
    image: "assets/raw/Bricks/image.jpg",
    p1: "assets/raw/Bricks/p1.jpg",
    p2: "assets/raw/Bricks/p2.jpg",
    p3: "assets/raw/Bricks/p3.jpg",
  ),
  RawMaterial(
    name: "Aggregate",
    description: """
Facelift provides the finest & hardest riverside aggregate/bajri for use in RCC, foundation, pillars, roofs, etc.
We make sure our customer gets the full quantity of aggregate they have paid for.""",
    image: "assets/raw/Aggregate/image.jpg",
    p1: "assets/raw/Aggregate/p1.jpg",
    p2: "assets/raw/Aggregate/p2.jpg",
    p3: "assets/raw/Aggregate/p3.jpg",
  ),
  RawMaterial(
      name: "Sand",
      description: """
For best binding properties, PIT sand is provided by Facelift's associated sand collecting operators.
From increasing ground level to making good quality plaster, only the cleanest sand is delivered.""",
      image: "assets/raw/Sand/image.jpg",
      p1: "assets/raw/Sand/p1.jpg",
      p2: "assets/raw/Sand/p2.jpg",
      p3: "assets/raw/Sand/p3.jpg"),
  RawMaterial(
      name: "TMT Steel Bars",
      description: """
Facelift provides only corrosion (Jang) free coated TMT steel bars (sariya).
Only the branded bars have been used in beams, RCCs, slabs, foundations, etc.""",
      image: "assets/raw/Steel_Bars/image.jpg",
      p1: "assets/raw/Steel_Bars/p1.jpg",
      p2: "assets/raw/Steel_Bars/p2.png",
      p3: "assets/raw/Steel_Bars/p3.jpg"),
];
