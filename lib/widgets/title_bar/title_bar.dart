import 'package:auto_route/auto_route.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_manager/widgets/title_bar/title_bar_cubit.dart';

typedef OnBackClicked = Function();

class TitleBar extends StatefulWidget {
  final String title;
  final OnBackClicked? onBackClicked;
  final bool isBackButtonVisible;

  const TitleBar({
    Key? key,
    required this.title,
    this.onBackClicked,
    this.isBackButtonVisible = true
  }) : super(key: key);

  @override
  State<TitleBar> createState() => TitleBarState();
}

class TitleBarState extends State<TitleBar> {
  final TitleBarCubit _titleBarCubit = TitleBarCubit();


  @override
  void dispose() {
    _titleBarCubit.close();
    super.dispose();
  }


  void activateBackButton() {
    _titleBarCubit.activate();
  }


  void deactivateBackButton() {
    _titleBarCubit.deactivate();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _titleBarCubit,
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
                if (widget.isBackButtonVisible)
                  BlocBuilder<TitleBarCubit, TitleBarInitial>(
                    builder: (context, state) {
                      Function()? onPressed = () {
                        AutoRouter.of(context).pop();
                        widget.onBackClicked?.call();
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
                        widget.title,
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
