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
      'total' : 0.0,
      'Food' : 0.0,
      'Stationery' : 0.0,
      'Office' : 0.0,
      'Conveyance' : 0.0,
      'Entertainment' : 0.0,
      'Shopping' : 0.0,
      'Household' : 0.0,
      'Telephone' : 0.0,
      'Rent' : 0.0,
      'Transport' : 0.0,
      'Personal' : 0.0,
      'Beauty' : 0.0,
      'Educational' : 0.0,
      'Miscellaneous' : 0.0,

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

  increaseTotal(double oldAmount , double newAmount , String oldType , String newType) async {
    await Firestore.instance.collection('users').
    document('${this.uid}').
    updateData({
      'total' : FieldValue.increment(newAmount - oldAmount),
      '$oldType' : FieldValue.increment(-oldAmount),
      '$newType' : FieldValue.increment(newAmount),

    });
  }

  changeTotal(double amount , String type) async {
    await Firestore.instance.collection('users')
    .document('${this.uid}')
    .updateData({
      'total' : FieldValue.increment(amount),
      '$type' : FieldValue.increment(amount),
    });
  }

  decreaseTotal(double oldAmount , double newAmount , String oldType , String newType) async {
    await Firestore.instance.collection('users').
    document('${this.uid}').
    updateData({
      'total' : FieldValue.increment(newAmount - oldAmount),
      '$oldType' : FieldValue.increment(-oldAmount),
      '$newType' : FieldValue.increment(newAmount),
    });
  }
   _calculateSum(var amounts){
    int i = 0;
    double total = 0.0;
    for(i=0;i<amounts.length;i++){
      total += amounts[i];
    }
    print(total);
    return total;
  }

  calculateTotal(){
    double total;
    Firestore.instance.collection('users/${this.uid}/notes').getDocuments().then((snapshot) => snapshot.documents.forEach((element) => total += element.data['amount']));
    print(total);
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