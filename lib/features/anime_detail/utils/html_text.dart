/// Transforme le HTML simple renvoyé par AniList en texte lisible.
///
/// AniList utilise principalement les balises `<br>` et quelques balises de
/// mise en forme. Les retours sont conservés avant de retirer les balises.
String stripHtml(String html) {
  var text = html
      .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
      .replaceAll(RegExp(r'</p\s*>', caseSensitive: false), '\n\n')
      .replaceAll(RegExp(r'<[^>]*>'), '');

  text = text
      .replaceAll('&amp;', '&')
      .replaceAll('&quot;', '"')
      .replaceAll('&#39;', "'")
      .replaceAll('&apos;', "'")
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('&nbsp;', ' ');

  return text.replaceAll(RegExp(r'\n{3,}'), '\n\n').trim();
}
