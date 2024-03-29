import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:talkify_chat_application/src/features/authentication/models/user_model.dart';
import 'package:talkify_chat_application/src/repository/UserRepository/user_repository.dart';
import 'package:talkify_chat_application/src/utils/popups/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  //save user record from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      await fetchUserRecord();

      if (user.value.id!.isEmpty) {
        if (userCredentials != null) {
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName);

          String firstName = nameParts[0].toLowerCase();
          String lastName =
              nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

          final user = UserModel(
            id: userCredentials.user!.uid,
            fullname: "$firstName$lastName",
            email: userCredentials.user!.email ?? '',
            phoneNo: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          //save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      Tloaders.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your informtion.You can re-save your data in your Profile.');
    }
  }
}
