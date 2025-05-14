import 'package:flutter/material.dart';
import 'package:projects/add_item/item_model.dart';
import 'package:projects/details/details_screen/details_page.dart';
import 'package:projects/add_item/add_item_page.dart';
import 'package:provider/provider.dart';
import '../details/details_widget/favorite.dart';
import '../profile/profile_page/profile_page.dart';
import '../profile/user_model.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final imageProfile = Provider.of<UserModel>(context).user?.image;
    final items = Provider.of<ItemModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
            icon:
                imageProfile == null
                    ? const Icon(Icons.account_box)
                    : ClipOval(
                      child: Image.file(
                        imageProfile,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            items.items.isEmpty
                ? const Center(child: Text("No items yet"))
                : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: items.items.length,
                  itemBuilder: (context, index) {
                    final currentItem = items.items[index];

                    return InkWell(
                      onTap: () {
                        items.selectItem(currentItem);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailsPage(),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.file(
                              currentItem.images.first,
                              height: 125,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(currentItem.title),
                                FavoriteWidget(index: items.items.indexOf(items.items[index]),),

                                // IconButton(
                                //   onPressed: () {
                                //     Provider.of<FavoriteModel>(
                                //       context,
                                //       listen: false,
                                //     ).add(items.items[index]);
                                //
                                //     items.removeItem(index);
                                //   },
                                //   icon: const Icon(Icons.favorite),
                                //   color: Colors.red,
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddItemScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
