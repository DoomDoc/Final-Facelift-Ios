// ignore_for_file: non_constant_identifier_names

class Labor {
  final String name;
  final String description;
  final String image;

  Labor({required this.name, required this.description, required this.image});
}

List<Labor> labor_list = [
  Labor(
    name: "Thekedaar",
    description: """
Experienced thekedaars with good command over labor. 
Vast knowledge of complex plans and processes, we make sure there is not a single day of delay in the project's completion.
      """,
    image: "assets/labor/thekedaar.png",
  ),
  Labor(
    name: "Painter",
    description: """
Trained painters with proper knowledge to use high-speed painting machines & tools.
Dedicated to create no mess while painting. 
""",
    image: "assets/labor/painter.jpg",
  ),
  Labor(
    name: "Mistri",
    description: """
Construct neat and quality finish walls, pillars, plaster, everything.
Only the top mistris known for their precision work with Facelift.
They take care of every single element of your house like plant pots, rain drains, DPCs, etc.
""",
    image: "assets/labor/mistri.png",
  ),
  Labor(
    name: "Majdoor",
    description: """
Arrive on time, work even if no one is around to see, leave the site with day's work completed.
An ideal majdoor delivers quality and high speed in construction of the house.
""",
    image: "assets/labor/majdoor.png",
  ),
  Labor(
    name: "Carpenter",
    description: """
Highly skilled work ensures long lasting product quality
Facelift's in house carpenters are trained into leaving no mess after work.
""",
    image: "assets/labor/carpenter.png",
  ),
  Labor(
    name: "Welder",
    description: """
Best in quality gates, girders, channels, railings, etc. at the fastest pace possible.
Facelift's partnered welders uses only high-grade metal. 
""",
    image: "assets/labor/welder.jpg",
  ),
  Labor(
    name: "Plumber",
    description: """
Attains vast knowledge in installing high-end jacuzzi systems, swimming pools, etc.
Plumbers who work according to the plumbing plans provided by the architects of the site.
""",
    image: "assets/labor/plumber.jpg",
  ),
  Labor(
    name: "Glass labor",
    description: """
Free & careful transportation of glass directly from the manufacturer to your doorstep.
We take full responsibility for glass damage while installation. 
""",
    image: "assets/labor/glass_labor.jpg",
  ),
  Labor(
    name: "Electrician",
    description: """
Electricians capable of installing high-end chandeliers, pendant lamps, fancy lights.
Standardized color wires are used so that they can be replaced or fixed easily even after years.
""",
    image: "assets/labor/electrician.png",
  ),
  Labor(
    name: "Tile/Marble Mistri",
    description: """
Use of plastic sheets keeps the original shine of the floor materials.
Experts in installing heated floors.
Heavy Machines are used for finishing after the completion of flooring.
""",
    image: "assets/labor/Tile_Marble_Mistri.jpg",
  )
];
