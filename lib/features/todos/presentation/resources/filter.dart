enum Filter {
  all('All'),
  active('Active'),
  completed('Completed');

  const Filter(this.label);

  final String label;
}