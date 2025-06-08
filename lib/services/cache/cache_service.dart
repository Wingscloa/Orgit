import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  // Cache klíče
  static const String _profileCompleteKey = 'user_profile_complete';
  static const String _inGroupKey = 'user_in_group';
  static const String _cacheTimestampKey = 'cache_timestamp';

  // Auth cache klíče
  static const String _userLoggedInKey = 'user_logged_in';
  static const String _userUidKey = 'user_uid';
  static const String _userEmailKey = 'user_email';
  static const String _authTimestampKey = 'auth_timestamp';

  // Navigation cache klíče
  static const String _lastPageKey = 'last_page';
  static const String _wasLoggedInKey = 'was_logged_in';
  static const String _lastSessionTimeKey = 'last_session_time';
  static const String _navigationTimestampKey = 'navigation_timestamp';

  // Offline cache klíče
  static const String _offlineUserLoggedInKey = 'offline_user_logged_in';
  static const String _offlineUserDestinationKey = 'offline_user_destination';
  static const String _offlineProfileCompleteKey = 'offline_profile_complete';
  static const String _offlineInGroupKey = 'offline_in_group';
  static const String _offlineTimestampKey = 'offline_timestamp';

  static const int _cacheValidityHours = 24; // Cache platí 24 hodin
  static const int _authCacheValidityHours = 168; // Auth cache platí 7 dní

  // Singleton pattern
  static CacheService? _instance;
  static CacheService get instance {
    _instance ??= CacheService._internal();
    return _instance!;
  }

  CacheService._internal();
  // Základní cache metody pro bool hodnoty
  Future<void> _setCacheValue(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
    await prefs.setInt(
        _cacheTimestampKey, DateTime.now().millisecondsSinceEpoch);
    log('Cache set: $key = $value');
  }

  // Cache metody pro String hodnoty
  Future<void> _setCacheStringValue(String key, String value,
      {bool isAuth = false}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);

    final timestampKey = isAuth ? _authTimestampKey : _cacheTimestampKey;
    await prefs.setInt(timestampKey, DateTime.now().millisecondsSinceEpoch);
    log('Cache set: $key = $value');
  }

  Future<String?> _getCacheStringValue(String key,
      {bool isAuth = false}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final timestampKey = isAuth ? _authTimestampKey : _cacheTimestampKey;
      final validityHours =
          isAuth ? _authCacheValidityHours : _cacheValidityHours;

      final timestamp = prefs.getInt(timestampKey);

      if (timestamp == null) {
        log('No cache timestamp found for $key');
        return null;
      }

      final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      final difference = now.difference(cacheTime).inHours;

      if (difference > validityHours) {
        log('Cache expired for $key (${difference}h old)');
        if (isAuth) {
          await _clearAuthCache();
        } else {
          await _clearCache();
        }
        return null;
      }

      final value = prefs.getString(key);
      log('Cache get: $key = $value (${difference}h old)');
      return value;
    } catch (e) {
      log('Error reading cache for $key: $e');
      return null;
    }
  }

  Future<bool?> _getCacheValue(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final timestamp = prefs.getInt(_cacheTimestampKey);

      if (timestamp == null) {
        log('No cache timestamp found');
        return null;
      }

      final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      final difference = now.difference(cacheTime).inHours;

      if (difference > _cacheValidityHours) {
        log('Cache expired (${difference}h old)');
        await _clearCache();
        return null;
      }

      final value = prefs.getBool(key);
      log('Cache get: $key = $value (${difference}h old)');
      return value;
    } catch (e) {
      log('Error reading cache: $e');
      return null;
    }
  }

  Future<void> _clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_profileCompleteKey);
      await prefs.remove(_inGroupKey);
      await prefs.remove(_cacheTimestampKey);
      log('Cache cleared');
    } catch (e) {
      log('Error clearing cache: $e');
    }
  }

  Future<void> _clearAuthCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userLoggedInKey);
      await prefs.remove(_userUidKey);
      await prefs.remove(_userEmailKey);
      await prefs.remove(_authTimestampKey);
      log('Auth cache cleared');
    } catch (e) {
      log('Error clearing auth cache: $e');
    }
  }

  Future<void> _clearNavigationCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_lastPageKey);
      await prefs.remove(_wasLoggedInKey);
      await prefs.remove(_lastSessionTimeKey);
      await prefs.remove(_navigationTimestampKey);
      log('Navigation cache cleared');
    } catch (e) {
      log('Error clearing navigation cache: $e');
    }
  }

  Future<bool> _hasValidCache() async {
    final profileComplete = await _getCacheValue(_profileCompleteKey);
    final inGroup = await _getCacheValue(_inGroupKey);
    return profileComplete != null && inGroup != null;
  }

  // Veřejné metody pro práci s profile complete statusem
  Future<bool?> getProfileCompleteStatus() async {
    return await _getCacheValue(_profileCompleteKey);
  }

  Future<void> setProfileCompleteStatus(bool isComplete) async {
    await _setCacheValue(_profileCompleteKey, isComplete);
    log('Profile complete status updated in cache: $isComplete');
  }

  // Veřejné metody pro práci s group membership statusem
  Future<bool?> getInGroupStatus() async {
    return await _getCacheValue(_inGroupKey);
  }

  Future<void> setInGroupStatus(bool inGroup) async {
    await _setCacheValue(_inGroupKey, inGroup);
    log('In group status updated in cache: $inGroup');
  }

  // Metody pro kontrolu cache validity
  Future<bool> hasValidCache() async {
    return await _hasValidCache();
  }

  Future<bool> hasValidProfileCache() async {
    final profileComplete = await _getCacheValue(_profileCompleteKey);
    return profileComplete != null;
  }

  Future<bool> hasValidGroupCache() async {
    final inGroup = await _getCacheValue(_inGroupKey);
    return inGroup != null;
  }

  // Metoda pro kompletní vymazání cache
  Future<void> clearAllCache() async {
    await _clearCache();
    await _clearAuthCache();
    await _clearNavigationCache();
    log('All cache cleared');
  }

  // Auth cache metody
  Future<bool?> getUserLoggedInStatus() async {
    final cachedStatus =
        await _getCacheStringValue(_userLoggedInKey, isAuth: true);
    if (cachedStatus != null) {
      return cachedStatus.toLowerCase() == 'true';
    }
    return null;
  }

  Future<void> setUserLoggedInStatus(bool isLoggedIn) async {
    await _setCacheStringValue(_userLoggedInKey, isLoggedIn.toString(),
        isAuth: true);
    log('User logged in status updated in cache: $isLoggedIn');
  }

  Future<String?> getUserUid() async {
    return await _getCacheStringValue(_userUidKey, isAuth: true);
  }

  Future<void> setUserUid(String uid) async {
    await _setCacheStringValue(_userUidKey, uid, isAuth: true);
    log('User UID updated in cache: $uid');
  }

  Future<String?> getUserEmail() async {
    return await _getCacheStringValue(_userEmailKey, isAuth: true);
  }

  Future<void> setUserEmail(String email) async {
    await _setCacheStringValue(_userEmailKey, email, isAuth: true);
    log('User email updated in cache: $email');
  }

  // Metody pro celé user info najednou
  Future<Map<String, dynamic>> getUserInfo() async {
    final isLoggedIn = await getUserLoggedInStatus();
    final uid = await getUserUid();
    final email = await getUserEmail();

    return {
      'isLoggedIn': isLoggedIn,
      'uid': uid,
      'email': email,
    };
  }

  Future<void> setUserInfo({
    required bool isLoggedIn,
    required String uid,
    String? email,
  }) async {
    await setUserLoggedInStatus(isLoggedIn);
    await setUserUid(uid);
    if (email != null) {
      await setUserEmail(email);
    }
    log('Complete user info updated in cache');
  }

  // Kontrola validity auth cache
  Future<bool> hasValidAuthCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final timestamp = prefs.getInt(_authTimestampKey);

      if (timestamp == null) return false;

      final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      final difference = now.difference(cacheTime).inHours;

      return difference <= _authCacheValidityHours;
    } catch (e) {
      log('Error checking auth cache validity: $e');
      return false;
    }
  }

  // Metoda pro získání obou statusů najednou
  Future<Map<String, bool?>> getAllStatuses() async {
    final profileComplete = await _getCacheValue(_profileCompleteKey);
    final inGroup = await _getCacheValue(_inGroupKey);

    return {
      'profileComplete': profileComplete,
      'inGroup': inGroup,
    };
  }

  // Metoda pro kontrolu jestli jsou oba statusy true
  Future<bool> areBothStatusesTrue() async {
    final statuses = await getAllStatuses();
    final profileComplete = statuses['profileComplete'];
    final inGroup = statuses['inGroup'];

    return profileComplete == true && inGroup == true;
  }

  // ========== NAVIGATION CACHE METHODS ==========

  /// Uloží poslední stránku, kde byl uživatel
  Future<void> setLastPage(String pageName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastPageKey, pageName);
    await prefs.setInt(
        _navigationTimestampKey, DateTime.now().millisecondsSinceEpoch);
    log('💾 Navigation Cache: Saved last page as $pageName');
  }

  /// Získá poslední stránku
  Future<String?> getLastPage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final timestamp = prefs.getInt(_navigationTimestampKey);

      if (timestamp == null) {
        log('💾 No navigation timestamp found');
        return null;
      }

      final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      final difference = now.difference(cacheTime).inHours;

      // Navigation cache platí 72 hodin (3 dny)
      if (difference > 72) {
        log('💾 Navigation cache expired (${difference}h old)');
        await _clearNavigationCache();
        return null;
      }

      final lastPage = prefs.getString(_lastPageKey);
      log('💾 Navigation Cache: Retrieved last page: ${lastPage ?? 'none'} (${difference}h old)');
      return lastPage;
    } catch (e) {
      log('Error reading navigation cache: $e');
      return null;
    }
  }

  /// Uloží stav zda byl uživatel přihlášen
  Future<void> setWasLoggedIn(bool wasLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_wasLoggedInKey, wasLoggedIn);
    await prefs.setInt(
        _lastSessionTimeKey, DateTime.now().millisecondsSinceEpoch);
    log('💾 Navigation Cache: Saved was logged in status: $wasLoggedIn');
  }

  /// Získá stav zda byl uživatel přihlášen
  Future<bool> getWasLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final wasLoggedIn = prefs.getBool(_wasLoggedInKey) ?? false;
      log('💾 Navigation Cache: Retrieved was logged in status: $wasLoggedIn');
      return wasLoggedIn;
    } catch (e) {
      log('Error reading was logged in status: $e');
      return false;
    }
  }

  /// Získá čas poslední session
  Future<DateTime?> getLastSessionTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final timestamp = prefs.getInt(_lastSessionTimeKey);
      if (timestamp != null) {
        return DateTime.fromMillisecondsSinceEpoch(timestamp);
      }
      return null;
    } catch (e) {
      log('Error reading last session time: $e');
      return null;
    }
  }

  /// Kontroluje jestli byla session nedávno (default: 24 hodin)
  Future<bool> isRecentSession({int maxHours = 24}) async {
    final lastSession = await getLastSessionTime();
    if (lastSession == null) return false;

    final now = DateTime.now();
    final difference = now.difference(lastSession);
    final isRecent = difference.inHours < maxHours;

    log('💾 Session check: ${difference.inHours}h ago, recent: $isRecent');
    return isRecent;
  }

  /// Získá všechny navigation informace najednou
  Future<Map<String, dynamic>> getNavigationState() async {
    final lastPage = await getLastPage();
    final wasLoggedIn = await getWasLoggedIn();
    final lastSession = await getLastSessionTime();
    final isRecent = await isRecentSession();

    return {
      'lastPage': lastPage,
      'wasLoggedIn': wasLoggedIn,
      'lastSession': lastSession,
      'isRecentSession': isRecent,
    };
  }

  /// Vyčistí vše při odhlášení
  Future<void> clearNavigationCacheOnLogout() async {
    await setWasLoggedIn(false);
    await _clearNavigationCache();
    log('🚪 Navigation cache cleared on logout');
  }

  // ========== OFFLINE CACHE METHODS ==========

  /// Uloží kompletní offline stav pro případ nedostupnosti internetu
  Future<void> saveOfflineUserState({
    required bool isLoggedIn,
    required String destination,
    required bool profileComplete,
    required bool inGroup,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_offlineUserLoggedInKey, isLoggedIn);
    await prefs.setString(_offlineUserDestinationKey, destination);
    await prefs.setBool(_offlineProfileCompleteKey, profileComplete);
    await prefs.setBool(_offlineInGroupKey, inGroup);
    await prefs.setInt(
        _offlineTimestampKey, DateTime.now().millisecondsSinceEpoch);

    log('💾 Offline Cache: Saved complete user state - logged in: $isLoggedIn, destination: $destination');
  }

  /// Získá offline stav uživatele
  Future<Map<String, dynamic>?> getOfflineUserState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final timestamp = prefs.getInt(_offlineTimestampKey);

      if (timestamp == null) {
        log('💾 No offline cache timestamp found');
        return null;
      }

      final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      final difference = now.difference(cacheTime).inDays;

      // Offline cache platí 7 dní
      if (difference > 7) {
        log('💾 Offline cache expired (${difference} days old)');
        await _clearOfflineCache();
        return null;
      }

      final isLoggedIn = prefs.getBool(_offlineUserLoggedInKey);
      final destination = prefs.getString(_offlineUserDestinationKey);
      final profileComplete = prefs.getBool(_offlineProfileCompleteKey);
      final inGroup = prefs.getBool(_offlineInGroupKey);

      if (isLoggedIn == null ||
          destination == null ||
          profileComplete == null ||
          inGroup == null) {
        log('💾 Incomplete offline cache data');
        return null;
      }

      log('💾 Offline Cache: Retrieved user state - logged in: $isLoggedIn, destination: $destination (${difference} days old)');

      return {
        'isLoggedIn': isLoggedIn,
        'destination': destination,
        'profileComplete': profileComplete,
        'inGroup': inGroup,
        'cacheAge': difference,
      };
    } catch (e) {
      log('Error reading offline cache: $e');
      return null;
    }
  }

  /// Vyčistí offline cache
  Future<void> _clearOfflineCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_offlineUserLoggedInKey);
      await prefs.remove(_offlineUserDestinationKey);
      await prefs.remove(_offlineProfileCompleteKey);
      await prefs.remove(_offlineInGroupKey);
      await prefs.remove(_offlineTimestampKey);
      log('💾 Offline cache cleared');
    } catch (e) {
      log('Error clearing offline cache: $e');
    }
  }

  /// Kontroluje jestli má platný offline cache
  Future<bool> hasValidOfflineCache() async {
    final offlineState = await getOfflineUserState();
    return offlineState != null;
  }

  /// Vypíše VŠECHNY proměnné v SharedPreferences
  Future<void> debugAllSharedPreferences() async {
    log('🗂️ ========== ALL SHARED PREFERENCES VARIABLES ==========');

    try {
      final prefs = await SharedPreferences.getInstance();
      final allKeys = prefs.getKeys();

      if (allKeys.isEmpty) {
        log('📭 SharedPreferences is EMPTY - no variables stored');
        log('🗂️ ========== END ==========');
        return;
      }

      log('📊 Total stored variables: ${allKeys.length}');
      log('');

      // Seřadí klíče alfabeticky pro lepší čitelnost
      final sortedKeys = allKeys.toList()..sort();

      for (String key in sortedKeys) {
        final value = prefs.get(key);
        String valueString;
        String typeString;

        if (value == null) {
          valueString = 'NULL';
          typeString = 'null';
        } else if (value is bool) {
          valueString = value.toString();
          typeString = 'bool';
        } else if (value is int) {
          valueString = value.toString();
          typeString = 'int';

          // Pokud je to timestamp, přidej i lidsky čitelný datum
          if (key.contains('timestamp') || key.contains('time')) {
            try {
              final date = DateTime.fromMillisecondsSinceEpoch(value);
              valueString += ' (${date.toString()})';
            } catch (e) {
              // Není timestamp
            }
          }
        } else if (value is double) {
          valueString = value.toString();
          typeString = 'double';
        } else if (value is String) {
          valueString = '"$value"';
          typeString = 'String';
        } else if (value is List<String>) {
          valueString = value.toString();
          typeString = 'List<String>';
        } else {
          valueString = value.toString();
          typeString = value.runtimeType.toString();
        }

        log('   $key: $valueString [$typeString]');
      }

      log('');
      log('🗂️ ========== END ALL SHARED PREFERENCES ==========');
    } catch (e) {
      log('❌ Error reading SharedPreferences: $e');
    }
  }
}
