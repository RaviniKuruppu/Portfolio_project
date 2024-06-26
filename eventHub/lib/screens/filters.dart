import 'package:flutter/material.dart';

//import '../widgets/event_drawer.dart';
//import 'tabs.dart';

enum Filter {
  academic,
  extracurricular,
  careerDevelopment,
  social,
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.currentFilter});

  final Map<Filter,bool> currentFilter;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _academicFilterSet = false;
  var _extracurricularFilterSet = false;
  var _careerDevelopmentFilterSet = false;
  var _socialFilterSet = false;

  @override
  void initState() {
    _academicFilterSet = widget.currentFilter[Filter.academic]!;
    _extracurricularFilterSet = widget.currentFilter[Filter.extracurricular]!;
    _careerDevelopmentFilterSet = widget.currentFilter[Filter.careerDevelopment]!;
    _socialFilterSet = widget.currentFilter[Filter.social]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filter'),
      ),
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'events') {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (ctx) => const TabsScreen(),
      //       ),
      //     );
      //   }
      // }),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.academic: _academicFilterSet,
            Filter.extracurricular: _extracurricularFilterSet,
            Filter.careerDevelopment: _careerDevelopmentFilterSet,
            Filter.social: _socialFilterSet,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _academicFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _academicFilterSet = isChecked;
                });
              },
              title: Text(
                'Academic Events',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include Academic Events.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _extracurricularFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _extracurricularFilterSet = isChecked;
                });
              },
              title: Text(
                'Extracurricular Events',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include Extracurricular Events.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _careerDevelopmentFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _careerDevelopmentFilterSet = isChecked;
                });
              },
              title: Text(
                'Career Development Events',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include Career Development Events.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _socialFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _socialFilterSet = isChecked;
                });
              },
              title: Text(
                'Social Events',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include Social Events.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
