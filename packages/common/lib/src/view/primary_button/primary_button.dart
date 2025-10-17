import 'package:flutter/material.dart';
import '../../utils/utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool enabled;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  const PrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: (enabled == false || isLoading) ? null : onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: ColorsPalette.primaryButton,
        disabledBackgroundColor: Colors.grey,
        overlayColor: Colors.grey,
        side: BorderSide(
          color: (enabled == false | isLoading)
              ? Colors.grey
              : ColorsPalette.primaryButton,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      child: isLoading
          ? SpinKitThreeBounce(color: ColorsPalette.primaryButton, size: 14)
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (prefixIcon != null) ...[
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(prefixIcon, color: Colors.black, size: 18),
                  ),
                ],
                Flexible(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (suffixIcon != null) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Icon(suffixIcon, color: Colors.black, size: 18),
                  ),
                ],
              ],
            ),
    );
  }
}
