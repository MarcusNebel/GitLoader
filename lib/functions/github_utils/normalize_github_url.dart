String normalizeGitHubUrl(String input) {
  String url = input.trim();

  // Entferne führendes "https://", "http://", "github.com/" oder "www.github.com/"
  url = url.replaceFirst(RegExp(r'^(https?:\/\/)?(www\.)?github\.com\/'), '');
  url = url.replaceFirst(RegExp(r'^\/'), '');

  // .git anhängen, falls nicht vorhanden
  if (!url.endsWith('.git')) {
    url = '$url.git';
  }

  return 'https://github.com/$url';
}
