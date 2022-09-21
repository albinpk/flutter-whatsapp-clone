import 'package:flutter/material.dart';
import 'package:whatsapp/utils/themes/custom_colors.dart';

class SearchBarDesktop extends StatelessWidget with PreferredSizeWidget {
  const SearchBarDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customColors = CustomColors.of(context);
    return SizedBox(
      height: kToolbarHeight,
      child: ColoredBox(
        color: customColors.background!,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ColoredBox(
                    color: customColors.secondary!,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Icon(
                            Icons.search,
                            color: customColors.iconMuted,
                          ),
                        ),
                        const Expanded(
                          child: TextField(
                            cursorColor: Colors.black,
                            cursorWidth: 1,
                            decoration: InputDecoration(
                              hintText: 'Search or start new chat',
                              contentPadding: EdgeInsets.only(bottom: 10),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                color: customColors.iconMuted,
                icon: const Icon(Icons.sort),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
