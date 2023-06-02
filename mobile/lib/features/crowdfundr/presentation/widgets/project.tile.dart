import 'package:flutter/material.dart';
import 'package:mobile/core/routing/router.dart';
import 'package:mobile/core/utils/extensions.dart';
import 'package:shared_utils/shared_utils.dart';

/// Project tile widget
/// @todo: pass project data to widget
class ProjectTile extends StatefulWidget {
  const ProjectTile({super.key});

  @override
  State<ProjectTile> createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        // @todo: replace with project data
        onTap: () => context.navigator
            .pushNamed(AppRouter.projectDetailsRoute, arguments: 'project id'),
        child: Container(
          width: context.width * 0.75,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // image background
              Container(
                width: context.width,
                height: context.height * 0.28,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: context.colorScheme.onPrimary,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                // @todo: replace with project image
                child: 'https://picsum.photos/200/300'
                    .asNetworkImage(fit: BoxFit.cover),
              ),

              // project details
              Positioned(
                bottom: 0,
                left: 24,
                right: 24,
                height: context.height * 0.22,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: context.colorScheme.primary
                          .withOpacity(kEmphasisLow)),
                ).fillMaxHeight(context, 0.15),
              ),
              Positioned(
                bottom: 8,
                left: 12,
                right: 12,
                height: context.height * 0.22,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: context.colorScheme.onPrimary),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // @todo: replace with project owner's name
                      context.localizer
                          .projectBy('Quabynah Charity Fund')
                          .caption(context,
                              color: context.colorScheme.primary,
                              weight: FontWeight.w600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              emphasis: kEmphasisMedium),
                      // @todo: replace with project name
                      'Urgent need of funds for the construction of a new mosque in Accra Central'
                          .capitalize()
                          .subtitle2(context,
                              weight: FontWeight.w600,
                              maxLines: 2,
                              color: context.colorScheme.primary,
                              overflow: TextOverflow.ellipsis)
                          .top(4)
                          .bottom(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: LinearProgressIndicator(
                                // @todo: replace with project progress
                                value: 0.67,
                                minHeight: 8,
                                backgroundColor: context.colorScheme.primary
                                    .withOpacity(kEmphasisLow),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    context.colorScheme.primary),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // @todo: replace with project amount contributed
                                '\$ 12,450'.subtitle2(context,
                                    weight: FontWeight.w600,
                                    color: context.colorScheme.primary),
                                '21 days left'.subtitle2(context,
                                    color: context.colorScheme.primary),
                              ],
                            ).top(8),
                            GestureDetector(
                              // @todo: replace with project data
                              onTap: () => context.navigator.pushNamed(
                                  AppRouter.donateRoute,
                                  arguments: 'project id'),
                              child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(16, 12, 16, 0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: context.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                alignment: Alignment.center,
                                child: context.localizer.donate.button(context,
                                    color: context.colorScheme.onPrimary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ).fillMaxHeight(context, 0.15),
              ),
            ],
          ),
        ),
      );
}
