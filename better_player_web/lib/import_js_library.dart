import 'dart:html' as html;

/// This is an implementation of the `import_js_library` plugin that is used
/// until that plugin is migrated to null safety.
/// See https://github.com/florent37/flutter_web_import_js_library/pull/6#issuecomment-735349208.

/// Imports a JS script file from the given [url] given the relative
/// [flutterPluginName].
String _libraryUrl(String url, String? pluginName) {
  if (pluginName == null) {
    return url;
  }
  if (url.startsWith('./')) {
    url = url.replaceFirst('./', '');
    return './assets/packages/$pluginName/$url';
  }
  if (url.startsWith('assets/')) {
    return './assets/packages/$pluginName/$url';
  } else {
    return url;
  }
}

/// Injects a bunch of libraries in the <head> and returns a
/// Future that resolves when all load.
Future<void> importCSSLibraries(List<String> libraries) {
  final loading = <Future<void>>[];
  final head = html.querySelector('head')!;

  for (final library in libraries) {
    final url = _libraryUrl(library, 'better_player_web');
    if (!_isLoadedCss(head, url)) {
      final link = html.LinkElement()
        ..href = url
        ..rel = 'stylesheet';
      head.children.add(link);
      loading.add(link.onLoad.first);
    }
  }

  return Future.wait(loading);
}

/// Injects a bunch of libraries in the <head> and returns a
/// Future that resolves when all load.
Future<void> importJSLibraries(List<String> libraries) {
  final loading = <Future<void>>[];
  final head = html.querySelector('head')!;

  for (final library in libraries) {
    final url = _libraryUrl(library, 'better_player_web');
    if (!_isLoaded(head, url)) {
      final script = html.ScriptElement()
        ..src = url
        ..type = 'text/javascript'
        ..charset = 'utf-8'
        ..defer = true
        ..async = true;
      head.children.add(script);
      loading.add(script.onLoad.first);
    }
  }

  return Future.wait(loading);
}

bool _isLoaded(html.Element head, String url) {
  if (url.startsWith('./')) {
    url = url.replaceFirst('./', '');
  }
  for (final element in head.children) {
    if (element is html.ScriptElement) {
      if (element.src.endsWith(url)) {
        return true;
      }
    }
  }
  return false;
}

bool _isLoadedCss(html.Element head, String url) {
  if (url.startsWith('./')) {
    url = url.replaceFirst('./', '');
  }
  for (final element in head.children) {
    if (element is html.LinkElement) {
      if (element.href.endsWith(url)) {
        return true;
      }
    }
  }
  return false;
}
