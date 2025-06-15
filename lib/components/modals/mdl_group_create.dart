import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orgit/components/inputs/title_input.dart';
import 'package:orgit/components/inputs/avatar_input.dart';
import 'package:orgit/components/bar/slide_bar.dart';
import 'package:orgit/components/button/default_button.dart';
import 'package:orgit/services/api/api_client.dart';
import 'package:orgit/services/api/location.dart';
import 'package:orgit/utils/responsive_utils.dart';
import 'package:orgit/utils/navigation_utils.dart';
import 'package:orgit/services/auth/auth.dart';
import 'package:orgit/models/group_dto.dart';
import 'package:orgit/Pages/homepage.dart';

class MdlGroupCreate extends StatefulWidget {
  @override
  State<MdlGroupCreate> createState() => _MdlGroupCreateState();
}

class _MdlGroupCreateState extends State<MdlGroupCreate> {
  final _picker = ImagePicker();
  final _nameController = TextEditingController();
  final _regionController = TextEditingController();
  final _cityController = TextEditingController();
  final _descriptionController = TextEditingController();
  final LocationService _locationService = LocationService();

  Uint8List? _selectedImage;
  bool _isCreatingGroup = false;
  bool _isLoadingRegions = true;
  bool _isLoadingCities = false;
  OverlayEntry? _loadingOverlay;

  List<RegionDto> _regions = [];
  List<CityDto> _cities = [];

  RegionDto? _selectedRegion;
  CityDto? _selectedCity;
  // Dropdown entries for regions - return String names, keep IDs hidden
  List<DropdownMenuEntry<String>> get _regionEntries {
    return _regions
        .map((region) => DropdownMenuEntry<String>(
              value: region.name, // Return string name instead of ID
              label: region.name,
            ))
        .toList();
  }

  // Dropdown entries for cities - return String names, keep IDs hidden
  List<DropdownMenuEntry<String>> get _cityEntries {
    return _cities
        .map((city) => DropdownMenuEntry<String>(
              value: city.name, // Return string name instead of ID
              label: city.name,
            ))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _loadRegions();
  }

  @override
  void dispose() {
    _hideLoadingMessage();
    _nameController.dispose();
    _regionController.dispose();
    _cityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // REQUIREMENT 2: Fetch regions from API
  Future<void> _loadRegions() async {
    try {
      setState(() {
        _isLoadingRegions = true;
      });

      final regions = await _locationService.getRegions();
      setState(() {
        _regions = regions;
        _isLoadingRegions = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingRegions = false;
      });
      _showErrorMessage('Chyba při načítání krajů: ${e.toString()}');
    }
  }

  // REQUIREMENT 3: Fetch cities based on selected region from API
  Future<void> _loadCitiesByRegion(int regionId) async {
    try {
      setState(() {
        _isLoadingCities = true;
        _cities = [];
        _selectedCity = null;
        _cityController.clear();
      });

      final cities = await _locationService.getCitiesByRegion(regionId);
      setState(() {
        _cities = cities;
        _isLoadingCities = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingCities = false;
      });
      _showErrorMessage('Chyba při načítání měst: ${e.toString()}');
    }
  }

  // Handle region selection - find region by name and store both name and ID
  void _onRegionSelected(dynamic regionName) {
    if (regionName != null && regionName is String) {
      final selectedRegion = _regions.firstWhere(
        (region) => region.name == regionName,
        orElse: () => throw Exception('Region not found'),
      );
      setState(() {
        _selectedRegion = selectedRegion;
        _regionController.text = selectedRegion.name; // Display name
      });
      // Load cities using the region ID (hidden from user)
      _loadCitiesByRegion(selectedRegion.regionid);
    }
  }

  // Handle city selection - find city by name and store both name and ID
  void _onCitySelected(dynamic cityName) {
    if (cityName != null && cityName is String && _selectedRegion != null) {
      final selectedCity = _cities.firstWhere(
        (city) => city.name == cityName,
        orElse: () => throw Exception('City not found'),
      );
      setState(() {
        _selectedCity = selectedCity;
        _cityController.text = selectedCity.name; // Display name
      });
    }
  }

  // Select image for group profile picture
  Future<void> _selectImage() async {
    try {
      final XFile? selectedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (selectedImage != null) {
        final imageBytes = await selectedImage.readAsBytes();

        // Check file size (max 5MB)
        if (imageBytes.length > 5 * 1024 * 1024) {
          _showErrorMessage(
              'Obrázek je příliš velký. Maximální velikost je 5MB.');
          return;
        }

        setState(() {
          _selectedImage = imageBytes;
        });

        _showSuccessMessage('Obrázek byl úspěšně vybrán');
      }
    } catch (e) {
      _showErrorMessage('Chyba při výběru obrázku: ${e.toString()}');
    }
  }

  // Validate all inputs before creating group
  bool _validateInputs() {
    if (_nameController.text.trim().isEmpty) {
      _showErrorMessage('Název skupiny je povinný');
      return false;
    }

    if (_nameController.text.trim().length < 3) {
      _showErrorMessage('Název skupiny musí mít alespoň 3 znaky');
      return false;
    }

    if (_selectedRegion == null) {
      _showErrorMessage('Vyberte kraj');
      return false;
    }

    if (_selectedCity == null) {
      _showErrorMessage('Vyberte město');
      return false;
    }

    if (_descriptionController.text.trim().isEmpty) {
      _showErrorMessage('Popis skupiny je povinný');
      return false;
    }

    if (_descriptionController.text.trim().length < 10) {
      _showErrorMessage('Popis skupiny musí mít alespoň 10 znaků');
      return false;
    }

    return true;
  }

  // Show loading message overlay
  void _showLoadingMessage() {
    _loadingOverlay = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.blue.shade600,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'Vytváří se skupina...',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_loadingOverlay!);
  }

  void _hideLoadingMessage() {
    _loadingOverlay?.remove();
    _loadingOverlay = null;
  }

  // Show error message
  void _showErrorMessage(String message) {
    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.red.shade600,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    // Auto remove after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry?.remove();
    });
  }

  // Show success message
  void _showSuccessMessage(String message) {
    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.green.shade600,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    // Auto remove after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry?.remove();
    });
  }

  // Main function to create group
  Future<void> _createGroup() async {
    // Validate inputs first
    if (!_validateInputs()) {
      return;
    }

    setState(() {
      _isCreatingGroup = true;
    });

    try {
      // Show loading indicator
      _showLoadingMessage();

      // Get current user UID
      final userUid = AuthService().getUserUid();
      if (userUid == null) {
        _hideLoadingMessage();
        _showErrorMessage(
            'Uživatel není přihlášen. Přihlaste se prosím znovu.');
        return;
      } // Get userid from backend API
      final userid = await ApiClient().get('/User/id/$userUid');
      if (userid == null || userid <= 0) {
        _hideLoadingMessage();
        _showErrorMessage(
            'Nepodařilo se získat informace o uživateli. Zkuste to znovu.');
        return;
      }

      // Additional validation for IDs
      if (_selectedCity!.cityId <= 0) {
        _hideLoadingMessage();
        _showErrorMessage('Neplatné ID města. Zkuste vybrat město znovu.');
        return;
      }

      if (_selectedRegion!.regionid <= 0) {
        _hideLoadingMessage();
        _showErrorMessage('Neplatné ID kraje. Zkuste vybrat kraj znovu.');
        return;
      } // REQUIREMENT 4: Create group request with IDs (not names)
      GroupCreateRequest groupRequest = GroupCreateRequest(
        name: _nameController.text.trim(),
        city: _selectedCity!.cityId, // Using city ID
        region: _selectedRegion!.regionid, // Using region ID
        description: _descriptionController.text.trim(),
        profilepicture: _selectedImage,
        leader: userid,
        createdby: userid,
      ); // Debug: Print request data to help troubleshoot
      print('Creating group with data:');
      print(
          '  name: "${_nameController.text.trim()}" (length: ${_nameController.text.trim().length})');
      print('  cityid: ${_selectedCity!.cityId}');
      print('  regionid: ${_selectedRegion!.regionid}');
      print(
          '  description: "${_descriptionController.text.trim()}" (length: ${_descriptionController.text.trim().length})');
      print('  leader: $userid');
      print('  createdby: $userid');
      print(
          '  profilepicture: ${_selectedImage != null ? "provided (${_selectedImage!.length} bytes)" : "empty"}');

      // Create group via API
      final response = await ApiClient().post("/Group", groupRequest.toJson());

      _hideLoadingMessage();

      if (response != null &&
          response.containsKey('status') &&
          response['status'] == 'success') {
        // REQUIREMENT 5: Automatically join the group as administrator
        try {
          final groupId = response['groupid'];
          if (groupId != null) {
            // Add user to the newly created group as a member
            final joinResponse = await ApiClient().post("/Group/member", {
              'groupid': groupId,
              'userid': userid,
            });
            if (joinResponse != null &&
                joinResponse.containsKey('status') &&
                joinResponse['status'] == 'success') {
              // Update user's group status in cache
              // await AuthService().updateInGroupStatus(true);

              _showSuccessMessage(
                  'Skupina byla úspěšně vytvořena a jste přidán jako administrator!');

              // Wait a moment for user to see success message
              await Future.delayed(Duration(seconds: 2));

              // Přesměrování na Homepage
              if (mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => Homepage(initPage: 1)),
                  (Route<dynamic> route) =>
                      false, // Odstraní všechny předchozí stránky ze zásobníku
                );
              }
            } else {
              _showSuccessMessage(
                  'Skupina byla vytvořena, ale nepodařilo se vás automaticky přidat.');

              // Wait a moment for user to see success message
              await Future.delayed(Duration(seconds: 2));

              // Close modal and let user manually refresh
              if (mounted) {
                Navigator.pop(context, true);
              }
            }
          } else {
            _showSuccessMessage('Skupina byla úspěšně vytvořena!');

            // Wait a moment for user to see success message
            await Future.delayed(Duration(seconds: 2));

            // Přesměrování na Homepage
            if (mounted) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Homepage(initPage: 1)),
                (Route<dynamic> route) =>
                    false, // Odstraní všechny předchozí stránky ze zásobníku
              );
            }
          }
        } catch (e) {
          _showSuccessMessage(
              'Skupina byla vytvořena, ale nepodařilo se vás automaticky přidat.');

          // Wait a moment for user to see success message
          await Future.delayed(Duration(seconds: 2));

          // Přesměrování na Homepage i v případě chyby
          if (mounted) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Homepage(initPage: 1)),
              (Route<dynamic> route) => false,
            );
          }

          // Wait a moment for user to see success message
          await Future.delayed(Duration(seconds: 2));

          // Close modal and let user manually refresh
          if (mounted) {
            Navigator.pop(context, true);
          }
        }

        // Remove the old navigation code since we handle it above
        // Wait a moment for user to see success message
        // await Future.delayed(Duration(seconds: 1));

        // Close modal with success result
        // if (mounted) {
        //   Navigator.pop(context, true);
        // }
      } else {
        _showErrorMessage('Chyba při vytváření skupiny. Zkuste to znovu.');
      }
    } catch (e) {
      _hideLoadingMessage();

      String errorMessage = 'Chyba při vytváření skupiny';

      // Specific error messages based on error type
      if (e.toString().contains('network') ||
          e.toString().contains('connection')) {
        errorMessage =
            'Chyba připojení k internetu. Zkontrolujte své připojení.';
      } else if (e.toString().contains('timeout')) {
        errorMessage = 'Operace trvala příliš dlouho. Zkuste to znovu.';
      } else if (e.toString().contains('server')) {
        errorMessage = 'Chyba serveru. Zkuste to později.';
      } else {
        errorMessage = 'Neočekávaná chyba: ${e.toString()}';
      }

      _showErrorMessage(errorMessage);
    } finally {
      setState(() {
        _isCreatingGroup = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 19, 20, 22),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(27),
          topRight: Radius.circular(27),
        ),
      ),
      height: screenHeight * 0.9,
      width: double.infinity,
      child: Column(
        children: [
          // Slide bar at top
          Padding(
            padding:
                EdgeInsets.only(top: ResponsiveUtils.getSpacingSmall(context)),
            child: SlideBar(),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.getPaddingHorizontal(context),
              vertical: ResponsiveUtils.getSpacingSmall(context),
            ),
            child: Row(
              children: [
                Text(
                  'Vytvořit skupinu',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: ResponsiveUtils.getHeadingFontSize(context) * 0.9,
                  ),
                ),
              ],
            ),
          ),

          // Main content
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.getPaddingHorizontal(context),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Avatar input
                  AvatarInput(
                    image: _selectedImage,
                    onTap: _selectImage,
                  ),

                  // Form inputs
                  Column(
                    children: [
                      // Group name input
                      TitleInput(
                          controller: _nameController, value: 'Název skupiny'),

                      SizedBox(
                          height:
                              ResponsiveUtils.getSpacingSmall(context) * 0.5),

                      // Region and City dropdowns
                      Row(
                        children: [
                          // Region dropdown
                          Expanded(
                            child: _CustomDropDown(
                              controller: _regionController,
                              entries: _regionEntries,
                              labelText: "KRAJ",
                              onSelected: _onRegionSelected,
                              isEnabled: !_isLoadingRegions,
                            ),
                          ),

                          SizedBox(
                              width: ResponsiveUtils.getSpacingSmall(context) *
                                  0.5),

                          // City dropdown - REQUIREMENT 1: Only enabled after region selection
                          Expanded(
                            child: _CustomDropDown(
                              controller: _cityController,
                              entries: _cityEntries,
                              labelText: "MĚSTO",
                              onSelected: _onCitySelected,
                              isEnabled: _selectedRegion != null &&
                                  !_isLoadingCities, // Requirement 1
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                          height:
                              ResponsiveUtils.getSpacingSmall(context) * 0.5),

                      // Description input
                      _TextArea(controller: _descriptionController),
                    ],
                  ),

                  // Create button
                  Defaultbutton(
                    width: ResponsiveUtils.getButtonWidth(context),
                    height: ResponsiveUtils.getButtonHeight(context) * 0.8,
                    textColor: _isCreatingGroup ? Colors.grey : Colors.black,
                    text:
                        _isCreatingGroup ? "Vytváří se..." : "Vytvořit skupinu",
                    color: _isCreatingGroup
                        ? Colors.grey.shade400
                        : Color.fromARGB(255, 255, 203, 105),
                    onTap: _isCreatingGroup ? () {} : _createGroup,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom dropdown component
class _CustomDropDown extends StatelessWidget {
  const _CustomDropDown({
    required this.controller,
    required this.entries,
    required this.labelText,
    required this.onSelected,
    this.isEnabled = true,
  });

  final TextEditingController controller;
  final List<DropdownMenuEntry<String>> entries; // Changed from int to String
  final String labelText;
  final Function(dynamic) onSelected;
  final bool isEnabled;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isEnabled
              ? Color.fromARGB(255, 94, 95, 96)
              : Colors.grey.shade600,
          width: 1,
        ),
      ),
      child: DropdownMenu<String>(
        width: double.infinity, // Make dropdown take full width
        menuStyle: MenuStyle(
          backgroundColor: MaterialStatePropertyAll(
            Color.fromARGB(255, 26, 27, 29),
          ),
          surfaceTintColor: MaterialStatePropertyAll(Colors.transparent),
          shadowColor: MaterialStatePropertyAll(Colors.black54),
          elevation: MaterialStatePropertyAll(8),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          hintStyle: TextStyle(
            color: Colors.white60,
            fontSize: ResponsiveUtils.getBodyTextFontSize(context) * 0.9,
            fontWeight: FontWeight.w500,
          ),
        ),
        enableSearch: false,
        enableFilter: false,
        enabled: isEnabled,
        textStyle: TextStyle(
          fontSize: ResponsiveUtils.getBodyTextFontSize(context) * 0.9,
          color: isEnabled ? Colors.white : Colors.grey.shade400,
          fontWeight: FontWeight.w500,
        ),
        menuHeight: MediaQuery.of(context).size.height * 0.25,
        controller: controller,
        hintText: labelText,
        onSelected: onSelected,
        dropdownMenuEntries: entries
            .map((entry) => DropdownMenuEntry<String>(
                  value: entry.value,
                  label: entry.label,
                  style: MenuItemButton.styleFrom(
                    foregroundColor: Colors.white, // White text for menu items
                    backgroundColor: Colors.transparent,
                    textStyle: TextStyle(
                      fontSize:
                          ResponsiveUtils.getBodyTextFontSize(context) * 0.9,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

// Custom text area component
class _TextArea extends StatelessWidget {
  const _TextArea({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ResponsiveUtils.isSmallScreen(context)
          ? MediaQuery.of(context).size.height * 0.08
          : MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        border: Border.all(color: Color.fromARGB(255, 94, 95, 96)),
      ),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveUtils.getSpacingSmall(context) * 0.8),
        child: TextField(
          controller: controller,
          maxLines: ResponsiveUtils.isSmallScreen(context) ? 3 : 4,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: ResponsiveUtils.getBodyTextFontSize(context) * 0.9,
          ),
          decoration: InputDecoration.collapsed(
            hintStyle: TextStyle(
              color: Colors.white60,
              fontWeight: FontWeight.w600,
              fontSize: ResponsiveUtils.getBodyTextFontSize(context) * 0.9,
            ),
            hintText: "Popis skupiny",
          ),
        ),
      ),
    );
  }
}
