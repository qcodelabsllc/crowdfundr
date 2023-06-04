part of '../home.dart';

class _ProjectsTab extends StatefulWidget {
  const _ProjectsTab();

  @override
  State<_ProjectsTab> createState() => _ProjectsTabState();
}

class _ProjectsTabState extends State<_ProjectsTab> {
  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverAppBar(
        floating: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        automaticallyImplyLeading: false,
        collapsedHeight: context.height * 0.18,
        expandedHeight: context.height * 0.2,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: context.colorScheme.primary
                  .generateColorShades(context.isDarkMode ? 5 : 2),
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.fromLTRB(
              20, context.mediaQuery.padding.top + 12, 20, 24),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            ],
          ),
        ),
      ),
    ],
  );
}
