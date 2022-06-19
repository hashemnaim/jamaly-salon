import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:salon_provider/feature/values/colors.dart';
import 'package:get/get.dart';

class PhoneNumber {
  String countryISOCode;
  String countryCode;
  String number;

  PhoneNumber({
    @required this.countryISOCode,
    @required this.countryCode,
    @required this.number,
  });

  String get completeNumber {
    String newCode = countryCode.substring(1);
    String newPhone = number[0] == "0" ? number.substring(1) : number;
    return newCode + newPhone;
  }
}

class IntlPhoneField extends StatefulWidget {
  final bool obscureText;
  final TextAlign textAlign;
  final VoidCallback onTap;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;
  final FormFieldSetter<PhoneNumber> onSaved;

  final ValueChanged<PhoneNumber> onChanged;
  final FormFieldValidator<String> validator;
  final bool autoValidate;

  final TextInputType keyboardType;

  final TextEditingController controller;

  final FocusNode focusNode;

  final void Function(String) onSubmitted;

  final bool enabled;

  final Brightness keyboardAppearance;

  final String initialValue;

  final String initialCountryCode;

  final InputDecoration decoration;

  final TextStyle style;
  final bool showDropdownIcon;

  final BoxDecoration dropdownDecoration;

  final List<TextInputFormatter> inputFormatters;

  final String searchText;

  final Color countryCodeTextColor;

  final Color dropDownArrowColor;

  final int maxLength;

  final TextInputAction textInputAction;

  IntlPhoneField({
    this.initialCountryCode,
    this.maxLength,
    this.obscureText = false,
    this.textAlign = TextAlign.left,
    this.onTap,
    this.readOnly = false,
    this.initialValue,
    this.keyboardType = TextInputType.number,
    this.autoValidate = true,
    this.controller,
    this.focusNode,
    this.decoration,
    this.style,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.showDropdownIcon = true,
    this.dropdownDecoration = const BoxDecoration(),
    this.inputFormatters,
    this.enabled = true,
    this.keyboardAppearance = Brightness.light,
    this.searchText = 'Search by Country Name',
    this.countryCodeTextColor,
    this.dropDownArrowColor,
    this.textInputAction,
  });

  @override
  _IntlPhoneFieldState createState() => _IntlPhoneFieldState();
}

class _IntlPhoneFieldState extends State<IntlPhoneField> {
  Country _selectedCountry = countries.firstWhere((item) => item.code == 'US');
  List<Country> filteredCountries = countries;
  FormFieldValidator<String> validator;
  bool taped = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.initialCountryCode != null) {
      _selectedCountry = countries
          .firstWhere((item) => item.code == widget.initialCountryCode);
    }
    validator = widget.autoValidate
        ? (value) => value.length != 10 ? 'Invalid Mobile Number' : null
        : widget.validator;
    focusNode.addListener(() {
      taped = focusNode.hasFocus;
      setState(() {});
    });
  }

  Future<void> _changeCountry() async {
    filteredCountries = countries;
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => StatefulBuilder(
        builder: (ctx, setState) => Dialog(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    labelText: widget.searchText,
                  ),
                  onChanged: (value) {
                    setState(() {
                      filteredCountries = countries
                          .where((country) => country.code
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredCountries.length,
                    itemBuilder: (ctx, index) => Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            filteredCountries[index].name,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          trailing: Text(
                            filteredCountries[index].dialCode,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          onTap: () {
                            _selectedCountry = filteredCountries[index];
                            Navigator.of(context).pop();
                          },
                        ),
                        Divider(thickness: 1),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: TextFormField(
        onTap: () {
          if (widget.onTap != null) widget.onTap();
        },
        focusNode: focusNode,
        // cursorColor: AppColors.primary,
        onFieldSubmitted: (s) {
          if (widget.onSubmitted != null) widget.onSubmitted(s);
        },
        decoration: InputDecoration(
          prefixIcon: _buildFlagsButton(),
          // filled: !taped,
          // fillColor: AppColors.gray20,
          contentPadding: EdgeInsets.symmetric(horizontal: 30.w),
          hintText: 'Phone Number'.tr,
          hintStyle:GoogleFonts.cairo
           (
              color: AppColors.gray60,
              fontSize: 16.sp,
              // fontFamily: "NunitoSans",
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(100.r),
            borderSide: BorderSide(
              color: AppColors.primary,
            ),
          ),
          // focusedBorder: OutlineInputBorder(
          //   // borderRadius: BorderRadius.circular(100.r),
          //   borderSide: BorderSide(
          //     color: AppColors.primary,
          //   ),
          // ),
          enabledBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(100.r),
            borderSide: BorderSide(
              color: AppColors.grayText,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(100.r),
            borderSide: BorderSide(
              color: Colors.redAccent,
            ),
          ),
        ),
        style:GoogleFonts.cairo
           (
            fontSize: 16.sp,
            // fontFamily: "NunitoSans",
            letterSpacing: 1.16,
            fontWeight: FontWeight.w400),
        onSaved: (value) {
          if (widget.onSaved != null)
            widget.onSaved(
              PhoneNumber(
                countryISOCode: _selectedCountry.code,
                countryCode: _selectedCountry.dialCode,
                number: value,
              ),
            );
        },
        onChanged: (value) {
          if (widget.onChanged != null)
            widget.onChanged(
              PhoneNumber(
                countryISOCode: _selectedCountry.code,
                countryCode: _selectedCountry.dialCode,
                number: value,
              ),
            );
        },
        validator: validator,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        enabled: widget.enabled,
        keyboardAppearance: widget.keyboardAppearance,
        textInputAction: widget.textInputAction,
      ),
    );
  }

  Widget _buildFlagsButton() {
    return Container(
      width: 120.w,
      height: 65.h,
      child: InkWell(
        borderRadius: widget.dropdownDecoration.borderRadius,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image.asset(
              //   'assets/flags/${_selectedCountry['code'].toLowerCase()}.png',
              //   package: 'intl_phone_field',
              //   width: 32,
              // ),
              Text(
                _selectedCountry.dialCode,
                style: GoogleFonts.cairo
           (
                    color: AppColors.gray60,
                    fontSize: 16.sp,
                    // fontFamily: "NunitoSans",
                    letterSpacing: 1.16,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(width: 5.w),

              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.primary,
              ),
              Container(
                height: 20.h,
                width: 1.w,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                color: AppColors.gray60,
              ),
            ],
          ),
        ),
        onTap: _changeCountry,
      ),
    );
  }
}
