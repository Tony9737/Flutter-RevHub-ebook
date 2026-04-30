import 'package:flutter/material.dart';
import 'package:flutter_hw3_car_collection/preview_page.dart';
import 'package:flutter_hw3_car_collection/vehicle.dart';
import 'package:flutter_hw3_car_collection/vehicle_card.dart';
import 'package:flutter_hw3_car_collection/vehicle_data.dart';

const Color _gold = Color(0xFFD4AF37);

class ShowRoomPage extends StatefulWidget {
  const ShowRoomPage({super.key});

  @override
  State<ShowRoomPage> createState() => _ShowRoomPageState();
}

class _ShowRoomPageState extends State<ShowRoomPage> with SingleTickerProviderStateMixin {
  final Set<String> _favorites = <String>{};
  List<Vehicle> _shuffledVehicles = [];
  late TabController _tabController;
  int _currentTabIndex = 0;

  // 當前選取要顯示的國家，預設為全部
  late Set<String> _selectedCountries = mockVehicles
      .map((v) => v.spec.country)
      .toSet();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
    
    _shuffleVehicles();
  }

  void _toggleFavorite(Vehicle vehicle) {
    final key = vehicleFavoriteKey(vehicle);
    setState(() {
      if (_favorites.contains(key)) {
        _favorites.remove(key);
      } else {
        _favorites.add(key);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalVehicles = mockVehicles.length;

    final favoriteVehicles = mockVehicles
        .where((v) => _favorites.contains(vehicleFavoriteKey(v)))
        .toList();

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background/main_backgroung.png'),
          fit: BoxFit.cover,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF15110C).withValues(alpha: .7),
            const Color(0xFF090806).withValues(alpha: .7),
          ],
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Revhub',
                  style: TextStyle(
                    color: _gold,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x26D4AF37),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: const Color(0x66D4AF37),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '$totalVehicles Cars',
                    style: const TextStyle(
                      color: Color(0xFFE3D6B2),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: _gold,
              labelColor: _gold,
              unselectedLabelColor: Color(0xFF8A7A54),
              labelStyle: TextStyle(fontWeight: FontWeight.w700),
              tabs: [
                Tab(icon: Icon(Icons.filter)),
                Tab(icon: Icon(Icons.format_list_bulleted)),
                Tab(icon: Icon(Icons.star)),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              PreviewPage(
                favoriteKeys: _favorites,
                onToggleFavorite: _toggleFavorite,
                selectedCountries: _selectedCountries,
              ),
              _ThemedSection(
                child: VehicleCard.fromVehicles(
                  vehicles: _shuffledVehicles,
                  favoriteKeys: _favorites,
                  onToggleFavorite: _toggleFavorite,
                ),
              ),
              _ThemedSection(
                child: VehicleCard.fromVehicles(
                  vehicles: favoriteVehicles,
                  emptyMessage: '目前沒有收藏車輛',
                  favoriteKeys: _favorites,
                  onToggleFavorite: _toggleFavorite,
                ),
              ),
            ],
          ),
          floatingActionButton: _currentTabIndex == 0 || _currentTabIndex == 1
              ? FloatingActionButton(
                  onPressed: _openCountryFilter,
                  backgroundColor: _gold,
                  child: const Icon(Icons.filter_list, color: Colors.black),
                )
              : null,
        ),
      );
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) return;
    setState(() {
      _currentTabIndex = _tabController.index;
    });
    
    if ((_currentTabIndex == 0 || _currentTabIndex == 1) && mounted) {
      _shuffleVehicles();
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose(); // 記得要釋放資源
    super.dispose();
  }

  void _shuffleVehicles() {
    final list = mockVehicles
        .where((v) => _selectedCountries.contains(v.spec.country))
        .toList();
    list.shuffle();
    _shuffledVehicles = list;
  }

  void _openCountryFilter() async {
    final allCountries =
        mockVehicles.map((v) => v.spec.country).toSet().toList()..sort();
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF15110C),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setStateSB) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    '篩選國家',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: _gold,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: allCountries.map((c) {
                      final checked = _selectedCountries.contains(c);
                      return CheckboxListTile(
                        value: checked,
                        title: Text(
                          c,
                          style: const TextStyle(color: Color(0xFFE3D6B2)),
                        ),
                        activeColor: _gold,
                        checkColor: Colors.black,
                        onChanged: (v) => setStateSB(() {
                          setState(() {
                            final updated = Set<String>.from(
                              _selectedCountries,
                            );
                            if (v!) {
                              updated.add(c);
                            } else {
                              updated.remove(c);
                            }
                            _selectedCountries = updated;
                            _shuffleVehicles();
                          });
                        }),
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('關閉', style: TextStyle(color: _gold)),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _ThemedSection extends StatelessWidget {
  const _ThemedSection({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.transparent, child: child);
  }
}
