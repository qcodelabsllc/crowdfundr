import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:heroicons/heroicons.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/core/routing/router.dart';
import 'package:mobile/core/utils/constants.dart';
import 'package:mobile/core/utils/extensions.dart';
import 'package:mobile/features/crowdfundr/presentation/widgets/project.tile.dart';
import 'package:mobile/generated/assets.dart';
import 'package:mobile/generated/protos/category.pb.dart';
import 'package:mobile/generated/protos/user.pb.dart';
import 'package:shared_utils/shared_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _currentUser = User(
      avatar:
          'https://avatars.githubusercontent.com/u/117631255?s=400&u=753eb33bf8f7454a6d53e4ae6270591ba1864d7c',
      username: 'Quabynah Bilson',
      email: 'qcodelabsllc@gmail.com');
  final _sampleCategories = <Category>[
        Category(id: '1', name: 'Education'),
        Category(id: '2', name: 'Fundraising'),
        Category(id: '3', name: 'Disasters'),
        Category(id: '4', name: 'Health'),
      ],
      _icons = <IconData>[
        TablerIcons.school,
        TablerIcons.wallet,
        TablerIcons.activity_heartbeat,
        TablerIcons.heart,
      ],
      _navIcons = [
        HeroIcons.rectangleStack, // home
        HeroIcons.userGroup, // donations
        HeroIcons.rocketLaunch, // projects
        HeroIcons.userCircle, // settings
      ];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: [
            // app bar
            SliverAppBar(
              // pinned: true,
              floating: true,
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
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
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
                        _sampleCategories.length,
                        (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: context.width * 0.15,
                              width: context.width * 0.15,
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
                                  color: context.colorScheme.onPrimary).bottom(4),
                            ),
                            _sampleCategories[index]
                                .name
                                .caption(context,
                                    color: context.colorScheme.onBackground,
                                    weight: FontWeight.w600)
                                .top(8),
                          ],
                        ),
                      ),
                    ).top(12),
                  ],
                ),
              ),
            ),

            // ongoing projects
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
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
                          child: const SlideAnimation(
                            horizontalOffset: 100,
                            child: FadeInAnimation(child: ProjectTile()),
                          ),
                        ),
                        separatorBuilder: (_, __) => const SizedBox(width: 20),
                        itemCount: 5,
                      ).fillMaxHeight(context, 0.35).fillMaxWidth(context),
                    ),
                  ],
                ),
              ),
            ),

            // favorites
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
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
                        .centered().bottom(context.mediaQuery.padding.bottom),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(
              bottom: context.mediaQuery.padding.bottom + 12,
              top: 20,
              left: 12,
              right: 12),
          decoration: BoxDecoration(color: context.colorScheme.surfaceVariant),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _navIcons.map(
              (icon) {
                var index = _navIcons.indexOf(icon),
                    active = index == _currentIndex;
                return GestureDetector(
                  onTap: () => setState(() => _currentIndex = index),
                  child: HeroIcon(
                    icon,
                    color: active
                        ? context.colorScheme.onBackground
                        : context.theme.disabledColor,
                  ),
                );
              },
            ).toList(),
          ),
        ),
      );
}
