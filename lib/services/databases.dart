// ignore_for_file: use_rethrow_when_possible

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facelift_constructions/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/models.dart';

class DatabaseService {
  final CollectionReference userCol =
      FirebaseFirestore.instance.collection('userData');

  final DocumentReference userData = FirebaseFirestore.instance
      .collection('userData')
      .doc(number)
      .collection('Usr')
      .doc('userData');

  final DocumentReference userPremiumDoc = FirebaseFirestore.instance
      .collection('userData')
      .doc(number)
      .collection('Usr')
      .doc('premiumForm');

  final CollectionReference userHousePlan = FirebaseFirestore.instance
      .collection('userData')
      .doc(number)
      .collection('housePlan');

  final CollectionReference userLaborer = FirebaseFirestore.instance
      .collection('userData')
      .doc(number)
      .collection('laborer');

  final CollectionReference userHousebill = FirebaseFirestore.instance
      .collection('userData')
      .doc(number)
      .collection('houseBills');

  final DocumentReference userHousebillAmount = FirebaseFirestore.instance
      .collection('userData')
      .doc(number)
      .collection('Usr')
      .doc('amount');

  final DocumentReference userProfileDoc = FirebaseFirestore.instance
      .collection('userData')
      .doc(number)
      .collection('Usr')
      .doc('profilePic');

  final DocumentReference userSiteSuperviserDoc = FirebaseFirestore.instance
      .collection('userData')
      .doc(number)
      .collection('Usr')
      .doc('supervisor');

  final DocumentReference userSiteProgressDoc = FirebaseFirestore.instance
      .collection('userData')
      .doc(number)
      .collection('Usr')
      .doc('progress');

  final DocumentReference userRequestsLabor =
      FirebaseFirestore.instance.collection('RequestsLabor').doc(number);

  final DocumentReference userRequestForSuperDoc =
      FirebaseFirestore.instance.collection('RequestsSupervisor').doc(number);

  final DocumentReference userRequestForRoomDoc =
      FirebaseFirestore.instance.collection('RequestsRooms').doc(number);

  final DocumentReference userRequestForToolsDoc =
      FirebaseFirestore.instance.collection('RequestsTools').doc(number);

  final DocumentReference userRequestForRawMatDoc =
      FirebaseFirestore.instance.collection('RequestsRawMaterials').doc(number);

  final DocumentReference userComplaintsDoc =
      FirebaseFirestore.instance.collection('Complaints').doc();

  final DocumentReference userRequestsDoc =
      FirebaseFirestore.instance.collection('Requests').doc();

  //-----------------------------------------------------------------------------------------

  Future<void> deleteUser() async {
    try {
      await userPremiumDoc.delete();
      await userSiteProgressDoc.delete();
      await userProfileDoc.delete();
      await userSiteSuperviserDoc.delete();
    } catch (e) {}
    return await userCol.doc(number).delete();
  }

  Future<bool> checkUser() async {
    try {
      var d = await userCol.doc(number).get();
      return d.exists;
    } catch (e) {
      throw e;
    }
  }

  Future<void> createRequest(String type, String name) async {
    String createdDate = DateTime.now().day.toString();
    String createdTime = DateTime.now().millisecondsSinceEpoch.toString();
    return await userRequestsDoc.set({
      "user_number": number,
      "site_name": premiumName,
      "type": type,
      "get": name,
      "created_date": createdDate,
      "time": createdTime,
    });
  }

  Future<void> updateUserData() async {
    bool exist = await checkUser();
    if (exist) {
      return await userCol.doc(number).update({"phone": number});
    } else {
      return await userCol
          .doc(number)
          .set({"name": "new User", "phone": number});
    }
  }

  Future<void> updateUserProfil(
      String? name, String? email, String? city, String? state) async {
    return await userCol.doc(number).update({
      "name": name,
      "email": email,
      "city": city,
      "state": state,
    });
  }

  Future<void> updateUserPremium(bool val) async {
    return await userCol.doc(number).update({"premium": val});
  }

  Future<void> updateUserPremiumData(String name, int len, int bre, int area,
      String valueChose, String city, String state) async {
    return await userPremiumDoc.set({
      "name": name,
      "front": len,
      "back": bre,
      "type": valueChose,
      "area": area,
      "city": city,
      "state": state,
    });
  }

  Future<void> updateUserProgress() async {
    return await userSiteProgressDoc.set({
      "percentage": "7",
      "value": 0.07,
      "value1": 3,
      "value2": 2,
      "value3": 1,
      "value4": 1,
      "value5": 1,
      "value6": 1,
      "value7": 1,
      "value8": 1,
    });
  }

  Future<void> updateUserHousePlan(String? val, String? url) async {
    return await userHousePlan.doc().set({"name": val, "image": url});
  }

  Future<void> updateUserHouseBill(
    String? name,
    int? amount,
    int? warranty,
    String? url,
    int cDate,
    int cMonth,
    int cYear,
    int uDate,
    int uMonth,
    int uYear,
  ) async {
    return await userHousebill.doc().set({
      "name": name,
      "amount": amount,
      "warranty": warranty,
      "image": url,
      "current_date": cDate,
      "current_month": cMonth,
      "current_year": cYear,
      "user_date": uDate,
      "user_month": uMonth,
      "user_year": uYear,
    });
  }

  Future<void> updateUserHouseBillAmount(int? amount) async {
    return await userHousebillAmount.set({"total": amount});
  }

  Future<void> updateUserProfilePic(String? val) async {
    return await userProfileDoc.set({"url": val});
  }

  // Future<void> updateUserRequestSuper(int? time, bool b, bool change) async {
  //   bool exist = await checkSuperviser();
  //   if (exist) {
  //     return await userRequestForSuperDoc
  //         .update({"time": time, "change": change});
  //   } else {
  //     return await userRequestForSuperDoc
  //         .set({"request": b, "time": time, "change": change});
  //   }
  // }

  // Future<void> updateUserRequestLabor(int? time, bool b, String name) async {
  //   bool exist = await checkRequests();
  //   if (exist) {
  //     return await userRequestsLabor.update({"time": time, name: true});
  //   } else {
  //     return await userRequestsLabor
  //         .set({"request": b, "time": time, name: true});
  //   }
  // }

  // Future<void> updateUserRequestRoom(int? time, bool b, String name) async {
  //   bool exist = await checkRoomsReq();
  //   if (exist) {
  //     return await userRequestForRoomDoc.update({"time": time, name: true});
  //   } else {
  //     return await userRequestForRoomDoc
  //         .set({"request": b, "time": time, name: true});
  //   }
  // }

  // Future<void> updateUserRequestTools(int? time, bool b, String name) async {
  //   bool exist = await checkToolsReq();
  //   if (exist) {
  //     return await userRequestForToolsDoc.update({"time": time, name: true});
  //   } else {
  //     return await userRequestForToolsDoc
  //         .set({"request": b, "time": time, name: true});
  //   }
  // }

  // Future<void> updateUserRequestRawMaterial(
  //     int? time, bool b, String name) async {
  //   bool exist = await checkRawMatReq();
  //   if (exist) {
  //     return await userRequestForRawMatDoc.update({"time": time, name: true});
  //   } else {
  //     return await userRequestForRawMatDoc
  //         .set({"request": b, "time": time, name: true});
  //   }
  // }

  Future<void> updateUserComplaint(
      int? time, bool b, String name, String skill, String reason) async {
    return await userComplaintsDoc.set({
      "user_number": number,
      "site_name": premiumName,
      "name": name,
      "skill": skill,
      "reason": reason,
      "time": time,
    });
    // bool exist = await checkComplaints();
    // if (exist) {
    //   return await userComplaintsDoc.update({
    //     "time": time,
    //     "${name}_$skill": reason,
    //   });
    // } else {
    //   return await userComplaintsDoc.set({
    //     "request": b,
    //     "time": time,
    //     "${name}_$skill": reason,
    //   });
    // }
  }

  //--------------------------------------------------------------------------------------------

  PremiumDataModel _premiumDataFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> dat = snapshot.data() as Map<String, dynamic>;
    return PremiumDataModel(
      houseName: dat["name"] ?? "House Name",
      length: dat["front"] ?? 0,
      bredth: dat["back"] ?? 0,
      type: dat["type"] ?? "Select",
      area: dat["area"] ?? 0,
      city: dat["city"] ?? "City",
      state: dat["state"] ?? "State",
    );
  }

  Uuser _userDataFromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> dat = snap.data() as Map<String, dynamic>;
    return Uuser(
        name: dat["name"] ?? "new user",
        phone: dat["phone"] ?? number,
        email: dat["email"] ?? "",
        city: dat["city"] ?? "",
        state: dat["state"] ?? "");
  }

  UserPremiumBool _userPremiumBoolDataFromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> dat = snap.data() as Map<String, dynamic>;
    return UserPremiumBool(premium: dat["premium"] ?? false);
  }

  UserProfilePicModel _userProfilePicFromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> dat = snap.data() as Map<String, dynamic>;
    return UserProfilePicModel(url: dat["url"] ?? "");
  }

  SuperviserModel _userSuperviseFromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> dat = snap.data() as Map<String, dynamic>;
    return SuperviserModel(
        name: dat["name"] ?? "name",
        age: dat["age"] ?? "age",
        image: dat["image"] ??
            "https://cdn.searchenginejournal.com/wp-content/uploads/2019/08/c573bf41-6a7c-4927-845c-4ca0260aad6b-760x400.jpeg");
  }

  UserProgressModel _userProgressFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> dat = snapshot.data() as Map<String, dynamic>;
    return UserProgressModel(
      percentage: dat["percentage"] ?? "0",
      overAllvalue: dat["value"] ?? 0.00,
      value1: dat["value1"] ?? 0,
      value2: dat["value2"] ?? 0,
      value3: dat["value3"] ?? 0,
      value4: dat["value4"] ?? 0,
      value5: dat["value5"] ?? 0,
      value6: dat["value6"] ?? 0,
      value7: dat["value7"] ?? 0,
      value8: dat["value8"] ?? 0,
    );
  }

  UserAmountModel _userAmountFromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> dat = snap.data() as Map<String, dynamic>;
    return UserAmountModel(total: dat["total"] ?? 0);
  }

  //-------------------------------------------------------------------------------------

  Stream<Uuser> get userDataStream {
    return userCol.doc(number).snapshots().map(_userDataFromSnapshot);
  }

  Stream<UserPremiumBool> get userPremiumBoolStream {
    return userCol
        .doc(number)
        .snapshots()
        .map(_userPremiumBoolDataFromSnapshot);
  }

  Stream<PremiumDataModel> get userPrmiumDataStream {
    return userPremiumDoc.snapshots().map(_premiumDataFromSnapshot);
  }

  Stream<UserProfilePicModel> get userProfilePicStream {
    return userProfileDoc.snapshots().map(_userProfilePicFromSnapshot);
  }

  Stream<SuperviserModel> get userSuperviserStream {
    return userSiteSuperviserDoc.snapshots().map(_userSuperviseFromSnapshot);
  }

  Stream<UserAmountModel> get userAmountStream {
    return userHousebillAmount.snapshots().map(_userAmountFromSnapshot);
  }

  Stream<UserProgressModel> get userProgressStream {
    return userSiteProgressDoc.snapshots().map(_userProgressFromSnapshot);
  }
}
