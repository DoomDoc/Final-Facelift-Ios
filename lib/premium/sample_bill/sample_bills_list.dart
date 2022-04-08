// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facelift_constructions/services/databases.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';
import 'add_bill_page.dart';

import '../../constants.dart';
import '../../models/sample_bills.dart';
import 'view_bill.dart';

class SampleBillsList extends StatelessWidget {
  const SampleBillsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String _name;
    int _amount;
    int _warrenty = 0;
    String _image;
    int _date = 0;
    int _month = 0;
    int _year = 0;
    String nu = "";
    String numb = "";
    return StreamBuilder<QuerySnapshot>(
        stream: DatabaseService().userHousebill.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 32, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        snapshot.hasData
                            ? snapshot.data!.docs.isNotEmpty
                                ? "$premiumName's Bills"
                                : "Sample Bills"
                            : "",
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddBillScreen()),
                        ),
                        child: Text(
                          "Add Bills",
                          style: TextStyle(
                            fontSize: 16,
                            color: pinkColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Material(
                        borderRadius: BorderRadius.circular(16),
                        elevation: 10,
                        child: SizedBox(
                          height: 150,
                          width: size.width * 0.4,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.data!.docs.isNotEmpty
                                      ? snapshot.data!.docs.length.toString()
                                      : "0",
                                  style:
                                      TextStyle(fontSize: 75, color: pinkColor),
                                ),
                                Text(
                                  "Bills",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        StreamBuilder<UserAmountModel>(
                            stream: DatabaseService().userAmountStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                numb = commaNumber(snapshot.data!.total);
                                nu = "Rs $numb";
                              } else {
                                nu = "Rs 0";
                              }
                              return Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(16),
                                child: SizedBox(
                                  height: 85,
                                  width: size.width * 0.5,
                                  child: Center(
                                    child: Text(
                                      nu,
                                      style: TextStyle(
                                          color: pinkColor, fontSize: 30),
                                    ),
                                  ),
                                ),
                              );
                            }),
                        SizedBox(height: 8),
                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(16),
                          child: SizedBox(
                            height: 50,
                            width: size.width * 0.5,
                            child: Center(
                              child: Text(
                                "Total Amount",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 200,
                  width: size.width,
                  child: snapshot.data!.docs.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final currentDoc = snapshot.data!.docs[index];
                            _name = currentDoc["name"] ?? "name";
                            _amount = currentDoc["amount"] ?? 0;
                            _warrenty = currentDoc["warranty"] ?? 0;
                            _image = currentDoc["image"] ??
                                "https://cutewallpaper.org/24/invoice-clipart/983812787.jpg";
                            _date = currentDoc["user_date"] != 0
                                ? currentDoc["user_date"]
                                : currentDoc["current_date"] ?? 0;
                            _month = currentDoc["user_month"] != 0
                                ? currentDoc["user_month"]
                                : currentDoc["current_month"] ?? 0;
                            _year = currentDoc["user_year"] != 0
                                ? currentDoc["user_year"]
                                : currentDoc["current_year"] ?? 0;
                            return UserBillCard(
                              name: _name,
                              amount: _amount,
                              warrenty: _warrenty,
                              image: _image,
                              date: _date,
                              month: _month,
                              year: _year,
                            );
                          },
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: sampleBillList.length,
                          itemBuilder: (context, index) =>
                              SampleBillCard(bill: sampleBillList[index]),
                        ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

class UserBillCard extends StatelessWidget {
  // final SampleBill bill;
  final String name;
  final int amount;
  final int warrenty;
  final String image;
  final int date;
  final int month;
  final int year;
  const UserBillCard({
    Key? key,
    required this.name,
    required this.amount,
    required this.warrenty,
    required this.image,
    required this.date,
    required this.month,
    required this.year,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewBillScreen(
                name: name,
                image: image,
                amount: amount,
                warrenty: warrenty,
                date: date,
                month: month,
                year: year,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              borderRadius: BorderRadius.circular(16),
              elevation: 10,
              shadowColor: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  image,
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8, bottom: 4),
              child: SizedBox(
                width: 110,
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                width: 100,
                child: Text(
                  "Rs $amount",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SampleBillCard extends StatelessWidget {
  final SampleBill bill;
  const SampleBillCard({
    Key? key,
    required this.bill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddBillScreen()),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              borderRadius: BorderRadius.circular(16),
              elevation: 10,
              shadowColor: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  bill.image,
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8, bottom: 4),
              child: Text(
                bill.name,
                style: TextStyle(fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                bill.amount,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
