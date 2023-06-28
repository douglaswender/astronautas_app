import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:astronautas_app/app/core/app_colors.dart';
import 'package:icons_plus/icons_plus.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController? textEditingController;
  final String? Function(String? value)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final bool obscureText;
  final void Function(String value)? onChanged;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final TextCapitalization? textCapitalization;
  final bool heightExpanded;
  final AutovalidateMode? autovalidateMode;
  final String? labelText;
  final bool enabled;

  const TextFieldWidget({
    super.key,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.onChanged,
    this.obscureText = false,
    this.textEditingController,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.heightExpanded = true,
    this.autovalidateMode,
    this.labelText,
    this.enabled = true,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool isVisiblePassword = false;

  @override
  void initState() {
    setState(() {
      isVisiblePassword = widget.obscureText;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.heightExpanded) {
      return SizedBox(
        height: 100,
        child: Theme(
          data: ThemeData(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: AppColors.primary,
                ),
          ),
          child: TextFormField(
            enabled: widget.enabled,
            autovalidateMode: widget.autovalidateMode,
            textCapitalization: widget.textCapitalization!,
            inputFormatters: widget.inputFormatters,
            maxLength: widget.maxLength,
            controller: widget.textEditingController,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.black,
              fontWeight: FontWeight.w400,
            ),
            onChanged: widget.onChanged,
            validator: widget.validator,
            decoration: InputDecoration(
              focusColor: Colors.white,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon != null
                  ? widget.suffixIcon!
                  : widget.obscureText
                      ? InkWell(
                          onTap: () => setState(() {
                            isVisiblePassword = !isVisiblePassword;
                          }),
                          child: Icon(
                            !isVisiblePassword
                                ? Bootstrap.eye
                                : Bootstrap.eye_slash,
                          ),
                        )
                      : null,
              //suffixStyle: const TextStyle(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.primary, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              fillColor: AppColors.grey3,
              filled: true,
              hintText: widget.hintText,
              labelText: widget.labelText,
              hintStyle: const TextStyle(
                color: AppColors.grey1,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            obscureText: isVisiblePassword,
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
          ),
        ),
      );
    } else {
      return Theme(
        data: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: AppColors.primary,
              ),
        ),
        child: TextFormField(
          enabled: widget.enabled,
          autovalidateMode: widget.autovalidateMode,
          textCapitalization: widget.textCapitalization!,
          inputFormatters: widget.inputFormatters,
          maxLength: widget.maxLength,
          controller: widget.textEditingController,
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
          onChanged: widget.onChanged,
          validator: widget.validator,
          decoration: InputDecoration(
            focusColor: Colors.white,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon != null
                ? widget.suffixIcon!
                : widget.obscureText
                    ? InkWell(
                        onTap: () => setState(() {
                          isVisiblePassword = !isVisiblePassword;
                        }),
                        child: Icon(
                          !isVisiblePassword
                              ? Bootstrap.eye
                              : Bootstrap.eye_slash,
                        ),
                      )
                    : null,
            //suffixStyle: const TextStyle(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.primary, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            fillColor: AppColors.grey3,
            filled: true,
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: AppColors.grey1,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          obscureText: isVisiblePassword,
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
        ),
      );
    }
  }
}
