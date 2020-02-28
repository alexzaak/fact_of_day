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

  void addFavorite({String content, String permalink, String sourceUrl}) {
    final _entry = FavoriteCompanion(
        id: Value(content.hashCode.toString()),
        content: Value(content),
        permalink: Value(permalink),
        sourceUrl: Value(sourceUrl));
    into(favorite).insert(_entry);
  }

  void deleteFavorite({String content}) {
    final id = content.hashCode.toString();

    (delete(favorite)..where((fav) => fav.id.equals(id))).go();
  }

  Stream<FavoriteData> isFavorite(String content) {
    final id = content.hashCode.toString();

    return (select(favorite)..where((fav) => fav.id.equals(id))).watchSingle();
  }
}
