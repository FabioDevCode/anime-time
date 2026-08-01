// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $FavoriteAnimeTable extends FavoriteAnime
    with TableInfo<$FavoriteAnimeTable, FavoriteAnimeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteAnimeTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _animeIdMeta = const VerificationMeta(
    'animeId',
  );
  @override
  late final GeneratedColumn<int> animeId = GeneratedColumn<int>(
    'anime_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleRomajiMeta = const VerificationMeta(
    'titleRomaji',
  );
  @override
  late final GeneratedColumn<String> titleRomaji = GeneratedColumn<String>(
    'title_romaji',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleEnglishMeta = const VerificationMeta(
    'titleEnglish',
  );
  @override
  late final GeneratedColumn<String> titleEnglish = GeneratedColumn<String>(
    'title_english',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleNativeMeta = const VerificationMeta(
    'titleNative',
  );
  @override
  late final GeneratedColumn<String> titleNative = GeneratedColumn<String>(
    'title_native',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverImageMeta = const VerificationMeta(
    'coverImage',
  );
  @override
  late final GeneratedColumn<String> coverImage = GeneratedColumn<String>(
    'cover_image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bannerImageMeta = const VerificationMeta(
    'bannerImage',
  );
  @override
  late final GeneratedColumn<String> bannerImage = GeneratedColumn<String>(
    'banner_image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _seasonMeta = const VerificationMeta('season');
  @override
  late final GeneratedColumn<String> season = GeneratedColumn<String>(
    'season',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _seasonYearMeta = const VerificationMeta(
    'seasonYear',
  );
  @override
  late final GeneratedColumn<int> seasonYear = GeneratedColumn<int>(
    'season_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    animeId,
    titleRomaji,
    titleEnglish,
    titleNative,
    coverImage,
    bannerImage,
    status,
    season,
    seasonYear,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_anime';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteAnimeData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('anime_id')) {
      context.handle(
        _animeIdMeta,
        animeId.isAcceptableOrUnknown(data['anime_id']!, _animeIdMeta),
      );
    }
    if (data.containsKey('title_romaji')) {
      context.handle(
        _titleRomajiMeta,
        titleRomaji.isAcceptableOrUnknown(
          data['title_romaji']!,
          _titleRomajiMeta,
        ),
      );
    }
    if (data.containsKey('title_english')) {
      context.handle(
        _titleEnglishMeta,
        titleEnglish.isAcceptableOrUnknown(
          data['title_english']!,
          _titleEnglishMeta,
        ),
      );
    }
    if (data.containsKey('title_native')) {
      context.handle(
        _titleNativeMeta,
        titleNative.isAcceptableOrUnknown(
          data['title_native']!,
          _titleNativeMeta,
        ),
      );
    }
    if (data.containsKey('cover_image')) {
      context.handle(
        _coverImageMeta,
        coverImage.isAcceptableOrUnknown(data['cover_image']!, _coverImageMeta),
      );
    }
    if (data.containsKey('banner_image')) {
      context.handle(
        _bannerImageMeta,
        bannerImage.isAcceptableOrUnknown(
          data['banner_image']!,
          _bannerImageMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('season')) {
      context.handle(
        _seasonMeta,
        season.isAcceptableOrUnknown(data['season']!, _seasonMeta),
      );
    }
    if (data.containsKey('season_year')) {
      context.handle(
        _seasonYearMeta,
        seasonYear.isAcceptableOrUnknown(data['season_year']!, _seasonYearMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {animeId};
  @override
  FavoriteAnimeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteAnimeData(
      animeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}anime_id'],
      )!,
      titleRomaji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_romaji'],
      ),
      titleEnglish: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_english'],
      ),
      titleNative: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_native'],
      ),
      coverImage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_image'],
      ),
      bannerImage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}banner_image'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      ),
      season: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}season'],
      ),
      seasonYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}season_year'],
      ),
    );
  }

  @override
  $FavoriteAnimeTable createAlias(String alias) {
    return $FavoriteAnimeTable(attachedDatabase, alias);
  }
}

class FavoriteAnimeData extends DataClass
    implements Insertable<FavoriteAnimeData> {
  /// Identifiant AniList, fourni par l'API et donc non auto-incrémenté.
  final int animeId;

  /// Les titres et métadonnées d'AniList peuvent être absents.
  final String? titleRomaji;
  final String? titleEnglish;
  final String? titleNative;
  final String? coverImage;
  final String? bannerImage;
  final String? status;
  final String? season;
  final int? seasonYear;
  const FavoriteAnimeData({
    required this.animeId,
    this.titleRomaji,
    this.titleEnglish,
    this.titleNative,
    this.coverImage,
    this.bannerImage,
    this.status,
    this.season,
    this.seasonYear,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['anime_id'] = Variable<int>(animeId);
    if (!nullToAbsent || titleRomaji != null) {
      map['title_romaji'] = Variable<String>(titleRomaji);
    }
    if (!nullToAbsent || titleEnglish != null) {
      map['title_english'] = Variable<String>(titleEnglish);
    }
    if (!nullToAbsent || titleNative != null) {
      map['title_native'] = Variable<String>(titleNative);
    }
    if (!nullToAbsent || coverImage != null) {
      map['cover_image'] = Variable<String>(coverImage);
    }
    if (!nullToAbsent || bannerImage != null) {
      map['banner_image'] = Variable<String>(bannerImage);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || season != null) {
      map['season'] = Variable<String>(season);
    }
    if (!nullToAbsent || seasonYear != null) {
      map['season_year'] = Variable<int>(seasonYear);
    }
    return map;
  }

  FavoriteAnimeCompanion toCompanion(bool nullToAbsent) {
    return FavoriteAnimeCompanion(
      animeId: Value(animeId),
      titleRomaji: titleRomaji == null && nullToAbsent
          ? const Value.absent()
          : Value(titleRomaji),
      titleEnglish: titleEnglish == null && nullToAbsent
          ? const Value.absent()
          : Value(titleEnglish),
      titleNative: titleNative == null && nullToAbsent
          ? const Value.absent()
          : Value(titleNative),
      coverImage: coverImage == null && nullToAbsent
          ? const Value.absent()
          : Value(coverImage),
      bannerImage: bannerImage == null && nullToAbsent
          ? const Value.absent()
          : Value(bannerImage),
      status: status == null && nullToAbsent
          ? const Value.absent()
          : Value(status),
      season: season == null && nullToAbsent
          ? const Value.absent()
          : Value(season),
      seasonYear: seasonYear == null && nullToAbsent
          ? const Value.absent()
          : Value(seasonYear),
    );
  }

  factory FavoriteAnimeData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteAnimeData(
      animeId: serializer.fromJson<int>(json['animeId']),
      titleRomaji: serializer.fromJson<String?>(json['titleRomaji']),
      titleEnglish: serializer.fromJson<String?>(json['titleEnglish']),
      titleNative: serializer.fromJson<String?>(json['titleNative']),
      coverImage: serializer.fromJson<String?>(json['coverImage']),
      bannerImage: serializer.fromJson<String?>(json['bannerImage']),
      status: serializer.fromJson<String?>(json['status']),
      season: serializer.fromJson<String?>(json['season']),
      seasonYear: serializer.fromJson<int?>(json['seasonYear']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'animeId': serializer.toJson<int>(animeId),
      'titleRomaji': serializer.toJson<String?>(titleRomaji),
      'titleEnglish': serializer.toJson<String?>(titleEnglish),
      'titleNative': serializer.toJson<String?>(titleNative),
      'coverImage': serializer.toJson<String?>(coverImage),
      'bannerImage': serializer.toJson<String?>(bannerImage),
      'status': serializer.toJson<String?>(status),
      'season': serializer.toJson<String?>(season),
      'seasonYear': serializer.toJson<int?>(seasonYear),
    };
  }

  FavoriteAnimeData copyWith({
    int? animeId,
    Value<String?> titleRomaji = const Value.absent(),
    Value<String?> titleEnglish = const Value.absent(),
    Value<String?> titleNative = const Value.absent(),
    Value<String?> coverImage = const Value.absent(),
    Value<String?> bannerImage = const Value.absent(),
    Value<String?> status = const Value.absent(),
    Value<String?> season = const Value.absent(),
    Value<int?> seasonYear = const Value.absent(),
  }) => FavoriteAnimeData(
    animeId: animeId ?? this.animeId,
    titleRomaji: titleRomaji.present ? titleRomaji.value : this.titleRomaji,
    titleEnglish: titleEnglish.present ? titleEnglish.value : this.titleEnglish,
    titleNative: titleNative.present ? titleNative.value : this.titleNative,
    coverImage: coverImage.present ? coverImage.value : this.coverImage,
    bannerImage: bannerImage.present ? bannerImage.value : this.bannerImage,
    status: status.present ? status.value : this.status,
    season: season.present ? season.value : this.season,
    seasonYear: seasonYear.present ? seasonYear.value : this.seasonYear,
  );
  FavoriteAnimeData copyWithCompanion(FavoriteAnimeCompanion data) {
    return FavoriteAnimeData(
      animeId: data.animeId.present ? data.animeId.value : this.animeId,
      titleRomaji: data.titleRomaji.present
          ? data.titleRomaji.value
          : this.titleRomaji,
      titleEnglish: data.titleEnglish.present
          ? data.titleEnglish.value
          : this.titleEnglish,
      titleNative: data.titleNative.present
          ? data.titleNative.value
          : this.titleNative,
      coverImage: data.coverImage.present
          ? data.coverImage.value
          : this.coverImage,
      bannerImage: data.bannerImage.present
          ? data.bannerImage.value
          : this.bannerImage,
      status: data.status.present ? data.status.value : this.status,
      season: data.season.present ? data.season.value : this.season,
      seasonYear: data.seasonYear.present
          ? data.seasonYear.value
          : this.seasonYear,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteAnimeData(')
          ..write('animeId: $animeId, ')
          ..write('titleRomaji: $titleRomaji, ')
          ..write('titleEnglish: $titleEnglish, ')
          ..write('titleNative: $titleNative, ')
          ..write('coverImage: $coverImage, ')
          ..write('bannerImage: $bannerImage, ')
          ..write('status: $status, ')
          ..write('season: $season, ')
          ..write('seasonYear: $seasonYear')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    animeId,
    titleRomaji,
    titleEnglish,
    titleNative,
    coverImage,
    bannerImage,
    status,
    season,
    seasonYear,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteAnimeData &&
          other.animeId == this.animeId &&
          other.titleRomaji == this.titleRomaji &&
          other.titleEnglish == this.titleEnglish &&
          other.titleNative == this.titleNative &&
          other.coverImage == this.coverImage &&
          other.bannerImage == this.bannerImage &&
          other.status == this.status &&
          other.season == this.season &&
          other.seasonYear == this.seasonYear);
}

class FavoriteAnimeCompanion extends UpdateCompanion<FavoriteAnimeData> {
  final Value<int> animeId;
  final Value<String?> titleRomaji;
  final Value<String?> titleEnglish;
  final Value<String?> titleNative;
  final Value<String?> coverImage;
  final Value<String?> bannerImage;
  final Value<String?> status;
  final Value<String?> season;
  final Value<int?> seasonYear;
  const FavoriteAnimeCompanion({
    this.animeId = const Value.absent(),
    this.titleRomaji = const Value.absent(),
    this.titleEnglish = const Value.absent(),
    this.titleNative = const Value.absent(),
    this.coverImage = const Value.absent(),
    this.bannerImage = const Value.absent(),
    this.status = const Value.absent(),
    this.season = const Value.absent(),
    this.seasonYear = const Value.absent(),
  });
  FavoriteAnimeCompanion.insert({
    this.animeId = const Value.absent(),
    this.titleRomaji = const Value.absent(),
    this.titleEnglish = const Value.absent(),
    this.titleNative = const Value.absent(),
    this.coverImage = const Value.absent(),
    this.bannerImage = const Value.absent(),
    this.status = const Value.absent(),
    this.season = const Value.absent(),
    this.seasonYear = const Value.absent(),
  });
  static Insertable<FavoriteAnimeData> custom({
    Expression<int>? animeId,
    Expression<String>? titleRomaji,
    Expression<String>? titleEnglish,
    Expression<String>? titleNative,
    Expression<String>? coverImage,
    Expression<String>? bannerImage,
    Expression<String>? status,
    Expression<String>? season,
    Expression<int>? seasonYear,
  }) {
    return RawValuesInsertable({
      if (animeId != null) 'anime_id': animeId,
      if (titleRomaji != null) 'title_romaji': titleRomaji,
      if (titleEnglish != null) 'title_english': titleEnglish,
      if (titleNative != null) 'title_native': titleNative,
      if (coverImage != null) 'cover_image': coverImage,
      if (bannerImage != null) 'banner_image': bannerImage,
      if (status != null) 'status': status,
      if (season != null) 'season': season,
      if (seasonYear != null) 'season_year': seasonYear,
    });
  }

  FavoriteAnimeCompanion copyWith({
    Value<int>? animeId,
    Value<String?>? titleRomaji,
    Value<String?>? titleEnglish,
    Value<String?>? titleNative,
    Value<String?>? coverImage,
    Value<String?>? bannerImage,
    Value<String?>? status,
    Value<String?>? season,
    Value<int?>? seasonYear,
  }) {
    return FavoriteAnimeCompanion(
      animeId: animeId ?? this.animeId,
      titleRomaji: titleRomaji ?? this.titleRomaji,
      titleEnglish: titleEnglish ?? this.titleEnglish,
      titleNative: titleNative ?? this.titleNative,
      coverImage: coverImage ?? this.coverImage,
      bannerImage: bannerImage ?? this.bannerImage,
      status: status ?? this.status,
      season: season ?? this.season,
      seasonYear: seasonYear ?? this.seasonYear,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (animeId.present) {
      map['anime_id'] = Variable<int>(animeId.value);
    }
    if (titleRomaji.present) {
      map['title_romaji'] = Variable<String>(titleRomaji.value);
    }
    if (titleEnglish.present) {
      map['title_english'] = Variable<String>(titleEnglish.value);
    }
    if (titleNative.present) {
      map['title_native'] = Variable<String>(titleNative.value);
    }
    if (coverImage.present) {
      map['cover_image'] = Variable<String>(coverImage.value);
    }
    if (bannerImage.present) {
      map['banner_image'] = Variable<String>(bannerImage.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (season.present) {
      map['season'] = Variable<String>(season.value);
    }
    if (seasonYear.present) {
      map['season_year'] = Variable<int>(seasonYear.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteAnimeCompanion(')
          ..write('animeId: $animeId, ')
          ..write('titleRomaji: $titleRomaji, ')
          ..write('titleEnglish: $titleEnglish, ')
          ..write('titleNative: $titleNative, ')
          ..write('coverImage: $coverImage, ')
          ..write('bannerImage: $bannerImage, ')
          ..write('status: $status, ')
          ..write('season: $season, ')
          ..write('seasonYear: $seasonYear')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FavoriteAnimeTable favoriteAnime = $FavoriteAnimeTable(this);
  late final FavoriteAnimeAccessor favoriteAnimeAccessor =
      FavoriteAnimeAccessor(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [favoriteAnime];
}

typedef $$FavoriteAnimeTableCreateCompanionBuilder =
    FavoriteAnimeCompanion Function({
      Value<int> animeId,
      Value<String?> titleRomaji,
      Value<String?> titleEnglish,
      Value<String?> titleNative,
      Value<String?> coverImage,
      Value<String?> bannerImage,
      Value<String?> status,
      Value<String?> season,
      Value<int?> seasonYear,
    });
typedef $$FavoriteAnimeTableUpdateCompanionBuilder =
    FavoriteAnimeCompanion Function({
      Value<int> animeId,
      Value<String?> titleRomaji,
      Value<String?> titleEnglish,
      Value<String?> titleNative,
      Value<String?> coverImage,
      Value<String?> bannerImage,
      Value<String?> status,
      Value<String?> season,
      Value<int?> seasonYear,
    });

class $$FavoriteAnimeTableFilterComposer
    extends Composer<_$AppDatabase, $FavoriteAnimeTable> {
  $$FavoriteAnimeTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get animeId => $composableBuilder(
    column: $table.animeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleRomaji => $composableBuilder(
    column: $table.titleRomaji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleEnglish => $composableBuilder(
    column: $table.titleEnglish,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleNative => $composableBuilder(
    column: $table.titleNative,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverImage => $composableBuilder(
    column: $table.coverImage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bannerImage => $composableBuilder(
    column: $table.bannerImage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get season => $composableBuilder(
    column: $table.season,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seasonYear => $composableBuilder(
    column: $table.seasonYear,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoriteAnimeTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoriteAnimeTable> {
  $$FavoriteAnimeTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get animeId => $composableBuilder(
    column: $table.animeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleRomaji => $composableBuilder(
    column: $table.titleRomaji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleEnglish => $composableBuilder(
    column: $table.titleEnglish,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleNative => $composableBuilder(
    column: $table.titleNative,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverImage => $composableBuilder(
    column: $table.coverImage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bannerImage => $composableBuilder(
    column: $table.bannerImage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get season => $composableBuilder(
    column: $table.season,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seasonYear => $composableBuilder(
    column: $table.seasonYear,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoriteAnimeTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoriteAnimeTable> {
  $$FavoriteAnimeTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get animeId =>
      $composableBuilder(column: $table.animeId, builder: (column) => column);

  GeneratedColumn<String> get titleRomaji => $composableBuilder(
    column: $table.titleRomaji,
    builder: (column) => column,
  );

  GeneratedColumn<String> get titleEnglish => $composableBuilder(
    column: $table.titleEnglish,
    builder: (column) => column,
  );

  GeneratedColumn<String> get titleNative => $composableBuilder(
    column: $table.titleNative,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coverImage => $composableBuilder(
    column: $table.coverImage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bannerImage => $composableBuilder(
    column: $table.bannerImage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get season =>
      $composableBuilder(column: $table.season, builder: (column) => column);

  GeneratedColumn<int> get seasonYear => $composableBuilder(
    column: $table.seasonYear,
    builder: (column) => column,
  );
}

class $$FavoriteAnimeTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoriteAnimeTable,
          FavoriteAnimeData,
          $$FavoriteAnimeTableFilterComposer,
          $$FavoriteAnimeTableOrderingComposer,
          $$FavoriteAnimeTableAnnotationComposer,
          $$FavoriteAnimeTableCreateCompanionBuilder,
          $$FavoriteAnimeTableUpdateCompanionBuilder,
          (
            FavoriteAnimeData,
            BaseReferences<
              _$AppDatabase,
              $FavoriteAnimeTable,
              FavoriteAnimeData
            >,
          ),
          FavoriteAnimeData,
          PrefetchHooks Function()
        > {
  $$FavoriteAnimeTableTableManager(_$AppDatabase db, $FavoriteAnimeTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteAnimeTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteAnimeTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteAnimeTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> animeId = const Value.absent(),
                Value<String?> titleRomaji = const Value.absent(),
                Value<String?> titleEnglish = const Value.absent(),
                Value<String?> titleNative = const Value.absent(),
                Value<String?> coverImage = const Value.absent(),
                Value<String?> bannerImage = const Value.absent(),
                Value<String?> status = const Value.absent(),
                Value<String?> season = const Value.absent(),
                Value<int?> seasonYear = const Value.absent(),
              }) => FavoriteAnimeCompanion(
                animeId: animeId,
                titleRomaji: titleRomaji,
                titleEnglish: titleEnglish,
                titleNative: titleNative,
                coverImage: coverImage,
                bannerImage: bannerImage,
                status: status,
                season: season,
                seasonYear: seasonYear,
              ),
          createCompanionCallback:
              ({
                Value<int> animeId = const Value.absent(),
                Value<String?> titleRomaji = const Value.absent(),
                Value<String?> titleEnglish = const Value.absent(),
                Value<String?> titleNative = const Value.absent(),
                Value<String?> coverImage = const Value.absent(),
                Value<String?> bannerImage = const Value.absent(),
                Value<String?> status = const Value.absent(),
                Value<String?> season = const Value.absent(),
                Value<int?> seasonYear = const Value.absent(),
              }) => FavoriteAnimeCompanion.insert(
                animeId: animeId,
                titleRomaji: titleRomaji,
                titleEnglish: titleEnglish,
                titleNative: titleNative,
                coverImage: coverImage,
                bannerImage: bannerImage,
                status: status,
                season: season,
                seasonYear: seasonYear,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoriteAnimeTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoriteAnimeTable,
      FavoriteAnimeData,
      $$FavoriteAnimeTableFilterComposer,
      $$FavoriteAnimeTableOrderingComposer,
      $$FavoriteAnimeTableAnnotationComposer,
      $$FavoriteAnimeTableCreateCompanionBuilder,
      $$FavoriteAnimeTableUpdateCompanionBuilder,
      (
        FavoriteAnimeData,
        BaseReferences<_$AppDatabase, $FavoriteAnimeTable, FavoriteAnimeData>,
      ),
      FavoriteAnimeData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FavoriteAnimeTableTableManager get favoriteAnime =>
      $$FavoriteAnimeTableTableManager(_db, _db.favoriteAnime);
}

mixin _$FavoriteAnimeAccessorMixin on DatabaseAccessor<AppDatabase> {
  $FavoriteAnimeTable get favoriteAnime => attachedDatabase.favoriteAnime;
}
