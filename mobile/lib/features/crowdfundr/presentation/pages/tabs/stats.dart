part of '../home.dart';

class _StatsTab extends StatefulWidget {
  const _StatsTab();

  @override
  State<_StatsTab> createState() => _StatsTabState();
}

class _StatsTabState extends State<_StatsTab> {
  final _currentUser = User(
      avatar:
          'https://avatars.githubusercontent.com/u/117631255?s=400&u=753eb33bf8f7454a6d53e4ae6270591ba1864d7c',
      username: 'Quabynah Bilson',
      email: 'qcodelabsllc@gmail.com');
  var _isScrolling = false;

  @override
  Widget build(BuildContext context) =>
      NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          setState(() => _isScrolling = notification.metrics.pixels > 0);
          return true;
        },
        child: CustomScrollView(
          slivers: [
            // app bar
            SliverAppBar(
              floating: false,
              systemOverlayStyle: _isScrolling
                  ? SystemUiOverlayStyle.dark
                  : SystemUiOverlayStyle.light,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // user account info and notifications bell
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: AnimatedRow(
                            animateType: AnimateType.slideRight,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // @todo: replace with user's avatar
                              _currentUser.avatar
                                  .avatar(size: 40, circular: true),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  context.localizer.welcomeBackUser.subtitle2(
                                      context,
                                      color: context.colorScheme.onPrimary,
                                      emphasis: kEmphasisMedium),
                                  // @todo: replace with user's name
                                  _currentUser.username.subtitle1(context,
                                      color: context.colorScheme.onPrimary),
                                ],
                              ).left(16),
                            ],
                          ),
                        ),

                        // notifications
                        GestureDetector(
                          onTap: () => context.navigator
                              .pushNamed(AppRouter.notificationsRoute),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(left: 16),
                            decoration: BoxDecoration(
                              color: context.colorScheme.onPrimary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: context.colorScheme.secondary),
                            ),
                            alignment: Alignment.center,
                            child: Icon(TablerIcons.notification,
                                    color: context.colorScheme.primary)
                                .bottom(4),
                          ),
                        ),
                      ],
                    ),

                    // search bar
                    GestureDetector(
                      // @todo: replace with search feature
                      onTap: context.showFeatureUnderDevSheet,
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                              color: context.colorScheme.onPrimary, width: 1.5),
                          color: context.colorScheme.onPrimary
                              .withOpacity(kEmphasisLow),
                        ),
                        child: context.localizer.searchHint.subtitle1(context,
                            color: context.colorScheme.onPrimary),
                      ).fillMaxWidth(context),
                    ),
                  ],
                ),
              ),
            ),

            // categories
            SliverPersistentHeader(
                floating: true,
                pinned: true,
                delegate: CategoryPersistentHeader(context)),

            // ongoing projects
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  context.localizer.ongoingProjects
                      .subtitle1(context, weight: FontWeight.w600)
                      .horizontal(20)
                      .bottom(16),
                  AnimationLimiter(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          AnimationConfiguration.staggeredList(
                        position: index,
                        duration: kDurationFast,
                        delay: kDurationSlow,
                        child: SlideAnimation(
                          horizontalOffset: 100,
                          child: FadeInAnimation(
                            child: ProjectTile(project: kSampleProjects[index]),
                          ),
                        ),
                      ),
                      separatorBuilder: (_, __) => const SizedBox(width: 20),
                      // @todo replace with actual projects
                      itemCount: kSampleProjects.length,
                    ).fillMaxHeight(context, 0.35).fillMaxWidth(context),
                  ),
                ],
              ),
            ),

            // favorites
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 20, bottom: context.mediaQuery.padding.bottom + 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    context.localizer.favorites
                        .subtitle1(context, weight: FontWeight.w600)
                        .horizontal(20),
                    context.localizer.favoritesSubhead
                        .subtitle2(context, emphasis: kEmphasisMedium)
                        .horizontal(20),
                    Lottie.asset(Assets.animNothingFound,
                            width: context.width * 0.3)
                        .centered(),
                    const SizedBox(height: 20),
                    context.localizer.nothingToShow
                        .subtitle1(context)
                        .centered(),
                    context.localizer.nothingToShowSubhead
                        .subtitle2(context, emphasis: kEmphasisMedium)
                        .centered()
                        .bottom(context.mediaQuery.padding.bottom),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

/// Sliver persistent header delegate for the categories tab
class CategoryPersistentHeader extends SliverPersistentHeaderDelegate {
  CategoryPersistentHeader(this.ctx);

  final BuildContext ctx;
  final _icons = <IconData>[
    Icons.supervised_user_circle_outlined,
    TablerIcons.wallet,
    TablerIcons.users,
    TablerIcons.heart,
  ];

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      AnimatedContainer(
        duration: kDurationFast,
        padding: EdgeInsets.only(
            top: shrinkOffset > 0 ? context.mediaQuery.padding.top : 20),
        color: context.colorScheme.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.localizer.categories
                .subtitle1(context, weight: FontWeight.w600)
                .horizontal(20),
            context.localizer.categoriesSubhead
                .subtitle2(context, emphasis: kEmphasisMedium)
                .horizontal(20),

            // @todo: replace with categories from server
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                kSampleCategories.length,
                (index) => GestureDetector(
                  onTap: () => context.navigator.pushNamed(
                      AppRouter.categoryDetailsRoute,
                      arguments: kSampleCategories[index]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: context.width * 0.1,
                        width: context.width * 0.1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: context.colorScheme.primary
                                .generateColorShades(2),
                            begin: Alignment.topLeft,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        alignment: Alignment.center,
                        child: Icon(_icons[index],
                                color: context.colorScheme.onPrimary)
                            .bottom(4),
                      ),
                      kSampleCategories[index]
                          .name
                          .caption(context,
                              color: context.colorScheme.onBackground,
                              weight: FontWeight.w600)
                          .top(8),
                    ],
                  ),
                ),
              ),
            ).top(12),
          ],
        ),
      );

  @override
  double get maxExtent => ctx.height * 0.21;

  @override
  double get minExtent => ctx.height * 0.21;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
