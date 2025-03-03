import 'package:go_work/data/collaborator/models/collaborator_model.dart';
import 'package:go_work/data/core/datasources/local/app_database.dart';

class CollaboratorDataSource {
  final AppDatabase databaseHelper;

  CollaboratorDataSource({required this.databaseHelper});

  Future<int> insertCollaborator(CollaboratorModel collaborator) async {
    final db = await databaseHelper.database;
    return await db.insert('Collaborator', collaborator.toMap());
  }

  Future<List<CollaboratorModel>> getCollaborators() async {
    final db = await databaseHelper.database;
    final maps = await db.query('Collaborator');
    return maps.map((map) => CollaboratorModel.fromMap(map)).toList();
  }

  Future<CollaboratorModel?> getCollaboratorById(int id) async {
    final db = await databaseHelper.database;
    final maps = await db.query(
      'Collaborator',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return CollaboratorModel.fromMap(maps.first);
    }
    return null;
  }

  Future<void> updateCollaborator(CollaboratorModel collaborator) async {
    final db = await databaseHelper.database;
    await db.update(
      'Collaborator',
      collaborator.toMap(),
      where: 'id = ?',
      whereArgs: [collaborator.id],
    );
  }

  Future<void> deleteCollaborator(int id) async {
    final db = await databaseHelper.database;
    await db.delete(
      'Collaborator',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
