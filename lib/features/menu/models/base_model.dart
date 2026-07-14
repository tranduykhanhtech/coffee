class BaseModel {
  final String id;
  final DateTime createdAt = DateTime.now();
  final DateTime? updatedAt;

  BaseModel(this.id, this.updatedAt);
}