// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $FavoriteSeriesTable extends FavoriteSeries
    with TableInfo<$FavoriteSeriesTable, FavoriteSery> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteSeriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _seriesIdMeta = const VerificationMeta(
    'seriesId',
  );
  @override
  late final GeneratedColumn<int> seriesId = GeneratedColumn<int>(
    'series_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _displayTitleRomajiMeta =
      const VerificationMeta('displayTitleRomaji');
  @override
  late final GeneratedColumn<String> displayTitleRomaji =
      GeneratedColumn<String>(
        'display_title_romaji',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _displayTitleEnglishMeta =
      const VerificationMeta('displayTitleEnglish');
  @override
  late final GeneratedColumn<String> displayTitleEnglish =
      GeneratedColumn<String>(
        'display_title_english',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _displayTitleNativeMeta =
      const VerificationMeta('displayTitleNative');
  @override
  late final GeneratedColumn<String> displayTitleNative =
      GeneratedColumn<String>(
        'display_title_native',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _latestAnimeIdMeta = const VerificationMeta(
    'latestAnimeId',
  );
  @override
  late final GeneratedColumn<int> latestAnimeId = GeneratedColumn<int>(
    'latest_anime_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    seriesId,
    displayTitleRomaji,
    displayTitleEnglish,
    displayTitleNative,
    latestAnimeId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_series';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteSery> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('series_id')) {
      context.handle(
        _seriesIdMeta,
        seriesId.isAcceptableOrUnknown(data['series_id']!, _seriesIdMeta),
      );
    }
    if (data.containsKey('display_title_romaji')) {
      context.handle(
        _displayTitleRomajiMeta,
        displayTitleRomaji.isAcceptableOrUnknown(
          data['display_title_romaji']!,
          _displayTitleRomajiMeta,
        ),
      );
    }
    if (data.containsKey('display_title_english')) {
      context.handle(
        _displayTitleEnglishMeta,
        displayTitleEnglish.isAcceptableOrUnknown(
          data['display_title_english']!,
          _displayTitleEnglishMeta,
        ),
      );
    }
    if (data.containsKey('display_title_native')) {
      context.handle(
        _displayTitleNativeMeta,
        displayTitleNative.isAcceptableOrUnknown(
          data['display_title_native']!,
          _displayTitleNativeMeta,
        ),
      );
    }
    if (data.containsKey('latest_anime_id')) {
      context.handle(
        _latestAnimeIdMeta,
        latestAnimeId.isAcceptableOrUnknown(
          data['latest_anime_id']!,
          _latestAnimeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_latestAnimeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {seriesId};
  @override
  FavoriteSery map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteSery(
      seriesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}series_id'],
      )!,
      displayTitleRomaji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_title_romaji'],
      ),
      displayTitleEnglish: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_title_english'],
      ),
      displayTitleNative: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_title_native'],
      ),
      latestAnimeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}latest_anime_id'],
      )!,
    );
  }

  @override
  $FavoriteSeriesTable createAlias(String alias) {
    return $FavoriteSeriesTable(attachedDatabase, alias);
  }
}

class FavoriteSery extends DataClass implements Insertable<FavoriteSery> {
  final int seriesId;

  /// Titres correspondant à la première saison de la série.
  final String? displayTitleRomaji;
  final String? displayTitleEnglish;
  final String? displayTitleNative;

  /// Toujours la saison avec le plus grand seasonNumber.
  final int latestAnimeId;
  const FavoriteSery({
    required this.seriesId,
    this.displayTitleRomaji,
    this.displayTitleEnglish,
    this.displayTitleNative,
    required this.latestAnimeId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['series_id'] = Variable<int>(seriesId);
    if (!nullToAbsent || displayTitleRomaji != null) {
      map['display_title_romaji'] = Variable<String>(displayTitleRomaji);
    }
    if (!nullToAbsent || displayTitleEnglish != null) {
      map['display_title_english'] = Variable<String>(displayTitleEnglish);
    }
    if (!nullToAbsent || displayTitleNative != null) {
      map['display_title_native'] = Variable<String>(displayTitleNative);
    }
    map['latest_anime_id'] = Variable<int>(latestAnimeId);
    return map;
  }

  FavoriteSeriesCompanion toCompanion(bool nullToAbsent) {
    return FavoriteSeriesCompanion(
      seriesId: Value(seriesId),
      displayTitleRomaji: displayTitleRomaji == null && nullToAbsent
          ? const Value.absent()
          : Value(displayTitleRomaji),
      displayTitleEnglish: displayTitleEnglish == null && nullToAbsent
          ? const Value.absent()
          : Value(displayTitleEnglish),
      displayTitleNative: displayTitleNative == null && nullToAbsent
          ? const Value.absent()
          : Value(displayTitleNative),
      latestAnimeId: Value(latestAnimeId),
    );
  }

  factory FavoriteSery.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteSery(
      seriesId: serializer.fromJson<int>(json['seriesId']),
      displayTitleRomaji: serializer.fromJson<String?>(
        json['displayTitleRomaji'],
      ),
      displayTitleEnglish: serializer.fromJson<String?>(
        json['displayTitleEnglish'],
      ),
      displayTitleNative: serializer.fromJson<String?>(
        json['displayTitleNative'],
      ),
      latestAnimeId: serializer.fromJson<int>(json['latestAnimeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'seriesId': serializer.toJson<int>(seriesId),
      'displayTitleRomaji': serializer.toJson<String?>(displayTitleRomaji),
      'displayTitleEnglish': serializer.toJson<String?>(displayTitleEnglish),
      'displayTitleNative': serializer.toJson<String?>(displayTitleNative),
      'latestAnimeId': serializer.toJson<int>(latestAnimeId),
    };
  }

  FavoriteSery copyWith({
    int? seriesId,
    Value<String?> displayTitleRomaji = const Value.absent(),
    Value<String?> displayTitleEnglish = const Value.absent(),
    Value<String?> displayTitleNative = const Value.absent(),
    int? latestAnimeId,
  }) => FavoriteSery(
    seriesId: seriesId ?? this.seriesId,
    displayTitleRomaji: displayTitleRomaji.present
        ? displayTitleRomaji.value
        : this.displayTitleRomaji,
    displayTitleEnglish: displayTitleEnglish.present
        ? displayTitleEnglish.value
        : this.displayTitleEnglish,
    displayTitleNative: displayTitleNative.present
        ? displayTitleNative.value
        : this.displayTitleNative,
    latestAnimeId: latestAnimeId ?? this.latestAnimeId,
  );
  FavoriteSery copyWithCompanion(FavoriteSeriesCompanion data) {
    return FavoriteSery(
      seriesId: data.seriesId.present ? data.seriesId.value : this.seriesId,
      displayTitleRomaji: data.displayTitleRomaji.present
          ? data.displayTitleRomaji.value
          : this.displayTitleRomaji,
      displayTitleEnglish: data.displayTitleEnglish.present
          ? data.displayTitleEnglish.value
          : this.displayTitleEnglish,
      displayTitleNative: data.displayTitleNative.present
          ? data.displayTitleNative.value
          : this.displayTitleNative,
      latestAnimeId: data.latestAnimeId.present
          ? data.latestAnimeId.value
          : this.latestAnimeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteSery(')
          ..write('seriesId: $seriesId, ')
          ..write('displayTitleRomaji: $displayTitleRomaji, ')
          ..write('displayTitleEnglish: $displayTitleEnglish, ')
          ..write('displayTitleNative: $displayTitleNative, ')
          ..write('latestAnimeId: $latestAnimeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    seriesId,
    displayTitleRomaji,
    displayTitleEnglish,
    displayTitleNative,
    latestAnimeId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteSery &&
          other.seriesId == this.seriesId &&
          other.displayTitleRomaji == this.displayTitleRomaji &&
          other.displayTitleEnglish == this.displayTitleEnglish &&
          other.displayTitleNative == this.displayTitleNative &&
          other.latestAnimeId == this.latestAnimeId);
}

class FavoriteSeriesCompanion extends UpdateCompanion<FavoriteSery> {
  final Value<int> seriesId;
  final Value<String?> displayTitleRomaji;
  final Value<String?> displayTitleEnglish;
  final Value<String?> displayTitleNative;
  final Value<int> latestAnimeId;
  const FavoriteSeriesCompanion({
    this.seriesId = const Value.absent(),
    this.displayTitleRomaji = const Value.absent(),
    this.displayTitleEnglish = const Value.absent(),
    this.displayTitleNative = const Value.absent(),
    this.latestAnimeId = const Value.absent(),
  });
  FavoriteSeriesCompanion.insert({
    this.seriesId = const Value.absent(),
    this.displayTitleRomaji = const Value.absent(),
    this.displayTitleEnglish = const Value.absent(),
    this.displayTitleNative = const Value.absent(),
    required int latestAnimeId,
  }) : latestAnimeId = Value(latestAnimeId);
  static Insertable<FavoriteSery> custom({
    Expression<int>? seriesId,
    Expression<String>? displayTitleRomaji,
    Expression<String>? displayTitleEnglish,
    Expression<String>? displayTitleNative,
    Expression<int>? latestAnimeId,
  }) {
    return RawValuesInsertable({
      if (seriesId != null) 'series_id': seriesId,
      if (displayTitleRomaji != null)
        'display_title_romaji': displayTitleRomaji,
      if (displayTitleEnglish != null)
        'display_title_english': displayTitleEnglish,
      if (displayTitleNative != null)
        'display_title_native': displayTitleNative,
      if (latestAnimeId != null) 'latest_anime_id': latestAnimeId,
    });
  }

  FavoriteSeriesCompanion copyWith({
    Value<int>? seriesId,
    Value<String?>? displayTitleRomaji,
    Value<String?>? displayTitleEnglish,
    Value<String?>? displayTitleNative,
    Value<int>? latestAnimeId,
  }) {
    return FavoriteSeriesCompanion(
      seriesId: seriesId ?? this.seriesId,
      displayTitleRomaji: displayTitleRomaji ?? this.displayTitleRomaji,
      displayTitleEnglish: displayTitleEnglish ?? this.displayTitleEnglish,
      displayTitleNative: displayTitleNative ?? this.displayTitleNative,
      latestAnimeId: latestAnimeId ?? this.latestAnimeId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (seriesId.present) {
      map['series_id'] = Variable<int>(seriesId.value);
    }
    if (displayTitleRomaji.present) {
      map['display_title_romaji'] = Variable<String>(displayTitleRomaji.value);
    }
    if (displayTitleEnglish.present) {
      map['display_title_english'] = Variable<String>(
        displayTitleEnglish.value,
      );
    }
    if (displayTitleNative.present) {
      map['display_title_native'] = Variable<String>(displayTitleNative.value);
    }
    if (latestAnimeId.present) {
      map['latest_anime_id'] = Variable<int>(latestAnimeId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteSeriesCompanion(')
          ..write('seriesId: $seriesId, ')
          ..write('displayTitleRomaji: $displayTitleRomaji, ')
          ..write('displayTitleEnglish: $displayTitleEnglish, ')
          ..write('displayTitleNative: $displayTitleNative, ')
          ..write('latestAnimeId: $latestAnimeId')
          ..write(')'))
        .toString();
  }
}

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
  static const VerificationMeta _seriesIdMeta = const VerificationMeta(
    'seriesId',
  );
  @override
  late final GeneratedColumn<int> seriesId = GeneratedColumn<int>(
    'series_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES favorite_series (series_id)',
    ),
  );
  static const VerificationMeta _seasonNumberMeta = const VerificationMeta(
    'seasonNumber',
  );
  @override
  late final GeneratedColumn<int> seasonNumber = GeneratedColumn<int>(
    'season_number',
    aliasedName,
    true,
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
  static const VerificationMeta _episodesMeta = const VerificationMeta(
    'episodes',
  );
  @override
  late final GeneratedColumn<int> episodes = GeneratedColumn<int>(
    'episodes',
    aliasedName,
    true,
    type: DriftSqlType.int,
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
    seriesId,
    seasonNumber,
    titleRomaji,
    titleEnglish,
    titleNative,
    coverImage,
    bannerImage,
    episodes,
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
    if (data.containsKey('series_id')) {
      context.handle(
        _seriesIdMeta,
        seriesId.isAcceptableOrUnknown(data['series_id']!, _seriesIdMeta),
      );
    }
    if (data.containsKey('season_number')) {
      context.handle(
        _seasonNumberMeta,
        seasonNumber.isAcceptableOrUnknown(
          data['season_number']!,
          _seasonNumberMeta,
        ),
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
    if (data.containsKey('episodes')) {
      context.handle(
        _episodesMeta,
        episodes.isAcceptableOrUnknown(data['episodes']!, _episodesMeta),
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
      seriesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}series_id'],
      ),
      seasonNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}season_number'],
      ),
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
      episodes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}episodes'],
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

  /// Référence vers la série parente (null si non encore associé).
  final int? seriesId;

  /// Numéro de saison calculé par l'application, jamais fourni par AniList.
  final int? seasonNumber;

  /// Les titres et métadonnées d'AniList peuvent être absents.
  final String? titleRomaji;
  final String? titleEnglish;
  final String? titleNative;
  final String? coverImage;
  final String? bannerImage;
  final int? episodes;
  final String? status;
  final String? season;
  final int? seasonYear;
  const FavoriteAnimeData({
    required this.animeId,
    this.seriesId,
    this.seasonNumber,
    this.titleRomaji,
    this.titleEnglish,
    this.titleNative,
    this.coverImage,
    this.bannerImage,
    this.episodes,
    this.status,
    this.season,
    this.seasonYear,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['anime_id'] = Variable<int>(animeId);
    if (!nullToAbsent || seriesId != null) {
      map['series_id'] = Variable<int>(seriesId);
    }
    if (!nullToAbsent || seasonNumber != null) {
      map['season_number'] = Variable<int>(seasonNumber);
    }
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
    if (!nullToAbsent || episodes != null) {
      map['episodes'] = Variable<int>(episodes);
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
      seriesId: seriesId == null && nullToAbsent
          ? const Value.absent()
          : Value(seriesId),
      seasonNumber: seasonNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(seasonNumber),
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
      episodes: episodes == null && nullToAbsent
          ? const Value.absent()
          : Value(episodes),
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
      seriesId: serializer.fromJson<int?>(json['seriesId']),
      seasonNumber: serializer.fromJson<int?>(json['seasonNumber']),
      titleRomaji: serializer.fromJson<String?>(json['titleRomaji']),
      titleEnglish: serializer.fromJson<String?>(json['titleEnglish']),
      titleNative: serializer.fromJson<String?>(json['titleNative']),
      coverImage: serializer.fromJson<String?>(json['coverImage']),
      bannerImage: serializer.fromJson<String?>(json['bannerImage']),
      episodes: serializer.fromJson<int?>(json['episodes']),
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
      'seriesId': serializer.toJson<int?>(seriesId),
      'seasonNumber': serializer.toJson<int?>(seasonNumber),
      'titleRomaji': serializer.toJson<String?>(titleRomaji),
      'titleEnglish': serializer.toJson<String?>(titleEnglish),
      'titleNative': serializer.toJson<String?>(titleNative),
      'coverImage': serializer.toJson<String?>(coverImage),
      'bannerImage': serializer.toJson<String?>(bannerImage),
      'episodes': serializer.toJson<int?>(episodes),
      'status': serializer.toJson<String?>(status),
      'season': serializer.toJson<String?>(season),
      'seasonYear': serializer.toJson<int?>(seasonYear),
    };
  }

  FavoriteAnimeData copyWith({
    int? animeId,
    Value<int?> seriesId = const Value.absent(),
    Value<int?> seasonNumber = const Value.absent(),
    Value<String?> titleRomaji = const Value.absent(),
    Value<String?> titleEnglish = const Value.absent(),
    Value<String?> titleNative = const Value.absent(),
    Value<String?> coverImage = const Value.absent(),
    Value<String?> bannerImage = const Value.absent(),
    Value<int?> episodes = const Value.absent(),
    Value<String?> status = const Value.absent(),
    Value<String?> season = const Value.absent(),
    Value<int?> seasonYear = const Value.absent(),
  }) => FavoriteAnimeData(
    animeId: animeId ?? this.animeId,
    seriesId: seriesId.present ? seriesId.value : this.seriesId,
    seasonNumber: seasonNumber.present ? seasonNumber.value : this.seasonNumber,
    titleRomaji: titleRomaji.present ? titleRomaji.value : this.titleRomaji,
    titleEnglish: titleEnglish.present ? titleEnglish.value : this.titleEnglish,
    titleNative: titleNative.present ? titleNative.value : this.titleNative,
    coverImage: coverImage.present ? coverImage.value : this.coverImage,
    bannerImage: bannerImage.present ? bannerImage.value : this.bannerImage,
    episodes: episodes.present ? episodes.value : this.episodes,
    status: status.present ? status.value : this.status,
    season: season.present ? season.value : this.season,
    seasonYear: seasonYear.present ? seasonYear.value : this.seasonYear,
  );
  FavoriteAnimeData copyWithCompanion(FavoriteAnimeCompanion data) {
    return FavoriteAnimeData(
      animeId: data.animeId.present ? data.animeId.value : this.animeId,
      seriesId: data.seriesId.present ? data.seriesId.value : this.seriesId,
      seasonNumber: data.seasonNumber.present
          ? data.seasonNumber.value
          : this.seasonNumber,
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
      episodes: data.episodes.present ? data.episodes.value : this.episodes,
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
          ..write('seriesId: $seriesId, ')
          ..write('seasonNumber: $seasonNumber, ')
          ..write('titleRomaji: $titleRomaji, ')
          ..write('titleEnglish: $titleEnglish, ')
          ..write('titleNative: $titleNative, ')
          ..write('coverImage: $coverImage, ')
          ..write('bannerImage: $bannerImage, ')
          ..write('episodes: $episodes, ')
          ..write('status: $status, ')
          ..write('season: $season, ')
          ..write('seasonYear: $seasonYear')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    animeId,
    seriesId,
    seasonNumber,
    titleRomaji,
    titleEnglish,
    titleNative,
    coverImage,
    bannerImage,
    episodes,
    status,
    season,
    seasonYear,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteAnimeData &&
          other.animeId == this.animeId &&
          other.seriesId == this.seriesId &&
          other.seasonNumber == this.seasonNumber &&
          other.titleRomaji == this.titleRomaji &&
          other.titleEnglish == this.titleEnglish &&
          other.titleNative == this.titleNative &&
          other.coverImage == this.coverImage &&
          other.bannerImage == this.bannerImage &&
          other.episodes == this.episodes &&
          other.status == this.status &&
          other.season == this.season &&
          other.seasonYear == this.seasonYear);
}

class FavoriteAnimeCompanion extends UpdateCompanion<FavoriteAnimeData> {
  final Value<int> animeId;
  final Value<int?> seriesId;
  final Value<int?> seasonNumber;
  final Value<String?> titleRomaji;
  final Value<String?> titleEnglish;
  final Value<String?> titleNative;
  final Value<String?> coverImage;
  final Value<String?> bannerImage;
  final Value<int?> episodes;
  final Value<String?> status;
  final Value<String?> season;
  final Value<int?> seasonYear;
  const FavoriteAnimeCompanion({
    this.animeId = const Value.absent(),
    this.seriesId = const Value.absent(),
    this.seasonNumber = const Value.absent(),
    this.titleRomaji = const Value.absent(),
    this.titleEnglish = const Value.absent(),
    this.titleNative = const Value.absent(),
    this.coverImage = const Value.absent(),
    this.bannerImage = const Value.absent(),
    this.episodes = const Value.absent(),
    this.status = const Value.absent(),
    this.season = const Value.absent(),
    this.seasonYear = const Value.absent(),
  });
  FavoriteAnimeCompanion.insert({
    this.animeId = const Value.absent(),
    this.seriesId = const Value.absent(),
    this.seasonNumber = const Value.absent(),
    this.titleRomaji = const Value.absent(),
    this.titleEnglish = const Value.absent(),
    this.titleNative = const Value.absent(),
    this.coverImage = const Value.absent(),
    this.bannerImage = const Value.absent(),
    this.episodes = const Value.absent(),
    this.status = const Value.absent(),
    this.season = const Value.absent(),
    this.seasonYear = const Value.absent(),
  });
  static Insertable<FavoriteAnimeData> custom({
    Expression<int>? animeId,
    Expression<int>? seriesId,
    Expression<int>? seasonNumber,
    Expression<String>? titleRomaji,
    Expression<String>? titleEnglish,
    Expression<String>? titleNative,
    Expression<String>? coverImage,
    Expression<String>? bannerImage,
    Expression<int>? episodes,
    Expression<String>? status,
    Expression<String>? season,
    Expression<int>? seasonYear,
  }) {
    return RawValuesInsertable({
      if (animeId != null) 'anime_id': animeId,
      if (seriesId != null) 'series_id': seriesId,
      if (seasonNumber != null) 'season_number': seasonNumber,
      if (titleRomaji != null) 'title_romaji': titleRomaji,
      if (titleEnglish != null) 'title_english': titleEnglish,
      if (titleNative != null) 'title_native': titleNative,
      if (coverImage != null) 'cover_image': coverImage,
      if (bannerImage != null) 'banner_image': bannerImage,
      if (episodes != null) 'episodes': episodes,
      if (status != null) 'status': status,
      if (season != null) 'season': season,
      if (seasonYear != null) 'season_year': seasonYear,
    });
  }

  FavoriteAnimeCompanion copyWith({
    Value<int>? animeId,
    Value<int?>? seriesId,
    Value<int?>? seasonNumber,
    Value<String?>? titleRomaji,
    Value<String?>? titleEnglish,
    Value<String?>? titleNative,
    Value<String?>? coverImage,
    Value<String?>? bannerImage,
    Value<int?>? episodes,
    Value<String?>? status,
    Value<String?>? season,
    Value<int?>? seasonYear,
  }) {
    return FavoriteAnimeCompanion(
      animeId: animeId ?? this.animeId,
      seriesId: seriesId ?? this.seriesId,
      seasonNumber: seasonNumber ?? this.seasonNumber,
      titleRomaji: titleRomaji ?? this.titleRomaji,
      titleEnglish: titleEnglish ?? this.titleEnglish,
      titleNative: titleNative ?? this.titleNative,
      coverImage: coverImage ?? this.coverImage,
      bannerImage: bannerImage ?? this.bannerImage,
      episodes: episodes ?? this.episodes,
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
    if (seriesId.present) {
      map['series_id'] = Variable<int>(seriesId.value);
    }
    if (seasonNumber.present) {
      map['season_number'] = Variable<int>(seasonNumber.value);
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
    if (episodes.present) {
      map['episodes'] = Variable<int>(episodes.value);
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
          ..write('seriesId: $seriesId, ')
          ..write('seasonNumber: $seasonNumber, ')
          ..write('titleRomaji: $titleRomaji, ')
          ..write('titleEnglish: $titleEnglish, ')
          ..write('titleNative: $titleNative, ')
          ..write('coverImage: $coverImage, ')
          ..write('bannerImage: $bannerImage, ')
          ..write('episodes: $episodes, ')
          ..write('status: $status, ')
          ..write('season: $season, ')
          ..write('seasonYear: $seasonYear')
          ..write(')'))
        .toString();
  }
}

class $AnimeParamsTable extends AnimeParams
    with TableInfo<$AnimeParamsTable, AnimeParam> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnimeParamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastFavoritesSyncMeta = const VerificationMeta(
    'lastFavoritesSync',
  );
  @override
  late final GeneratedColumn<DateTime> lastFavoritesSync =
      GeneratedColumn<DateTime>(
        'last_favorites_sync',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [id, lastFavoritesSync];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'anime_params';
  @override
  VerificationContext validateIntegrity(
    Insertable<AnimeParam> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('last_favorites_sync')) {
      context.handle(
        _lastFavoritesSyncMeta,
        lastFavoritesSync.isAcceptableOrUnknown(
          data['last_favorites_sync']!,
          _lastFavoritesSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AnimeParam map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnimeParam(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      lastFavoritesSync: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_favorites_sync'],
      ),
    );
  }

  @override
  $AnimeParamsTable createAlias(String alias) {
    return $AnimeParamsTable(attachedDatabase, alias);
  }
}

class AnimeParam extends DataClass implements Insertable<AnimeParam> {
  final int id;

  /// Horodatage de la dernière synchronisation des favoris.
  final DateTime? lastFavoritesSync;
  const AnimeParam({required this.id, this.lastFavoritesSync});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || lastFavoritesSync != null) {
      map['last_favorites_sync'] = Variable<DateTime>(lastFavoritesSync);
    }
    return map;
  }

  AnimeParamsCompanion toCompanion(bool nullToAbsent) {
    return AnimeParamsCompanion(
      id: Value(id),
      lastFavoritesSync: lastFavoritesSync == null && nullToAbsent
          ? const Value.absent()
          : Value(lastFavoritesSync),
    );
  }

  factory AnimeParam.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnimeParam(
      id: serializer.fromJson<int>(json['id']),
      lastFavoritesSync: serializer.fromJson<DateTime?>(
        json['lastFavoritesSync'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lastFavoritesSync': serializer.toJson<DateTime?>(lastFavoritesSync),
    };
  }

  AnimeParam copyWith({
    int? id,
    Value<DateTime?> lastFavoritesSync = const Value.absent(),
  }) => AnimeParam(
    id: id ?? this.id,
    lastFavoritesSync: lastFavoritesSync.present
        ? lastFavoritesSync.value
        : this.lastFavoritesSync,
  );
  AnimeParam copyWithCompanion(AnimeParamsCompanion data) {
    return AnimeParam(
      id: data.id.present ? data.id.value : this.id,
      lastFavoritesSync: data.lastFavoritesSync.present
          ? data.lastFavoritesSync.value
          : this.lastFavoritesSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnimeParam(')
          ..write('id: $id, ')
          ..write('lastFavoritesSync: $lastFavoritesSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lastFavoritesSync);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnimeParam &&
          other.id == this.id &&
          other.lastFavoritesSync == this.lastFavoritesSync);
}

class AnimeParamsCompanion extends UpdateCompanion<AnimeParam> {
  final Value<int> id;
  final Value<DateTime?> lastFavoritesSync;
  const AnimeParamsCompanion({
    this.id = const Value.absent(),
    this.lastFavoritesSync = const Value.absent(),
  });
  AnimeParamsCompanion.insert({
    this.id = const Value.absent(),
    this.lastFavoritesSync = const Value.absent(),
  });
  static Insertable<AnimeParam> custom({
    Expression<int>? id,
    Expression<DateTime>? lastFavoritesSync,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastFavoritesSync != null) 'last_favorites_sync': lastFavoritesSync,
    });
  }

  AnimeParamsCompanion copyWith({
    Value<int>? id,
    Value<DateTime?>? lastFavoritesSync,
  }) {
    return AnimeParamsCompanion(
      id: id ?? this.id,
      lastFavoritesSync: lastFavoritesSync ?? this.lastFavoritesSync,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lastFavoritesSync.present) {
      map['last_favorites_sync'] = Variable<DateTime>(lastFavoritesSync.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnimeParamsCompanion(')
          ..write('id: $id, ')
          ..write('lastFavoritesSync: $lastFavoritesSync')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FavoriteSeriesTable favoriteSeries = $FavoriteSeriesTable(this);
  late final $FavoriteAnimeTable favoriteAnime = $FavoriteAnimeTable(this);
  late final $AnimeParamsTable animeParams = $AnimeParamsTable(this);
  late final FavoriteAnimeAccessor favoriteAnimeAccessor =
      FavoriteAnimeAccessor(this as AppDatabase);
  late final FavoriteSeriesAccessor favoriteSeriesAccessor =
      FavoriteSeriesAccessor(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    favoriteSeries,
    favoriteAnime,
    animeParams,
  ];
}

typedef $$FavoriteSeriesTableCreateCompanionBuilder =
    FavoriteSeriesCompanion Function({
      Value<int> seriesId,
      Value<String?> displayTitleRomaji,
      Value<String?> displayTitleEnglish,
      Value<String?> displayTitleNative,
      required int latestAnimeId,
    });
typedef $$FavoriteSeriesTableUpdateCompanionBuilder =
    FavoriteSeriesCompanion Function({
      Value<int> seriesId,
      Value<String?> displayTitleRomaji,
      Value<String?> displayTitleEnglish,
      Value<String?> displayTitleNative,
      Value<int> latestAnimeId,
    });

final class $$FavoriteSeriesTableReferences
    extends BaseReferences<_$AppDatabase, $FavoriteSeriesTable, FavoriteSery> {
  $$FavoriteSeriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$FavoriteAnimeTable, List<FavoriteAnimeData>>
  _favoriteAnimeRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.favoriteAnime,
    aliasName: $_aliasNameGenerator(
      db.favoriteSeries.seriesId,
      db.favoriteAnime.seriesId,
    ),
  );

  $$FavoriteAnimeTableProcessedTableManager get favoriteAnimeRefs {
    final manager = $$FavoriteAnimeTableTableManager($_db, $_db.favoriteAnime)
        .filter(
          (f) => f.seriesId.seriesId.sqlEquals($_itemColumn<int>('series_id')!),
        );

    final cache = $_typedResult.readTableOrNull(_favoriteAnimeRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FavoriteSeriesTableFilterComposer
    extends Composer<_$AppDatabase, $FavoriteSeriesTable> {
  $$FavoriteSeriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get seriesId => $composableBuilder(
    column: $table.seriesId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayTitleRomaji => $composableBuilder(
    column: $table.displayTitleRomaji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayTitleEnglish => $composableBuilder(
    column: $table.displayTitleEnglish,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayTitleNative => $composableBuilder(
    column: $table.displayTitleNative,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get latestAnimeId => $composableBuilder(
    column: $table.latestAnimeId,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> favoriteAnimeRefs(
    Expression<bool> Function($$FavoriteAnimeTableFilterComposer f) f,
  ) {
    final $$FavoriteAnimeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.seriesId,
      referencedTable: $db.favoriteAnime,
      getReferencedColumn: (t) => t.seriesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoriteAnimeTableFilterComposer(
            $db: $db,
            $table: $db.favoriteAnime,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FavoriteSeriesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoriteSeriesTable> {
  $$FavoriteSeriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get seriesId => $composableBuilder(
    column: $table.seriesId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayTitleRomaji => $composableBuilder(
    column: $table.displayTitleRomaji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayTitleEnglish => $composableBuilder(
    column: $table.displayTitleEnglish,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayTitleNative => $composableBuilder(
    column: $table.displayTitleNative,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get latestAnimeId => $composableBuilder(
    column: $table.latestAnimeId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoriteSeriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoriteSeriesTable> {
  $$FavoriteSeriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get seriesId =>
      $composableBuilder(column: $table.seriesId, builder: (column) => column);

  GeneratedColumn<String> get displayTitleRomaji => $composableBuilder(
    column: $table.displayTitleRomaji,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayTitleEnglish => $composableBuilder(
    column: $table.displayTitleEnglish,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayTitleNative => $composableBuilder(
    column: $table.displayTitleNative,
    builder: (column) => column,
  );

  GeneratedColumn<int> get latestAnimeId => $composableBuilder(
    column: $table.latestAnimeId,
    builder: (column) => column,
  );

  Expression<T> favoriteAnimeRefs<T extends Object>(
    Expression<T> Function($$FavoriteAnimeTableAnnotationComposer a) f,
  ) {
    final $$FavoriteAnimeTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.seriesId,
      referencedTable: $db.favoriteAnime,
      getReferencedColumn: (t) => t.seriesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoriteAnimeTableAnnotationComposer(
            $db: $db,
            $table: $db.favoriteAnime,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FavoriteSeriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoriteSeriesTable,
          FavoriteSery,
          $$FavoriteSeriesTableFilterComposer,
          $$FavoriteSeriesTableOrderingComposer,
          $$FavoriteSeriesTableAnnotationComposer,
          $$FavoriteSeriesTableCreateCompanionBuilder,
          $$FavoriteSeriesTableUpdateCompanionBuilder,
          (FavoriteSery, $$FavoriteSeriesTableReferences),
          FavoriteSery,
          PrefetchHooks Function({bool favoriteAnimeRefs})
        > {
  $$FavoriteSeriesTableTableManager(
    _$AppDatabase db,
    $FavoriteSeriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteSeriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteSeriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteSeriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> seriesId = const Value.absent(),
                Value<String?> displayTitleRomaji = const Value.absent(),
                Value<String?> displayTitleEnglish = const Value.absent(),
                Value<String?> displayTitleNative = const Value.absent(),
                Value<int> latestAnimeId = const Value.absent(),
              }) => FavoriteSeriesCompanion(
                seriesId: seriesId,
                displayTitleRomaji: displayTitleRomaji,
                displayTitleEnglish: displayTitleEnglish,
                displayTitleNative: displayTitleNative,
                latestAnimeId: latestAnimeId,
              ),
          createCompanionCallback:
              ({
                Value<int> seriesId = const Value.absent(),
                Value<String?> displayTitleRomaji = const Value.absent(),
                Value<String?> displayTitleEnglish = const Value.absent(),
                Value<String?> displayTitleNative = const Value.absent(),
                required int latestAnimeId,
              }) => FavoriteSeriesCompanion.insert(
                seriesId: seriesId,
                displayTitleRomaji: displayTitleRomaji,
                displayTitleEnglish: displayTitleEnglish,
                displayTitleNative: displayTitleNative,
                latestAnimeId: latestAnimeId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FavoriteSeriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({favoriteAnimeRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (favoriteAnimeRefs) db.favoriteAnime,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (favoriteAnimeRefs)
                    await $_getPrefetchedData<
                      FavoriteSery,
                      $FavoriteSeriesTable,
                      FavoriteAnimeData
                    >(
                      currentTable: table,
                      referencedTable: $$FavoriteSeriesTableReferences
                          ._favoriteAnimeRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$FavoriteSeriesTableReferences(
                            db,
                            table,
                            p0,
                          ).favoriteAnimeRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.seriesId == item.seriesId,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FavoriteSeriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoriteSeriesTable,
      FavoriteSery,
      $$FavoriteSeriesTableFilterComposer,
      $$FavoriteSeriesTableOrderingComposer,
      $$FavoriteSeriesTableAnnotationComposer,
      $$FavoriteSeriesTableCreateCompanionBuilder,
      $$FavoriteSeriesTableUpdateCompanionBuilder,
      (FavoriteSery, $$FavoriteSeriesTableReferences),
      FavoriteSery,
      PrefetchHooks Function({bool favoriteAnimeRefs})
    >;
typedef $$FavoriteAnimeTableCreateCompanionBuilder =
    FavoriteAnimeCompanion Function({
      Value<int> animeId,
      Value<int?> seriesId,
      Value<int?> seasonNumber,
      Value<String?> titleRomaji,
      Value<String?> titleEnglish,
      Value<String?> titleNative,
      Value<String?> coverImage,
      Value<String?> bannerImage,
      Value<int?> episodes,
      Value<String?> status,
      Value<String?> season,
      Value<int?> seasonYear,
    });
typedef $$FavoriteAnimeTableUpdateCompanionBuilder =
    FavoriteAnimeCompanion Function({
      Value<int> animeId,
      Value<int?> seriesId,
      Value<int?> seasonNumber,
      Value<String?> titleRomaji,
      Value<String?> titleEnglish,
      Value<String?> titleNative,
      Value<String?> coverImage,
      Value<String?> bannerImage,
      Value<int?> episodes,
      Value<String?> status,
      Value<String?> season,
      Value<int?> seasonYear,
    });

final class $$FavoriteAnimeTableReferences
    extends
        BaseReferences<_$AppDatabase, $FavoriteAnimeTable, FavoriteAnimeData> {
  $$FavoriteAnimeTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FavoriteSeriesTable _seriesIdTable(_$AppDatabase db) =>
      db.favoriteSeries.createAlias(
        $_aliasNameGenerator(
          db.favoriteAnime.seriesId,
          db.favoriteSeries.seriesId,
        ),
      );

  $$FavoriteSeriesTableProcessedTableManager? get seriesId {
    final $_column = $_itemColumn<int>('series_id');
    if ($_column == null) return null;
    final manager = $$FavoriteSeriesTableTableManager(
      $_db,
      $_db.favoriteSeries,
    ).filter((f) => f.seriesId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_seriesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

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

  ColumnFilters<int> get seasonNumber => $composableBuilder(
    column: $table.seasonNumber,
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

  ColumnFilters<int> get episodes => $composableBuilder(
    column: $table.episodes,
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

  $$FavoriteSeriesTableFilterComposer get seriesId {
    final $$FavoriteSeriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.seriesId,
      referencedTable: $db.favoriteSeries,
      getReferencedColumn: (t) => t.seriesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoriteSeriesTableFilterComposer(
            $db: $db,
            $table: $db.favoriteSeries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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

  ColumnOrderings<int> get seasonNumber => $composableBuilder(
    column: $table.seasonNumber,
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

  ColumnOrderings<int> get episodes => $composableBuilder(
    column: $table.episodes,
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

  $$FavoriteSeriesTableOrderingComposer get seriesId {
    final $$FavoriteSeriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.seriesId,
      referencedTable: $db.favoriteSeries,
      getReferencedColumn: (t) => t.seriesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoriteSeriesTableOrderingComposer(
            $db: $db,
            $table: $db.favoriteSeries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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

  GeneratedColumn<int> get seasonNumber => $composableBuilder(
    column: $table.seasonNumber,
    builder: (column) => column,
  );

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

  GeneratedColumn<int> get episodes =>
      $composableBuilder(column: $table.episodes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get season =>
      $composableBuilder(column: $table.season, builder: (column) => column);

  GeneratedColumn<int> get seasonYear => $composableBuilder(
    column: $table.seasonYear,
    builder: (column) => column,
  );

  $$FavoriteSeriesTableAnnotationComposer get seriesId {
    final $$FavoriteSeriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.seriesId,
      referencedTable: $db.favoriteSeries,
      getReferencedColumn: (t) => t.seriesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoriteSeriesTableAnnotationComposer(
            $db: $db,
            $table: $db.favoriteSeries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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
          (FavoriteAnimeData, $$FavoriteAnimeTableReferences),
          FavoriteAnimeData,
          PrefetchHooks Function({bool seriesId})
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
                Value<int?> seriesId = const Value.absent(),
                Value<int?> seasonNumber = const Value.absent(),
                Value<String?> titleRomaji = const Value.absent(),
                Value<String?> titleEnglish = const Value.absent(),
                Value<String?> titleNative = const Value.absent(),
                Value<String?> coverImage = const Value.absent(),
                Value<String?> bannerImage = const Value.absent(),
                Value<int?> episodes = const Value.absent(),
                Value<String?> status = const Value.absent(),
                Value<String?> season = const Value.absent(),
                Value<int?> seasonYear = const Value.absent(),
              }) => FavoriteAnimeCompanion(
                animeId: animeId,
                seriesId: seriesId,
                seasonNumber: seasonNumber,
                titleRomaji: titleRomaji,
                titleEnglish: titleEnglish,
                titleNative: titleNative,
                coverImage: coverImage,
                bannerImage: bannerImage,
                episodes: episodes,
                status: status,
                season: season,
                seasonYear: seasonYear,
              ),
          createCompanionCallback:
              ({
                Value<int> animeId = const Value.absent(),
                Value<int?> seriesId = const Value.absent(),
                Value<int?> seasonNumber = const Value.absent(),
                Value<String?> titleRomaji = const Value.absent(),
                Value<String?> titleEnglish = const Value.absent(),
                Value<String?> titleNative = const Value.absent(),
                Value<String?> coverImage = const Value.absent(),
                Value<String?> bannerImage = const Value.absent(),
                Value<int?> episodes = const Value.absent(),
                Value<String?> status = const Value.absent(),
                Value<String?> season = const Value.absent(),
                Value<int?> seasonYear = const Value.absent(),
              }) => FavoriteAnimeCompanion.insert(
                animeId: animeId,
                seriesId: seriesId,
                seasonNumber: seasonNumber,
                titleRomaji: titleRomaji,
                titleEnglish: titleEnglish,
                titleNative: titleNative,
                coverImage: coverImage,
                bannerImage: bannerImage,
                episodes: episodes,
                status: status,
                season: season,
                seasonYear: seasonYear,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FavoriteAnimeTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({seriesId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (seriesId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.seriesId,
                                referencedTable: $$FavoriteAnimeTableReferences
                                    ._seriesIdTable(db),
                                referencedColumn: $$FavoriteAnimeTableReferences
                                    ._seriesIdTable(db)
                                    .seriesId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
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
      (FavoriteAnimeData, $$FavoriteAnimeTableReferences),
      FavoriteAnimeData,
      PrefetchHooks Function({bool seriesId})
    >;
typedef $$AnimeParamsTableCreateCompanionBuilder =
    AnimeParamsCompanion Function({
      Value<int> id,
      Value<DateTime?> lastFavoritesSync,
    });
typedef $$AnimeParamsTableUpdateCompanionBuilder =
    AnimeParamsCompanion Function({
      Value<int> id,
      Value<DateTime?> lastFavoritesSync,
    });

class $$AnimeParamsTableFilterComposer
    extends Composer<_$AppDatabase, $AnimeParamsTable> {
  $$AnimeParamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastFavoritesSync => $composableBuilder(
    column: $table.lastFavoritesSync,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AnimeParamsTableOrderingComposer
    extends Composer<_$AppDatabase, $AnimeParamsTable> {
  $$AnimeParamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastFavoritesSync => $composableBuilder(
    column: $table.lastFavoritesSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AnimeParamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnimeParamsTable> {
  $$AnimeParamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get lastFavoritesSync => $composableBuilder(
    column: $table.lastFavoritesSync,
    builder: (column) => column,
  );
}

class $$AnimeParamsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnimeParamsTable,
          AnimeParam,
          $$AnimeParamsTableFilterComposer,
          $$AnimeParamsTableOrderingComposer,
          $$AnimeParamsTableAnnotationComposer,
          $$AnimeParamsTableCreateCompanionBuilder,
          $$AnimeParamsTableUpdateCompanionBuilder,
          (
            AnimeParam,
            BaseReferences<_$AppDatabase, $AnimeParamsTable, AnimeParam>,
          ),
          AnimeParam,
          PrefetchHooks Function()
        > {
  $$AnimeParamsTableTableManager(_$AppDatabase db, $AnimeParamsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnimeParamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnimeParamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnimeParamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime?> lastFavoritesSync = const Value.absent(),
              }) => AnimeParamsCompanion(
                id: id,
                lastFavoritesSync: lastFavoritesSync,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime?> lastFavoritesSync = const Value.absent(),
              }) => AnimeParamsCompanion.insert(
                id: id,
                lastFavoritesSync: lastFavoritesSync,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AnimeParamsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnimeParamsTable,
      AnimeParam,
      $$AnimeParamsTableFilterComposer,
      $$AnimeParamsTableOrderingComposer,
      $$AnimeParamsTableAnnotationComposer,
      $$AnimeParamsTableCreateCompanionBuilder,
      $$AnimeParamsTableUpdateCompanionBuilder,
      (
        AnimeParam,
        BaseReferences<_$AppDatabase, $AnimeParamsTable, AnimeParam>,
      ),
      AnimeParam,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FavoriteSeriesTableTableManager get favoriteSeries =>
      $$FavoriteSeriesTableTableManager(_db, _db.favoriteSeries);
  $$FavoriteAnimeTableTableManager get favoriteAnime =>
      $$FavoriteAnimeTableTableManager(_db, _db.favoriteAnime);
  $$AnimeParamsTableTableManager get animeParams =>
      $$AnimeParamsTableTableManager(_db, _db.animeParams);
}

mixin _$FavoriteAnimeAccessorMixin on DatabaseAccessor<AppDatabase> {
  $FavoriteSeriesTable get favoriteSeries => attachedDatabase.favoriteSeries;
  $FavoriteAnimeTable get favoriteAnime => attachedDatabase.favoriteAnime;
}
mixin _$FavoriteSeriesAccessorMixin on DatabaseAccessor<AppDatabase> {
  $FavoriteSeriesTable get favoriteSeries => attachedDatabase.favoriteSeries;
}
