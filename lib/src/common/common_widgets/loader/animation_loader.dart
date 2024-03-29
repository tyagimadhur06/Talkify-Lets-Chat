import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationLoaderWidget extends StatelessWidget {
  const AnimationLoaderWidget({
    Key? key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  }) : super(key: key);

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center( 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation , width: MediaQuery.of(context).size.width * 0.8),
          const SizedBox(
            height: 24,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 24,
          ),
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    style:OutlinedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: onActionPressed,
                    child: Text(
                      actionText!,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
