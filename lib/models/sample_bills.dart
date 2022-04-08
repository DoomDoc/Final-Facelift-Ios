class SampleBill {
  String name;
  String amount;
  String image;
  SampleBill({
    required this.name,
    required this.amount,
    required this.image,
  });
}

List<SampleBill> sampleBillList = [
  SampleBill(
    name: "Sanitary",
    amount: "4700",
    image: "assets/sample_bills/1.jpg",
  ),
  SampleBill(
    name: "Flush Doors",
    amount: "154932",
    image: "assets/sample_bills/2.jpg",
  ),
  SampleBill(
    name: "Sanitary taps",
    amount: "16317",
    image: "assets/sample_bills/3.jpg",
  ),
  SampleBill(
    name: "Chimney",
    amount: "13000",
    image: "assets/sample_bills/4.jpg",
  ),
  SampleBill(
    name: "Mortar",
    amount: "927",
    image: "assets/sample_bills/5.jpg",
  ),
  SampleBill(
    name: "Wipro lights",
    amount: "1960",
    image: "assets/sample_bills/6.jpg",
  ),
];
