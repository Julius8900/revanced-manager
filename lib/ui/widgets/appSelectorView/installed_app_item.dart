import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:revanced_manager/ui/widgets/shared/custom_card.dart';

class InstalledAppItem extends StatefulWidget {
  const InstalledAppItem({
    Key? key,
    required this.name,
    required this.pkgName,
    required this.icon,
    required this.patchesCount,
    required this.suggestedVersion,
    required this.installedVersion,
    this.onTap,
  }) : super(key: key);
  final String name;
  final String pkgName;
  final Uint8List icon;
  final int patchesCount;
  final String suggestedVersion;
  final String installedVersion;
  final Function()? onTap;

  @override
  State<InstalledAppItem> createState() => _InstalledAppItemState();
}

class _InstalledAppItemState extends State<InstalledAppItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: CustomCard(
        onTap: widget.onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.memory(widget.icon),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.name,
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(widget.pkgName),
                  I18nText(
                    FlutterI18n.translate(
                      context,
                      'installed',
                      translationParams: {
                        'version': 'v${widget.installedVersion}'
                      },
                    ),
                  ),
                  Row(
                    children: [
                      I18nText(
                        'suggested',
                        translationParams: {
                          'version': widget.suggestedVersion.isEmpty
                              ? FlutterI18n.translate(
                                  context,
                                  'appSelectorCard.allVersions',
                                )
                              : 'v${widget.suggestedVersion}',
                        },
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.patchesCount == 1
                            ? '• ${widget.patchesCount} patch'
                            : '• ${widget.patchesCount} patches',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
