class Mode {
  final String name;
  final String description;
  final String image;

  const Mode({this.name, this.description, this.image});
}

List<Mode> Modes = [
  const Mode(
    name: "Normal Mode",
    description: "Fun Gaming Quiz Mode",
    image: "images/mars.png",
  ),
  const Mode(
    name: "GRE Mode",
    description: "Educational Gaming for GRE Preparation",
    image: "images/great.png",
  ),
  const Mode(
    name: "Profile",
    description: "User Profile",
    image: "images/moon.png",
  ),
];