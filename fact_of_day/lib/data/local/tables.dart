import 'package:moor_flutter/moor_flutter.dart';

part 'tables.g.dart';

class Favorite extends Table {
  TextColumn get id => text().customConstraint("UNIQUE")();

  TextColumn get content => text()();

  TextColumn get permalink => text()();

  TextColumn get sourceUrl => text()();
}

@UseMoor(
  tables: [Favorite],
  daos: [FavoriteDao],
)
class Database extends _$Database {
  Database()
      : super(FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
        ));

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [Favorite])
class FavoriteDao extends DatabaseAccessor<Database> with _$FavoriteDaoMixin {
  FavoriteDao(Database db) : super(db);

  Stream<List<FavoriteData>> get favoriteList => select(favorite).watch();

  void addFavorite(
      {String id, String content, String iconUrl, String sourceUrl}) {
    final _entry = FavoriteCompanion(
        id: Value(id),
        content: Value(content),
        permalink: Value(sourceUrl),
        sourceUrl: Value(sourceUrl));
    into(favorite).insert(_entry);
  }

  void deleteFavorite({String id}) {
    (delete(favorite)..where((fav) => fav.id.equals(id))).go();
  }

  Stream<FavoriteData> isFavorite(String id) {
    return (select(favorite)..where((fav) => fav.id.equals(id))).watchSingle();
  }
}
