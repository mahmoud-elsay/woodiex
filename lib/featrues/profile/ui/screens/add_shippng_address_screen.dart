import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/widgets/backble_top_bar.dart';
import 'package:woodiex/core/widgets/app_text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_state_city/country_state_city.dart' as csc;
import 'package:woodiex/featrues/profile/ui/widgets/add_shipping_address_widgets.dart/edit_address_dialog.dart';
import 'package:woodiex/featrues/profile/ui/widgets/add_shipping_address_widgets.dart/address_field_container.dart';
import 'package:woodiex/featrues/profile/ui/widgets/add_shipping_address_widgets.dart/white_address_fileds_container.dart';

class AddShippingAddressScreen extends StatefulWidget {
  const AddShippingAddressScreen({super.key});

  @override
  _AddShippingAddressScreenState createState() =>
      _AddShippingAddressScreenState();
}

class _AddShippingAddressScreenState extends State<AddShippingAddressScreen> {
  String fullName = 'Ex: Bruno Pham';
  String address = 'Ex: 25 Robert Latouche Street';
  String zipcode = 'Pham Cong Thanh';
  String country = 'Select Country';
  String city = 'Select City';
  String district = 'Select District';

  List<String> countries = ['Select Country'];
  List<String> cities = ['Select City'];
  List<String> districts = ['Select District'];

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    final countryData = await csc.getAllCountries();
    setState(() {
      countries.addAll(countryData.map((c) => c.name).toList()..sort());
    });
  }

  Future<void> _loadCities(String countryName) async {
    if (countryName == 'Select Country') {
      setState(() {
        cities = ['Select City'];
        city = 'Select City';
        districts = ['Select District'];
        district = 'Select District';
      });
      return;
    }
    final countryData =
        (await csc.getAllCountries()).firstWhere((c) => c.name == countryName);
    final cityData = await csc.getStatesOfCountry(countryData.isoCode);
    setState(() {
      cities = ['Select City'] + cityData.map((s) => s.name).toList()
        ..sort();
      city = 'Select City';
      districts = ['Select District'];
      district = 'Select District';
    });
  }

  Future<void> _loadDistricts(String countryName, String cityName) async {
    if (cityName == 'Select City') {
      setState(() {
        districts = ['Select District'];
        district = 'Select District';
      });
      return;
    }
    final countryData =
        (await csc.getAllCountries()).firstWhere((c) => c.name == countryName);
    final stateData = (await csc.getStatesOfCountry(countryData.isoCode))
        .firstWhere((s) => s.name == cityName);
    final districtData =
        await csc.getStateCities(countryData.isoCode, stateData.isoCode);
    setState(() {
      districts = ['Select District'] + districtData.map((c) => c.name).toList()
        ..sort();
      district = 'Select District';
    });
  }

  void _showEditDialog({
    required String label,
    required String initialValue,
    required ValueChanged<String> onSave,
    bool isDropdown = false,
    List<String>? dropdownItems,
    VoidCallback? onAfterSave,
  }) {
    showDialog(
      context: context,
      builder: (context) => EditAddressDialog(
        label: label,
        initialValue: initialValue,
        isDropdown: isDropdown,
        dropdownItems: dropdownItems,
        onSave: (value) {
          onSave(value);
          if (onAfterSave != null) onAfterSave();
        },
      ),
    );
  }

  Widget _buildAddressField({
    required String label,
    required String value,
    required ValueChanged<String> onSave,
    bool isDropdown = false,
    List<String>? dropdownItems,
    VoidCallback? onAfterSave,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: isDropdown
          ? WhiteAddressFieldsContainer(
              label: label,
              value: value,
              isDropdown: true,
              onTap: () => _showEditDialog(
                label: label,
                initialValue: value,
                onSave: onSave,
                isDropdown: true,
                dropdownItems: dropdownItems,
                onAfterSave: onAfterSave,
              ),
            )
          : GestureDetector(
              onTap: () => _showEditDialog(
                label: label,
                initialValue: value,
                onSave: onSave,
              ),
              child: AddressFieldContainer(
                label: label,
                value: value,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                BackableTopBar(screenTitle: 'Add Shipping Address'),
                verticalSpace(15),
                _buildAddressField(
                  label: 'Full Name',
                  value: fullName,
                  onSave: (value) => setState(() => fullName = value),
                ),
                _buildAddressField(
                  label: 'Address',
                  value: address,
                  onSave: (value) => setState(() => address = value),
                ),
                _buildAddressField(
                  label: 'Zipcode (Postal Code)',
                  value: zipcode,
                  onSave: (value) => setState(() => zipcode = value),
                ),
                _buildAddressField(
                  label: 'Country',
                  value: country,
                  onSave: (value) => setState(() => country = value),
                  isDropdown: true,
                  dropdownItems: countries,
                  onAfterSave: () => _loadCities(country),
                ),
                _buildAddressField(
                  label: 'City',
                  value: city,
                  onSave: (value) => setState(() => city = value),
                  isDropdown: true,
                  dropdownItems: cities,
                  onAfterSave: () => _loadDistricts(country, city),
                ),
                _buildAddressField(
                  label: 'District',
                  value: district,
                  onSave: (value) => setState(() => district = value),
                  isDropdown: true,
                  dropdownItems: districts,
                ),
                verticalSpace(100.h), // Adjusted space for bottom bar
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 8,
        height: 100.h, // Increased height to fix clipping
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: AppTextButton(
            buttonText: 'SAVE ADDRESS',
            textStyle: Fonts.nunitoSans18SemiBoldWhite,
            buttonHeight: 50.h, // Ensured button height fits
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Address Saved: $fullName, $address, $zipcode, $country, $city, $district'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
