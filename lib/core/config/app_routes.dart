class AppRoutes {
  static const String homeName = 'home';
  static const String homePath = '/';

  static const String categoriesName = 'categories';
  static const String categoriesPaths = '/categories';

  static const String event = 'event';
  static const String userPath = '/event/:id';

  static String buildUserPath(String id) => '/user/$id';
}
