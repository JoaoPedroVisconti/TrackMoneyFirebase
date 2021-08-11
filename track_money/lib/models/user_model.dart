class UserModel {
  final String uid;

  UserModel({required this.uid});

  factory UserModel.initialData() {
    return UserModel(
      uid: '',
    );
  }
}
