// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tables.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class FavoriteData extends DataClass implements Insertable<FavoriteData> {
  final String id;
  final String content;
  final String permalink;
  final String sourceUrl;
  FavoriteData(
      {@required this.id,
      @required this.content,
      @required this.permalink,
      @required this.sourceUrl});
  factory FavoriteData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return FavoriteData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      content:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}content']),
      permalink: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}permalink']),
      sourceUrl: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}source_url']),
    );
  }
  factory FavoriteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return FavoriteData(
      id: serializer.fromJson<String>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      permalink: serializer.fromJson<String>(json['permalink']),
      sourceUrl: serializer.fromJson<String>(json['sourceUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'content': serializer.toJson<String>(content),
      'permalink': serializer.toJson<String>(permalink),
      'sourceUrl': serializer.toJson<String>(sourceUrl),
    };
  }

  @override
  FavoriteCompanion createCompanion(bool nullToAbsent) {
    return FavoriteCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      permalink: permalink == null && nullToAbsent
          ? const Value.absent()
          : Value(permalink),
      sourceUrl: sourceUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceUrl),
    );
  }

  FavoriteData copyWith(
          {String id, String content, String permalink, String sourceUrl}) =>
      FavoriteData(
        id: id ?? this.id,
        content: content ?? this.content,
        permalink: permalink ?? this.permalink,
        sourceUrl: sourceUrl ?? this.sourceUrl,
      );
  @override
  String toString() {
    return (StringBuffer('FavoriteData(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('permalink: $permalink, ')
          ..write('sourceUrl: $sourceUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(content.hashCode, $mrjc(permalink.hashCode, sourceUrl.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is FavoriteData &&
          other.id == this.id &&
          other.content == this.content &&
          other.permalink == this.permalink &&
          other.sourceUrl == this.sourceUrl);
}

class FavoriteCompanion extends UpdateCompanion<FavoriteData> {
  final Value<String> id;
  final Value<String> content;
  final Value<String> permalink;
  final Value<String> sourceUrl;
  const FavoriteCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.permalink = const Value.absent(),
    this.sourceUrl = const Value.absent(),
  });
  FavoriteCompanion.insert({
    @required String id,
    @required String content,
    @required String permalink,
    @required String sourceUrl,
  })  : id = Value(id),
        content = Value(content),
        permalink = Value(permalink),
        sourceUrl = Value(sourceUrl);
  FavoriteCompanion copyWith(
      {Value<String> id,
      Value<String> content,
      Value<String> permalink,
      Value<String> sourceUrl}) {
    return FavoriteCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      permalink: permalink ?? this.permalink,
      sourceUrl: sourceUrl ?? this.sourceUrl,
    );
  }
}

class $FavoriteTable extends Favorite
    with TableInfo<$FavoriteTable, FavoriteData> {
  final GeneratedDatabase _db;
  final String _alias;
  $FavoriteTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false,
        $customConstraints: 'UNIQUE');
  }

  final VerificationMeta _contentMeta = const VerificationMeta('content');
  GeneratedTextColumn _content;
  @override
  GeneratedTextColumn get content => _content ??= _constructContent();
  GeneratedTextColumn _constructContent() {
    return GeneratedTextColumn(
      'content',
      $tableName,
      false,
    );
  }

  final VerificationMeta _permalinkMeta = const VerificationMeta('permalink');
  GeneratedTextColumn _permalink;
  @override
  GeneratedTextColumn get permalink => _permalink ??= _constructPermalink();
  GeneratedTextColumn _constructPermalink() {
    return GeneratedTextColumn(
      'permalink',
      $tableName,
      false,
    );
  }

  final VerificationMeta _sourceUrlMeta = const VerificationMeta('sourceUrl');
  GeneratedTextColumn _sourceUrl;
  @override
  GeneratedTextColumn get sourceUrl => _sourceUrl ??= _constructSourceUrl();
  GeneratedTextColumn _constructSourceUrl() {
    return GeneratedTextColumn(
      'source_url',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, content, permalink, sourceUrl];
  @override
  $FavoriteTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'favorite';
  @override
  final String actualTableName = 'favorite';
  @override
  VerificationContext validateIntegrity(FavoriteCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.content.present) {
      context.handle(_contentMeta,
          content.isAcceptableValue(d.content.value, _contentMeta));
    } else if (content.isRequired && isInserting) {
      context.missing(_contentMeta);
    }
    if (d.permalink.present) {
      context.handle(_permalinkMeta,
          permalink.isAcceptableValue(d.permalink.value, _permalinkMeta));
    } else if (permalink.isRequired && isInserting) {
      context.missing(_permalinkMeta);
    }
    if (d.sourceUrl.present) {
      context.handle(_sourceUrlMeta,
          sourceUrl.isAcceptableValue(d.sourceUrl.value, _sourceUrlMeta));
    } else if (sourceUrl.isRequired && isInserting) {
      context.missing(_sourceUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  FavoriteData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return FavoriteData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(FavoriteCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.content.present) {
      map['content'] = Variable<String, StringType>(d.content.value);
    }
    if (d.permalink.present) {
      map['permalink'] = Variable<String, StringType>(d.permalink.value);
    }
    if (d.sourceUrl.present) {
      map['source_url'] = Variable<String, StringType>(d.sourceUrl.value);
    }
    return map;
  }

  @override
  $FavoriteTable createAlias(String alias) {
    return $FavoriteTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $FavoriteTable _favorite;
  $FavoriteTable get favorite => _favorite ??= $FavoriteTable(this);
  FavoriteDao _favoriteDao;
  FavoriteDao get favoriteDao => _favoriteDao ??= FavoriteDao(this as Database);
  Selectable<int> countFavQuery(String id) {
    return customSelectQuery('SELECT COUNT(*) FROM favorite WHERE id = :id',
        variables: [Variable.withString(id)],
        readsFrom: {favorite}).map((QueryRow row) => row.readInt('COUNT(*)'));
  }

  Future<List<int>> countFav(String id) {
    return countFavQuery(id).get();
  }

  Stream<List<int>> watchCountFav(String id) {
    return countFavQuery(id).watch();
  }

  @override
  List<TableInfo> get allTables => [favorite];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$FavoriteDaoMixin on DatabaseAccessor<Database> {
  $FavoriteTable get favorite => db.favorite;
}
