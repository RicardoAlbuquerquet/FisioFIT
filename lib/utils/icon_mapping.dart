import 'package:flutter/material.dart';

final Map<String, IconData> iconsMap = {
  'sports_soccer': Icons.sports_soccer,
  'sports_gymnastics': Icons.sports_gymnastics,
  'hiking': Icons.hiking,
  'accessible_forward': Icons.accessible_forward,
  'pool': Icons.pool,
  'accessibility_new': Icons.accessibility_new,
  'flash_on': Icons.flash_on,
  'elderly': Icons.elderly,
  'fitness_center_rounded': Icons.fitness_center_rounded,
  'bike_scooter_sharp': Icons.bike_scooter_sharp,
  'bike_scooter_rounded': Icons.bike_scooter_rounded,
  'sports_handball': Icons.sports_handball,
  'run_circle': Icons.run_circle,
  'circle': Icons.circle,
  'pedal_bike': Icons.pedal_bike,
  'directions_bike': Icons.directions_bike,
  'directions_run': Icons.directions_run,
};

IconData getIcon(String name) {
  return iconsMap[name] ?? Icons.help_outline;
}
