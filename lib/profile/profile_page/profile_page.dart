import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projects/profile/user_model.dart';
import 'package:provider/provider.dart';
import '../profile_widget/options.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _showImagePickerOptions(UserModel userModel) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 150,
        child: Column(
          children: [
            const Text("Profile", style: TextStyle(fontSize: 18)),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Options(
                  onPressed: () {
                    Navigator.pop(context);
                    userModel.imageSelector(ImageSource.camera);
                  },
                  title: "Camera",
                  icon: Icons.camera_alt,
                ),
                Options(
                  onPressed: () {
                    Navigator.pop(context);
                    userModel.imageSelector(ImageSource.gallery);
                  },
                  title: "Gallery",
                  icon: Icons.image,
                ),
                if (userModel.user?.image != null)
                  Options(
                    onPressed: () {
                      if (mounted) {
                        setState(() {
                          userModel.user?.image = null;
                          userModel.notifyListeners();
                        });
                      }
                    },
                    title: "Delete",
                    icon: Icons.delete,
                    color: Colors.red,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Consumer<UserModel>(
        builder: (context, userModel, child) {
          return Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: userModel.user?.image != null
                          ? FileImage(userModel.user!.image!)
                          : null,
                      child: userModel.user?.image == null
                          ? const Icon(
                        Icons.person,
                        size: 70,
                        color: Colors.white38,
                      )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 20,
                        child: IconButton(
                          onPressed: () => _showImagePickerOptions(userModel),
                          icon: const Icon(Icons.camera_alt, size: 18),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Name"),
                  subtitle: Text("Hassan Fathy Ali"),
                ),
                const ListTile(
                  leading: Icon(Icons.info),
                  title: Text("Bio"),
                  subtitle: Text("Code. Zamalek. Eat. Learn"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
