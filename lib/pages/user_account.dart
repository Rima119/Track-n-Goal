import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:trackn_goal/pages/user_model.dart';
import 'package:sqflite/sqflite.dart';


class ProfileScreen extends StatelessWidget {
  // const ProfileScreen(Key? key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const user = UserPreferences.currentUser;
    const g_num = 0;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(CupertinoIcons.moon_stars),
        //     color: Colors.black,
        //   )
        // ]
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 35),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 20),
          buildName(user),
          const SizedBox(height: 35),
          const Text(
            '  Current Goal(s)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          // const SizedBox(height: 15),
          const Text(
            '     $g_num',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 40, color: Colors.blue),
          ),
          const SizedBox(height: 15),
          const Text(
            '  Imminent Reminders',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          // TODO
        ],
      ),
    );
  }
}

Widget buildName(User user) => Column(
      children: [
        Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key key,
    @required this.imagePath,
    @required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
        child: Stack(children: [
      buildImage(),
      Positioned(bottom: 0, right: 4, child: buildEditIcon(color))
    ]));
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
        child: Material(
            color: Colors.transparent,
            child: Ink.image(
              image: image,
              fit: BoxFit.cover,
              width: 128,
              height: 128,
              child: InkWell(onTap: onClicked),
            )));
  }

  Widget buildEditIcon(Color color) => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
          color: color,
          all: 8,
          child: const Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          )));

  Widget buildCircle(
          {@required Widget child, @required double all, @required Color color}) =>
      ClipOval(
          child: Container(
              padding: EdgeInsets.all(all), color: color, child: child));
}

// int? retrieveGoalsNumber() {
//   Database database = openDatabase(
//     'goals.db',
//     onCreate: (db, version) {
//       return db.execute(
//         'CREATE TABLE goals(id VARCHAR PRIMARY KEY, title TEXT, description TEXT)',
//       );
//     },
//     version: 1,
//   );

//   int count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM goals'));
//   return count;
// }

// Future<int> getCount() async {
//   //database connection
//   Database db = await this.database;
//   var x = await db.rawQuery('SELECT COUNT (*) from goals');
//   int count = Sqflite.firstIntValue(x);
//   return count;
// }
