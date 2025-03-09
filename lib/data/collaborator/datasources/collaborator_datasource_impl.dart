import 'package:go_work/data/collaborator/models/collaborator_model.dart';
import 'package:go_work/data/core/datasources/local/sqflite/app_database.dart';
import 'package:go_work/domain/collaborator/datasources/collaborator_datasource.dart';

class CollaboratorDataSourceImpl implements CollaboratorDataSource {
  final AppDatabase databaseHelper;

  CollaboratorDataSourceImpl({required this.databaseHelper});

  @override
  Future<int> insertCollaborator(CollaboratorModel collaborator) async {
    final db = await databaseHelper.database;
    return await db.insert('Collaborator', collaborator.toJson());
  }

  @override
  Future<List<CollaboratorModel>> getCollaborators() async {
    final db = await databaseHelper.database;
    final maps = await db.query('Collaborator');
    return maps.map((map) => CollaboratorModel.fromJson(map)).toList();
  }

  @override
  Future<CollaboratorModel?> getCollaboratorById(int id) async {
    final db = await databaseHelper.database;
    final maps = await db.query(
      'Collaborator',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return CollaboratorModel.fromJson(maps.first);
    }
    return null;
  }

  @override
  Future<void> updateCollaborator(CollaboratorModel collaborator) async {
    final db = await databaseHelper.database;
    await db.update(
      'Collaborator',
      collaborator.toJson(),
      where: 'id = ?',
      whereArgs: [collaborator.id],
    );
  }

  @override
  Future<void> deleteCollaborator(int id) async {
    final db = await databaseHelper.database;
    await db.delete(
      'Collaborator',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
