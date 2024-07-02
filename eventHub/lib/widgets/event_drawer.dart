import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/login_screen.dart';
import 'user_provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final isAdmin = userProvider.role == 'admin';

    return Drawer(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.8)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.event,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Text(
                    'Events On!',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.event_available_outlined,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Events',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 24,
                    ),
              ),
              onTap: () {
                onSelectScreen('events');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Filters',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 24,
                    ),
              ),
              onTap: () {
                onSelectScreen('filter');
              },
            ),
            if (isAdmin)
              ListTile(
                leading: Icon(
                  Icons.add,
                  size: 26,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                title: Text(
                  'Add Event',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 24,
                      ),
                ),
                onTap: () {
                  onSelectScreen('addEvent');
                },
              ),
            if (isAdmin)
              ListTile(
                leading: Icon(
                  Icons.update,
                  size: 26,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                title: Text(
                  'Update Event',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 24,
                      ),
                ),
                onTap: () {
                  onSelectScreen('updateEvent');
                },
              ),
            if (isAdmin)
              ListTile(
                leading: Icon(
                  Icons.delete,
                  size: 26,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                title: Text(
                  'Delete Event',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 24,
                      ),
                ),
                onTap: () {
                  onSelectScreen('deleteEvent');
                },
              ),
            ListTile(
              leading: Icon(
                Icons.logout,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Logout',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 24,
                    ),
              ),
              onTap: () async {
                await userProvider.clearUserIdAndRole();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}








// import 'package:flutter/material.dart';

// class MainDrawer extends StatelessWidget {
//   const MainDrawer({super.key, required this.onSelectScreen});

//   final void Function(String identifier) onSelectScreen;

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           children: [
//             DrawerHeader(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Theme.of(context).colorScheme.primaryContainer,
//                     Theme.of(context)
//                         .colorScheme
//                         .primaryContainer
//                         .withOpacity(0.8)
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.event,
//                     size: 48,
//                     color: Theme.of(context).colorScheme.primary,
//                   ),
//                   const SizedBox(
//                     width: 18,
//                   ),
//                   Text(
//                     'Events On!',
//                     style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                           color: Theme.of(context).colorScheme.primary,
//                         ),
//                   )
//                 ],
//               ),
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.event_available_outlined,
//                 size: 26,
//                 color: Theme.of(context).colorScheme.onBackground,
//               ),
//               title: Text(
//                 'Events',
//                 style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                       color: Theme.of(context).colorScheme.onBackground,
//                       fontSize: 24,
//                     ),
//               ),
//               onTap: (){
//                 onSelectScreen('events');
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.settings,
//                 size: 26,
//                 color: Theme.of(context).colorScheme.onBackground,
//               ),
//               title: Text(
//                 'Filters',
//                 style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                       color: Theme.of(context).colorScheme.onBackground,
//                       fontSize: 24,
//                     ),
//               ),
//               onTap: (){
//                 onSelectScreen('filter');
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.add,
//                 size: 26,
//                 color: Theme.of(context).colorScheme.onBackground,
//               ),
//               title: Text(
//                 'Add Event',
//                 style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                       color: Theme.of(context).colorScheme.onBackground,
//                       fontSize: 24,
//                     ),
//               ),
//               onTap: () {
//                 onSelectScreen('addEvent');
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.update,
//                 size: 26,
//                 color: Theme.of(context).colorScheme.onBackground,
//               ),
//               title: Text(
//                 'Update Event',
//                 style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                       color: Theme.of(context).colorScheme.onBackground,
//                       fontSize: 24,
//                     ),
//               ),
//               onTap: () {
//                 onSelectScreen('updateEvent');
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.delete,
//                 size: 26,
//                 color: Theme.of(context).colorScheme.onBackground,
//               ),
//               title: Text(
//                 'Delete Event',
//                 style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                       color: Theme.of(context).colorScheme.onBackground,
//                       fontSize: 24,
//                     ),
//               ),
//               onTap: () {
//                 onSelectScreen('deleteEvent');
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


