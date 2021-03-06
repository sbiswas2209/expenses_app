import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_calculator/model/note.dart';
import 'package:expenses_calculator/model/user.dart';
import 'package:expenses_calculator/model/userData.dart';


class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference userInstance = Firestore.instance.collection('users');

  Future setUserData(String email , String password) async {
    return await userInstance.document(uid).setData({
      'email' : email,
      'password' : password,
    });
  }

  setNotesData(String title , String content , String type , double amount , DateTime date) async {
    await Firestore.instance.collection('users/${this.uid}/notes').document().
      setData({
        'title' : title,
        'content' : content,
        'type' : type,
        'amount' : amount,
        'date' : date,
      });
  }
  

  Future<double> calculateTotal() async {
    double total = 0.0;
    List data =[0.0];
    await Firestore.instance.collection('users/${this.uid}/notes').getDocuments().then((snapshot) => snapshot.documents.forEach((element) => data.add(element.data['amount'])));
    int i=0;
    for(i=0;i<data.length;i++){
      total += data[i];
    }
    return total;
  }

  Future<double> calculateCategoryTotal(String type) async {
    double total = 0.0;
    List data =[0.0];
    await Firestore.instance.collection('users/${this.uid}/notes')
    .where('type' , isEqualTo:type)
    .getDocuments().then((snapshot) => snapshot.documents.forEach((element) => data.add(element.data['amount'])));
    int i=0;
    for(i=0;i<data.length;i++){
      total += data[i];
    }
    return total;
  }

  Future<double> filterMonths(DateTime start , DateTime end) async {
    double total = 0.0;
    List data = [0.0];
    await Firestore.instance.collection('users/${this.uid}/notes')
    .where('date', isLessThan: end)
    .where('date', isGreaterThan:start)
    .getDocuments().then(
      (snapshot) => snapshot.documents.forEach((element) => data.add(element.data['amount'])));
      int i=0;
      for(i=0;i<data.length;i++){
        total += data[i];
      }
      return total;
  }

  Future deleteNote(DocumentSnapshot data) async {
    await Firestore.instance.collection('users/${this.uid}/notes').document(data.documentID).delete().then((value) => print('Deleted ${this.uid}'));
  }

  Future<double> filterCategoryMonths(DateTime start , DateTime end , String type) async {
    double total = 0.0;
    List data = [0.0];
    try{
      await Firestore.instance.collection('users')
      .document('${this.uid}')
      .collection('notes')
    .where('date', isLessThan: end)
    .where('date', isGreaterThan: start)
    .where('type', isEqualTo: '$type')
    .getDocuments().then(
      (snapshot) => snapshot.documents.forEach((element) => data.add(element.data['amount'])));
      int i=0;
      for(i=0;i<data.length;i++){
        total += data[i];
      }
    }
    catch(e){
      return 0.0;
    }
      return total;
  }

  List<Notes> _notesListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
      return Notes(
        title: doc.data['title'] ?? '',
        content: doc.data['content'] ?? '',
        type: doc.data['type'] ?? '',
        ammount: doc.data['ammount'] ?? 0.0,
      );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      email: snapshot.data['email'],
      password: snapshot.data['password'],
    );
  }

  Stream<List<Notes>> get notes {
    final CollectionReference notesInstance = Firestore.instance.collection('users/${this.uid}');
    return notesInstance.snapshots()
      .map(_notesListFromSnapshot);
  }

  Stream<UserData> get userData {
    return userInstance.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }



}