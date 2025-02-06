import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticket_app_flutter/shared/constants/constants.dart';
import 'package:ticket_app_flutter/shared/extensions/extensions.dart';

import '../../../core/utils/logman.dart';
import '../../enums/picky_list_mode.dart';
import '../../themes/theme_globals.dart';
import '../bottom_padding.dart';
import '../styled_widgets/styled_button.dart';
import '../styled_widgets/styled_drag.dart';
import '../styled_widgets/styled_loading_indicator.dart';
import '../styled_widgets/styled_search_text_field.dart';
import 'limited_width_view.dart';

class PickyListView<T> extends StatefulWidget {
  const PickyListView._multiple({
    super.key,
    required this.items,
    required this.groupValue,
    this.title,
    this.titleBuilder,
    required this.onSelected,
    this.mode,
    this.leadingBuilder,
    this.itemLabelBuilder,
    this.closeOnSelect,
    this.disabledItems,
    required this.cancelText,
  })  : _isMultiselect = true,
        assert(
          (title != null && titleBuilder == null) ||
              (title == null && titleBuilder != null),
          'Either title or titleBuilder must be provided, but not both.',
        );

  PickyListView._single({
    super.key,
    required this.items,
    required T? groupValue,
    this.title,
    this.titleBuilder,
    required this.onSelected,
    this.mode,
    this.leadingBuilder,
    this.itemLabelBuilder,
    this.closeOnSelect = false,
    this.disabledItems,
    required this.cancelText,
  })  : _isMultiselect = false,
        groupValue = [
          if (groupValue != null) groupValue,
        ],
        assert(
          (title != null && titleBuilder == null) ||
              (title == null && titleBuilder != null),
          'Either title or titleBuilder must be provided, but not both.',
        );

  final List<T> items;
  final List<T>? groupValue;
  final String? title;
  final String Function()? titleBuilder;
  final FutureOr<bool?> Function(T)? onSelected;
  final PickyListMode? mode;
  final Widget Function(T value)? leadingBuilder;
  final String? Function(T value)? itemLabelBuilder;
  final bool? closeOnSelect;
  final bool _isMultiselect;
  final List<T>? disabledItems;
  final String cancelText;

  static Future<List<T>?> showMultiple<T>({
    required BuildContext context,
    required List<T> items,
    required List<T>? groupValue,
    String? title,
    String Function()? titleBuilder,
    required FutureOr<bool?> Function(T) onSelected,
    PickyListMode? mode,
    Widget Function(T value)? leadingBuilder,
    String? Function(T value)? itemLabelBuilder,
    List<T>? disabledItems,
    required String cancelText,
  }) {
    mode ??= items.length > CommonValues.pickyModalSheetMaxItems
        ? PickyListMode.fullPage
        : PickyListMode.modalSheet;

    final PickyListView<T> child = PickyListView<T>._multiple(
      items: items,
      groupValue: groupValue,
      title: title,
      titleBuilder: titleBuilder,
      onSelected: onSelected,
      mode: mode,
      leadingBuilder: leadingBuilder,
      itemLabelBuilder: itemLabelBuilder,
      disabledItems: disabledItems,
      cancelText: cancelText,
    );

    if (mode == PickyListMode.modalSheet) {
      return _showModalSheet(
        context: context,
        child: child,
      );
    } else {
      return _showFullPage(
        context: context,
        child: child,
      );
    }
  }

  static Future<List<T>?> showSingle<T>({
    required BuildContext context,
    required List<T> items,
    required T? groupValue,
    String? title,
    String Function()? titleBuilder,
    required FutureOr<bool?> Function(T) onSelected,
    PickyListMode? mode,
    Widget Function(T value)? leadingBuilder,
    String? Function(T value)? itemLabelBuilder,
    bool closeOnSelect = false,
    List<T>? disabledItems,
    required String cancelText,
  }) {
    mode ??= items.length > CommonValues.pickyModalSheetMaxItems
        ? PickyListMode.fullPage
        : PickyListMode.modalSheet;

    final PickyListView<T> child = PickyListView<T>._single(
      items: items,
      groupValue: groupValue,
      title: title,
      titleBuilder: titleBuilder,
      onSelected: onSelected,
      mode: mode,
      leadingBuilder: leadingBuilder,
      itemLabelBuilder: itemLabelBuilder,
      closeOnSelect: closeOnSelect,
      disabledItems: disabledItems,
      cancelText: cancelText,
    );

    if (mode == PickyListMode.modalSheet) {
      return _showModalSheet(
        context: context,
        child: child,
      );
    } else {
      return _showFullPage(
        context: context,
        child: child,
      );
    }
  }

  static Future<T?> _showModalSheet<T>({
    required BuildContext context,
    required Widget child,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (_) {
        return Wrap(children: [child]);
      },
    );
  }

  static Future<T?> _showFullPage<T>({
    required BuildContext context,
    required Widget child,
  }) {
    return showCupertinoModalPopup<T>(
      context: context,
      builder: (_) => child,
    );
  }

  @override
  State<PickyListView<T>> createState() => _PickyListViewState<T>();
}

class _PickyListViewState<T> extends State<PickyListView<T>> {
  List<T>? items;
  T? _processingItem;
  late List<T> selectedItems;
  late PickyListMode mode;

  @override
  void initState() {
    super.initState();

    items = widget.items;
    selectedItems = widget.groupValue ?? [];
    mode = widget.mode ??
        (widget.items.length > CommonValues.pickyModalSheetMaxItems
            ? PickyListMode.fullPage
            : PickyListMode.modalSheet);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
        child: LimitedWidthView(
          expandHeight: false,
          child: ColoredBox(
            color: context.theme.scaffoldBackgroundColor,
            child: Column(
              children: [
                mode == PickyListMode.fullPage
                    ? AppBar(
                        leading: Center(
                          child: CloseButton(
                            onPressed: () {
                              Navigator.of(context).pop(selectedItems);
                            },
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                if (mode == PickyListMode.fullPage)
                  Expanded(
                    child: _buildBody(),
                  )
                else
                  _buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          if (mode == PickyListMode.modalSheet) ...[
            const StyledDrag(),
            const SizedBox(height: 20.0),
          ],
          Text(
            (widget.titleBuilder?.call() ?? widget.title)!,
            style: size24weight700.withHeight(32.0),
          ),
          if (mode == PickyListMode.fullPage) ...[
            const SizedBox(height: 20.0),
            StyledSearchTextField(
              cancelText: widget.cancelText,
              onChanged: (String query) {
                setState(() {
                  items = widget.items.where((T element) {
                    final String label =
                        widget.itemLabelBuilder?.call(element) ??
                            element.toString();

                    return label.toLowerCase().contains(query.toLowerCase());
                  }).toList();
                });
              },
            ),
          ],
          const SizedBox(height: 20.0),
          if (mode == PickyListMode.fullPage)
            Expanded(
              child: _buildContainer(),
            )
          else
            _buildContainer(),
          if (mode == PickyListMode.modalSheet) ...[
            const SizedBox(height: 16.0),
            StyledButton(
              color: Colors.white,
              textColor: Colors.black,
              label: widget.cancelText,
              onTap: () {
                Navigator.of(context).pop(selectedItems);
              },
            ),
            const BottomPadding(),
          ],
        ],
      ),
    );
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        decoration: BoxDecoration(
          color: roundedCardColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: EdgeInsets.zero,
        child: Scrollbar(
          child: ListView.separated(
            shrinkWrap: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(16.0),
            itemCount: items!.length,
            itemBuilder: (context, index) {
              final item = items![index];
              final selected = selectedItems.contains(item);

              return _Item(
                item: item,
                selected: selected,
                busy: _processingItem == item,
                onSelected: () async {
                  await _onTap(item, selected);

                  if (widget.closeOnSelect == true && context.mounted) {
                    Navigator.of(context).pop(selectedItems);
                  }
                },
                canDeselect: widget._isMultiselect,
                leadingBuilder: widget.leadingBuilder,
                itemLabelBuilder: widget.itemLabelBuilder,
                isDisabled: widget.disabledItems?.contains(item) ?? false,
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(height: 32.0);
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onTap(T item, bool selected) async {
    logman.info('clicked item: $item, processing: $_processingItem');

    if (_processingItem != null) {
      return;
    }

    try {
      setState(() => _processingItem = item);

      if (widget.onSelected != null) {
        final isSelected = await widget.onSelected!(item);

        if ((isSelected ?? false) && widget._isMultiselect) {
          selected ? selectedItems.remove(item) : selectedItems.add(item);
        }
      }

      if (!widget._isMultiselect) {
        selectedItems = [item];
      }
    } catch (e, s) {
      logman.error(e, stackTrace: s);

      HapticFeedback.heavyImpact();
    } finally {
      setState(() => _processingItem = null);
    }
  }
}

class _Item<T> extends StatelessWidget {
  const _Item({
    required this.item,
    required this.selected,
    required this.busy,
    required this.onSelected,
    required this.canDeselect,
    required this.leadingBuilder,
    required this.itemLabelBuilder,
    required this.isDisabled,
  });

  final T item;
  final bool selected;
  final bool busy;
  final Function() onSelected;
  final bool canDeselect;
  final Widget Function(T value)? leadingBuilder;
  final String? Function(T value)? itemLabelBuilder;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isDisabled,
      child: Opacity(
        opacity: isDisabled ? 0.5 : 1.0,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () async {
            if (selected && !canDeselect) {
              return;
            }

            HapticFeedback.selectionClick().ignore();

            await onSelected();

            HapticFeedback.mediumImpact();
          },
          child: Row(
            children: [
              if (leadingBuilder != null)
                leadingBuilder!.call(item).padRight(16.0),
              Expanded(
                child: Text(
                  itemLabelBuilder?.call(item).asValidString() ??
                      item.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: size16weight500,
                ),
              ),
              const SizedBox(width: 24.0),
              SizedBox(
                height: 24.0,
                width: 24.0,
                child: _buildTrailing(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget? _buildTrailing() {
    final bool useCheckbox = canDeselect;

    if (busy) {
      return const StyledLoadingIndicator();
    }

    final String suffix = selected ? 'on' : 'off';

    if (useCheckbox) {
      return SvgPicture.asset(
        'assets/icons/common/checkbox-$suffix.svg',
      );
    } else {
      return SvgPicture.asset(
        'assets/icons/common/radio-$suffix.svg',
      );
    }
  }
}
