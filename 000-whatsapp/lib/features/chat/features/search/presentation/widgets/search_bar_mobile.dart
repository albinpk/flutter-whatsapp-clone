import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/themes/custom_colors.dart';
import '../../search.dart';

class SearchBarMobile extends StatelessWidget {
  const SearchBarMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final customColors = CustomColors.of(context);
    return WillPopScope(
      onWillPop: () async {
        context.read<ChatSearchBloc>().add(const ChatSearchClose());
        return false;
      },
      child: SliverAppBar(
        pinned: true,
        elevation: 2,
        shadowColor: Colors.black45,
        forceElevated: true,
        backgroundColor:
            isLight ? customColors.background : customColors.secondary,
        foregroundColor: customColors.onBackgroundMuted!,
        leading: const BackButton(),
        title: const SearchTextField(),
      ),
    );
  }
}
