class PossibleAnswer {
  final String label;
  final String? description;
  final int id;

  PossibleAnswer({
    required this.label,
    required this.id,
    this.description,
  })  : assert(label.isNotEmpty),
        assert(id >= 0);
}
