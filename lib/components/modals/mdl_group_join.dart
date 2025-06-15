import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:orgit/components/groups/group_list_component.dart';
import 'package:orgit/components/Modals/mdl_item_view.dart';
import 'package:orgit/components/Bar/slide_bar.dart';
import 'package:orgit/components/Inputs/custom_searchbar.dart';
import 'package:orgit/utils/responsive_utils.dart';
import 'package:orgit/services/auth/auth.dart';
import 'package:orgit/services/location/location_service.dart';
import 'package:orgit/services/api/group.dart';
import 'package:orgit/services/api/api_client.dart';
import 'package:orgit/models/group_dto.dart';

class Mdlgroupjoin extends StatefulWidget {
  @override
  State<Mdlgroupjoin> createState() => _MdlgroupjoinState();
}

class _MdlgroupjoinState extends State<Mdlgroupjoin> {
  final TextEditingController searchControl = TextEditingController();
  final LocationService _locationService = LocationService();
  final GroupService _groupService = GroupService();

  // State variables
  List<GroupSearchResponse> _nearbyGroups = [];
  List<GroupSearchResponse> _allGroups = [];
  List<GroupSearchResponse> _filteredGroups = [];
  bool _isLoadingNearby = false;
  bool _isLoadingAll = false;
  bool _isSearching = false;
  String _userCity = '';
  Position? _userPosition;

  // Pagination
  int _nearbyStart = 0;
  int _allStart = 0;
  final int _pageSize = 4;
  bool _hasMoreNearby = true;
  bool _hasMoreAll = true;

  @override
  void initState() {
    super.initState();
    _initializeData();

    // Nastavení listeneru pro vyhledávání
    searchControl.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchControl.removeListener(_onSearchChanged);
    searchControl.dispose();
    super.dispose();
  }

  /// Inicializace dat - získání polohy a načtení skupin
  Future<void> _initializeData() async {
    await _getUserLocation();
    await _loadNearbyGroups();
    await _loadAllGroups();
  }

  /// Získání aktuální polohy uživatele
  Future<void> _getUserLocation() async {
    try {
      _userPosition = await _locationService.getCurrentLocation();

      if (_userPosition != null) {
        // Pro demonstraci - v reálné aplikaci by se použila reverse geocoding API
        setState(() {
          _userCity = 'Děčín'; // Placeholder - mělo by se určit z GPS souřadnic
        });
      }
    } catch (e) {
      print('Error getting location: $e');
      // Fallback na výchozí město
      setState(() {
        _userCity = 'Děčín';
      });
    }
  }

  /// Načtení skupin v okolí
  Future<void> _loadNearbyGroups({bool isLoadMore = false}) async {
    if (_isLoadingNearby || (!_hasMoreNearby && isLoadMore)) return;

    setState(() {
      _isLoadingNearby = true;
    });

    print(
        'DEBUG: Loading nearby groups - city: $_userCity, start: $_nearbyStart, pageSize: $_pageSize');

    try {
      List<GroupSearchResponse> newGroups;

      if (_userCity.isNotEmpty) {
        // Načtení skupin podle města uživatele
        print('DEBUG: Searching groups by city: $_userCity');
        newGroups = await _groupService.searchGroupsByCity(
            _userCity, _nearbyStart, _pageSize);
      } else {
        // Fallback na obecné vyhledávání
        print('DEBUG: Searching all groups (fallback)');
        newGroups = await _groupService.searchGroups(_nearbyStart, _pageSize);
      }

      print('DEBUG: Received ${newGroups.length} nearby groups');

      setState(() {
        if (isLoadMore) {
          _nearbyGroups.addAll(newGroups);
        } else {
          _nearbyGroups = newGroups;
        }

        _nearbyStart += newGroups.length;
        _hasMoreNearby = newGroups.length >= _pageSize;
        _isLoadingNearby = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingNearby = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Chyba při načítání skupin v okolí: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Načtení všech skupin
  Future<void> _loadAllGroups({bool isLoadMore = false}) async {
    if (_isLoadingAll || (!_hasMoreAll && isLoadMore)) return;

    setState(() {
      _isLoadingAll = true;
    });

    print(
        'DEBUG: Loading all groups - start: $_allStart, pageSize: $_pageSize');

    try {
      final newGroups = await _groupService.searchGroups(_allStart, _pageSize);

      print('DEBUG: Received ${newGroups.length} all groups');

      setState(() {
        if (isLoadMore) {
          _allGroups.addAll(newGroups);
        } else {
          _allGroups = newGroups;
        }

        _allStart += newGroups.length;
        _hasMoreAll = newGroups.length >= _pageSize;
        _isLoadingAll = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingAll = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Chyba při načítání všech skupin: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Zpracování změny ve vyhledávacím poli
  void _onSearchChanged() {
    final query = searchControl.text.trim();

    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _filteredGroups.clear();
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    _searchGroups(query);
  }

  /// Vyhledávání skupin podle názvu
  Future<void> _searchGroups(String query) async {
    print('DEBUG: Searching groups by name: $query');

    try {
      final results = await _groupService.searchGroupsByName(
          query, 0, 20); // Více výsledků pro vyhledávání

      print('DEBUG: Search results: ${results.length} groups found');

      setState(() {
        _filteredGroups = results;
      });
    } catch (e) {
      print('DEBUG: Error searching groups: $e');
      setState(() {
        _filteredGroups.clear();
      });
    }
  }

  /// Zpracování připojení ke skupině
  Future<void> _handleJoinGroup(
      BuildContext context, GroupSearchResponse group) async {
    try {
      // Získání ID aktuálního uživatele
      final authService = AuthService();
      final userUid = await authService.getUserUidAsync();

      if (userUid == "-1") {
        throw Exception('Uživatelská data nejsou k dispozici');
      }

      // Získání user ID z API
      final userId = await ApiClient().get('/User/id/$userUid');

      if (userId == null) {
        throw Exception('Nepodařilo se získat ID uživatele');
      } // Volání API pro připojení ke skupině
      final success = await _groupService.addUserToGroup(userId, group.groupid);

      if (!success) {
        throw Exception('Připojení ke skupině selhalo');
      }

      // Aktualizace cache - uživatel je nyní ve skupině
      // await authService.updateInGroupStatus(true);

      if (context.mounted) {
        // Zavření modalu
        Navigator.of(context).pop();

        // Zobrazení úspěšné zprávy
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Úspěšně jste se připojili ke skupině "${group.name}"!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigace na homepage
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/homepage',
          (route) => false,
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Chyba při připojování ke skupině: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight * 0.9, // 90% výšky obrazovky
      child: Container(
        height: screenHeight * 0.9,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 19, 20, 22),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(27),
            topRight: Radius.circular(27),
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: ResponsiveUtils.getSpacingMedium(context)),
              child: SlideBar(),
            ),
            Positioned(
                left: ResponsiveUtils.getPaddingHorizontal(context),
                top: screenHeight * 0.04,
                child: Text(
                  'Připojit se ke skupině',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: ResponsiveUtils.getHeadingFontSize(context),
                  ),
                )),
            Positioned(
                left: ResponsiveUtils.getPaddingHorizontal(context) * 0.8,
                top: screenHeight * 0.13,
                child: SizedBox(
                  width: screenWidth * 0.85,
                  height: ResponsiveUtils.getButtonHeight(context) * 0.6,
                  child: Customsearchbar(
                    hintText: "Název skupiny...",
                    controller: searchControl,
                    suggestions: [], // Dynamické návrhy lze přidat později
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.22),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Zobrazení výsledků vyhledávání
                      if (_isSearching && searchControl.text.isNotEmpty) ...[
                        Itemview(
                          textHeader: 'Výsledky vyhledávání',
                          opened: true,
                          textFooter: '',
                          onTapFooter: () {},
                          headerFont:
                              ResponsiveUtils.getSubtitleFontSize(context),
                          cards: [
                            GroupListComponent(
                              groups: _filteredGroups,
                              isLoading: false,
                              emptyMessage: 'Žádné skupiny nenalezeny',
                              userPosition: _userPosition,
                              onGroupTap: (group) =>
                                  _handleJoinGroup(context, group),
                            ),
                          ],
                        ),
                      ] else ...[
                        // Skupiny v okolí
                        Itemview(
                          textHeader: _userCity.isNotEmpty
                              ? 'Skupiny v okolí ($_userCity)'
                              : 'Skupiny v okolí',
                          opened: true,
                          textFooter: _hasMoreNearby && !_isLoadingNearby
                              ? 'Zobrazit více'
                              : '',
                          onTapFooter: _hasMoreNearby && !_isLoadingNearby
                              ? () => _loadNearbyGroups(isLoadMore: true)
                              : () {},
                          headerFont:
                              ResponsiveUtils.getSubtitleFontSize(context),
                          cards: [
                            GroupListComponent(
                              groups: _nearbyGroups,
                              isLoading: _isLoadingNearby,
                              emptyMessage: 'Žádné skupiny v okolí nenalezeny',
                              userPosition: _userPosition,
                              hasMore: _hasMoreNearby,
                              onShowMore: _hasMoreNearby && !_isLoadingNearby
                                  ? () => _loadNearbyGroups(isLoadMore: true)
                                  : null,
                              onGroupTap: (group) =>
                                  _handleJoinGroup(context, group),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ResponsiveUtils.getSpacingLarge(context),
                        ),
                        // Všechny skupiny
                        Itemview(
                          textHeader: 'Všechny skupiny',
                          textFooter: _hasMoreAll && !_isLoadingAll
                              ? 'Zobrazit více'
                              : '',
                          onTapFooter: _hasMoreAll && !_isLoadingAll
                              ? () => _loadAllGroups(isLoadMore: true)
                              : () {},
                          headerFont:
                              ResponsiveUtils.getSubtitleFontSize(context),
                          cards: [
                            GroupListComponent(
                              groups: _allGroups,
                              isLoading: _isLoadingAll,
                              emptyMessage: 'Žádné skupiny nenalezeny',
                              userPosition: _userPosition,
                              hasMore: _hasMoreAll,
                              onShowMore: _hasMoreAll && !_isLoadingAll
                                  ? () => _loadAllGroups(isLoadMore: true)
                                  : null,
                              onGroupTap: (group) =>
                                  _handleJoinGroup(context, group),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
