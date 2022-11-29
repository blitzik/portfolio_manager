import 'package:auto_route/auto_route.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_manager/widgets/title_bar/title_bar_cubit.dart';

typedef OnBackClicked = Function();

class TitleBar extends StatelessWidget {
  final String title;
  final OnBackClicked? onBackClicked;
  final bool isBackButtonVisible;
  final TitleBarCubit cubit;

  const TitleBar({
    Key? key,
    required this.title,
    this.onBackClicked,
    this.isBackButtonVisible = true,
    required this.cubit
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: SizedBox(
        height: 50.0,
        child: Container(
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1.0))
          ),
          child: MoveWindow(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isBackButtonVisible)
                  BlocBuilder<TitleBarCubit, TitleBarInitial>(
                    builder: (context, state) {
                      Function()? onPressed = () {
                        AutoRouter.of(context).pop();
                        onBackClicked?.call();
                      };
                      if (!state.isBackButtonActive) {
                        onPressed = null;
                      }
                      return TextButton(
                          onPressed: onPressed,
                          child: const Icon(Icons.arrow_back)
                      );
                    },
                  ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    )
                ),
                MinimizeWindowButton(),
                CloseWindowButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
