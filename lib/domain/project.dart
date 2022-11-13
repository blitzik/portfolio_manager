class Project {
  final int? id;
  final String name;
  final String coin;

  Project(this.name, this.coin, {this.id});

  Project copyWith({
    String? name,
    String? coin
  }) {
    return Project(
      name ?? this.name,
      coin ?? this.coin,
      id: id
    );
  }
}