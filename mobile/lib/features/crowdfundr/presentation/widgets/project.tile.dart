import 'package:flutter/material.dart';
import 'package:mobile/core/routing/router.dart';
import 'package:mobile/core/utils/extensions.dart';
import 'package:mobile/generated/protos/project.pb.dart';
import 'package:shared_utils/shared_utils.dart';

/// Project tile widget
/// @todo: pass project data to widget
class ProjectTile extends StatefulWidget {
  final Project project;

  const ProjectTile({super.key, required this.project});

  @override
  State<ProjectTile> createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {
  String get _displayPercentage =>
      '${(_calculateProgress * 100).toStringAsFixed(2)}%';

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => context.navigator.pushNamed(AppRouter.projectDetailsRoute,
            arguments: widget.project),
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
                height: context.height * 0.34,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: context.colorScheme.onPrimary,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child:
                    widget.project.imageUrl.asNetworkImage(fit: BoxFit.cover),
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
                height: context.height * 0.25,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: context.colorScheme.onPrimary),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      context.localizer
                          .projectBy(widget.project.projectOwner.username)
                          .caption(context,
                              color: context.colorScheme.primary,
                              weight: FontWeight.w600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              emphasis: kEmphasisMedium),
                      widget.project.title
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
                                value: _calculateProgress,
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
                                '\$${widget.project.amountRaised} ($_displayPercentage)'
                                    .subtitle2(context,
                                        weight: FontWeight.w600,
                                        color: context.colorScheme.primary),
                                '21 days left'.subtitle2(context,
                                    color: context.colorScheme.primary),
                              ],
                            ).top(8),
                            GestureDetector(
                              onTap: () => context.navigator.pushNamed(
                                  AppRouter.donateRoute,
                                  arguments: widget.project),
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
                ).fillMaxHeight(context, 0.18),
              ),
            ],
          ),
        ),
      );

  /// Calculate project progress
  double get _calculateProgress =>
      widget.project.amountRaised / widget.project.goalAmount;
}
