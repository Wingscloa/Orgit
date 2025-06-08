import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:orgit/components/cards/card_group.dart';
import 'package:orgit/models/group_dto.dart';
import 'package:orgit/services/location/location_service.dart';
import 'package:orgit/utils/responsive_utils.dart';

/// Component for displaying a list of groups with authentication-based API calls
class GroupListComponent extends StatelessWidget {
  final List<GroupSearchResponse> groups;
  final bool isLoading;
  final String emptyMessage;
  final Position? userPosition;
  final VoidCallback? onShowMore;
  final bool hasMore;
  final Function(GroupSearchResponse) onGroupTap;

  const GroupListComponent({
    Key? key,
    required this.groups,
    required this.isLoading,
    required this.emptyMessage,
    required this.onGroupTap,
    this.userPosition,
    this.onShowMore,
    this.hasMore = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationService = LocationService();

    return Column(
      children: [
        // Groups
        ...groups.map((group) => _buildGroupCard(group, locationService)),

        // Loading indicator
        if (isLoading)
          Container(
            padding: const EdgeInsets.all(20),
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),

        // Empty state
        if (groups.isEmpty && !isLoading)
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              emptyMessage,
              style: TextStyle(
                color: Colors.white70,
                fontSize: ResponsiveUtils.getBodyFontSize(context),
              ),
              textAlign: TextAlign.center,
            ),
          ),

        // Show more button
        if (hasMore && !isLoading && onShowMore != null)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextButton(
              onPressed: onShowMore,
              child: Text(
                'Zobrazit více',
                style: TextStyle(
                  color: const Color.fromARGB(255, 255, 203, 105),
                  fontSize: ResponsiveUtils.getBodyFontSize(context),
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Builds a group card with distance calculation
  Widget _buildGroupCard(
      GroupSearchResponse group, LocationService locationService) {
    // Calculate distance if user position is available
    String distanceText = '';
    if (userPosition != null) {
      final cityCoords = locationService.getCityCoordinates(group.city_name);
      if (cityCoords != null) {
        final distance = locationService.calculateDistance(
          userPosition!.latitude,
          userPosition!.longitude,
          cityCoords['lat']!,
          cityCoords['lon']!,
        );
        distanceText = '~${distance.round()} km';
      }
    }

    return Cardgroup(
      onTap: () => onGroupTap(group),
      city:
          group.city_name + (distanceText.isNotEmpty ? ' ($distanceText)' : ''),
      primaryColor: const Color.fromARGB(255, 198, 197, 197),
      secondaryColor: Colors.white30,
      image: group.profilepicture.isNotEmpty
          ? Image.network(
              group.profilepicture,
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset('assets/groupIcon.png'),
            )
          : Image.asset('assets/groupIcon.png'),
      name: group.name,
      region: _getCzechRegion(group.city_name),
    );
  }

  /// Gets Czech region by city (simplified version)
  String _getCzechRegion(String city) {
    final regionMap = {
      'děčín': 'Ústecký kraj',
      'praha': 'Hlavní město Praha',
      'brno': 'Jihomoravský kraj',
      'ostrava': 'Moravskoslezský kraj',
      'plzeň': 'Plzeňský kraj',
      'liberec': 'Liberecký kraj',
      'olomouc': 'Olomoucký kraj',
      'ústí nad labem': 'Ústecký kraj',
      'hradec králové': 'Královéhradecký kraj',
      'české budějovice': 'Jihočeský kraj',
    };

    return regionMap[city.toLowerCase()] ?? 'Neznámý kraj';
  }
}
