import 'dart:convert';

/// Annotation to generate route
class FFRoute {
  const FFRoute({
    required this.name,
    this.showStatusBar = true,
    this.routeName = '',
    this.pageRouteType,
    this.description = '',
    this.exts,
    this.argumentImports,
    this.codes,
  });

  static const String notFoundName = '404';
  static const String notFoundRouteName = '404_page';

  /// The name of the route (e.g., "/settings").
  ///
  /// If null, the route is anonymous.
  final String name;

  /// Whether show status bar.
  final bool showStatusBar;

  /// The route name to track page
  final String routeName;

  /// The type of page route
  final PageRouteType? pageRouteType;

  /// The description of route
  final String description;

  /// The extend arguments
  final Map<String, dynamic>? exts;

  /// The imports of arguments.
  /// For example, class/enum argument should provide import url.
  /// argumentImports: <String>[
  ///   'import \'package:example/src/model/test_model.dart\';',
  ///   'import \'package:example/src/model/test_model1.dart\';'
  /// ],
  final List<String>? argumentImports;

  /// to support something can't write in annotation
  /// it will be hadnled as a code when generate route
  final Map<String, String>? codes;

  @override
  String toString() {
    return json.encode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'showStatusBar': showStatusBar,
        'routeName': routeName,
        'pageRouteType': pageRouteType,
        'description': description,
        'exts': exts,
        'argumentImports': argumentImports,
        'codes': codes,
      };

  /// get values as constructor parameters order
  /// you should enable --super-arguments and --argument-names
  static List<dynamic> getArgumentValues(Map<dynamic, dynamic> arguments) {
    assert(arguments.containsKey(argumentNames), '');
    final List<dynamic> keys = arguments[argumentNames] as List<dynamic>;
    final List<dynamic> values = <dynamic>[];
    for (final dynamic key in keys) {
      assert(arguments.containsKey(key));
      values.add(arguments[key]);
    }
    return values;
  }
}

enum PageRouteType {
  material,
  cupertino,
  transparent,
}

const String constructorName = 'constructorName';

const String argumentNames = 'argumentNames';
