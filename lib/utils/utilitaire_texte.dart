/// Méthode utilitaire permettant de tronquer un texte en fonction d'une longueur maximale
/// Tronque le texte en le finissant par '...'
String tronquerTexte(String texte, int longueurMax) {
  if (texte.length > longueurMax) {
    return '${texte.substring(0, longueurMax)}...';
  }
  return texte;
}
