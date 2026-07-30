/// Destinations principales affichées dans la barre de navigation flottante.
///
/// L'ordre de l'enum définit uniquement l'ordre des branches de GoRouter.
/// La [FloatingNavBar] choisit librement son ordre d'affichage grâce à cette
/// identité stable.
enum AppTab {
  discover(path: '/discover', routeName: 'discover'),
  soon(path: '/soon', routeName: 'soon'),
  calendar(path: '/calendar', routeName: 'calendar'),
  profile(path: '/profile', routeName: 'profile');

  const AppTab({required this.path, required this.routeName});

  final String path;
  final String routeName;
}
