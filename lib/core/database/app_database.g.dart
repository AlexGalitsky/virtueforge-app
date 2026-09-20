// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $StoicCategoriesTable extends StoicCategories
    with TableInfo<$StoicCategoriesTable, StoicCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoicCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconPathMeta = const VerificationMeta(
    'iconPath',
  );
  @override
  late final GeneratedColumn<String> iconPath = GeneratedColumn<String>(
    'icon_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, description, iconPath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stoic_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoicCategory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('icon_path')) {
      context.handle(
        _iconPathMeta,
        iconPath.isAcceptableOrUnknown(data['icon_path']!, _iconPathMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoicCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoicCategory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      iconPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_path'],
      ),
    );
  }

  @override
  $StoicCategoriesTable createAlias(String alias) {
    return $StoicCategoriesTable(attachedDatabase, alias);
  }
}

class StoicCategory extends DataClass implements Insertable<StoicCategory> {
  final int id;
  final String name;
  final String description;
  final String? iconPath;
  const StoicCategory({
    required this.id,
    required this.name,
    required this.description,
    this.iconPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || iconPath != null) {
      map['icon_path'] = Variable<String>(iconPath);
    }
    return map;
  }

  StoicCategoriesCompanion toCompanion(bool nullToAbsent) {
    return StoicCategoriesCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      iconPath: iconPath == null && nullToAbsent
          ? const Value.absent()
          : Value(iconPath),
    );
  }

  factory StoicCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoicCategory(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      iconPath: serializer.fromJson<String?>(json['iconPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'iconPath': serializer.toJson<String?>(iconPath),
    };
  }

  StoicCategory copyWith({
    int? id,
    String? name,
    String? description,
    Value<String?> iconPath = const Value.absent(),
  }) => StoicCategory(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    iconPath: iconPath.present ? iconPath.value : this.iconPath,
  );
  StoicCategory copyWithCompanion(StoicCategoriesCompanion data) {
    return StoicCategory(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      iconPath: data.iconPath.present ? data.iconPath.value : this.iconPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoicCategory(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('iconPath: $iconPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, iconPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoicCategory &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.iconPath == this.iconPath);
}

class StoicCategoriesCompanion extends UpdateCompanion<StoicCategory> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String?> iconPath;
  const StoicCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.iconPath = const Value.absent(),
  });
  StoicCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    this.iconPath = const Value.absent(),
  }) : name = Value(name),
       description = Value(description);
  static Insertable<StoicCategory> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? iconPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (iconPath != null) 'icon_path': iconPath,
    });
  }

  StoicCategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? description,
    Value<String?>? iconPath,
  }) {
    return StoicCategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconPath: iconPath ?? this.iconPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (iconPath.present) {
      map['icon_path'] = Variable<String>(iconPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoicCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('iconPath: $iconPath')
          ..write(')'))
        .toString();
  }
}

class $FranklinVirtuesTable extends FranklinVirtues
    with TableInfo<$FranklinVirtuesTable, FranklinVirtue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FranklinVirtuesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _stoicCategoryIdMeta = const VerificationMeta(
    'stoicCategoryId',
  );
  @override
  late final GeneratedColumn<int> stoicCategoryId = GeneratedColumn<int>(
    'stoic_category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES stoic_categories (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customDescriptionMeta = const VerificationMeta(
    'customDescription',
  );
  @override
  late final GeneratedColumn<String> customDescription =
      GeneratedColumn<String>(
        'custom_description',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _defaultWeekNumberMeta = const VerificationMeta(
    'defaultWeekNumber',
  );
  @override
  late final GeneratedColumn<int> defaultWeekNumber = GeneratedColumn<int>(
    'default_week_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    stoicCategoryId,
    name,
    description,
    customDescription,
    defaultWeekNumber,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'franklin_virtues';
  @override
  VerificationContext validateIntegrity(
    Insertable<FranklinVirtue> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('stoic_category_id')) {
      context.handle(
        _stoicCategoryIdMeta,
        stoicCategoryId.isAcceptableOrUnknown(
          data['stoic_category_id']!,
          _stoicCategoryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stoicCategoryIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('custom_description')) {
      context.handle(
        _customDescriptionMeta,
        customDescription.isAcceptableOrUnknown(
          data['custom_description']!,
          _customDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('default_week_number')) {
      context.handle(
        _defaultWeekNumberMeta,
        defaultWeekNumber.isAcceptableOrUnknown(
          data['default_week_number']!,
          _defaultWeekNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_defaultWeekNumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FranklinVirtue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FranklinVirtue(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      stoicCategoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stoic_category_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      customDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_description'],
      ),
      defaultWeekNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_week_number'],
      )!,
    );
  }

  @override
  $FranklinVirtuesTable createAlias(String alias) {
    return $FranklinVirtuesTable(attachedDatabase, alias);
  }
}

class FranklinVirtue extends DataClass implements Insertable<FranklinVirtue> {
  final int id;
  final int stoicCategoryId;
  final String name;
  final String description;
  final String? customDescription;
  final int defaultWeekNumber;
  const FranklinVirtue({
    required this.id,
    required this.stoicCategoryId,
    required this.name,
    required this.description,
    this.customDescription,
    required this.defaultWeekNumber,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['stoic_category_id'] = Variable<int>(stoicCategoryId);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || customDescription != null) {
      map['custom_description'] = Variable<String>(customDescription);
    }
    map['default_week_number'] = Variable<int>(defaultWeekNumber);
    return map;
  }

  FranklinVirtuesCompanion toCompanion(bool nullToAbsent) {
    return FranklinVirtuesCompanion(
      id: Value(id),
      stoicCategoryId: Value(stoicCategoryId),
      name: Value(name),
      description: Value(description),
      customDescription: customDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(customDescription),
      defaultWeekNumber: Value(defaultWeekNumber),
    );
  }

  factory FranklinVirtue.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FranklinVirtue(
      id: serializer.fromJson<int>(json['id']),
      stoicCategoryId: serializer.fromJson<int>(json['stoicCategoryId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      customDescription: serializer.fromJson<String?>(
        json['customDescription'],
      ),
      defaultWeekNumber: serializer.fromJson<int>(json['defaultWeekNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'stoicCategoryId': serializer.toJson<int>(stoicCategoryId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'customDescription': serializer.toJson<String?>(customDescription),
      'defaultWeekNumber': serializer.toJson<int>(defaultWeekNumber),
    };
  }

  FranklinVirtue copyWith({
    int? id,
    int? stoicCategoryId,
    String? name,
    String? description,
    Value<String?> customDescription = const Value.absent(),
    int? defaultWeekNumber,
  }) => FranklinVirtue(
    id: id ?? this.id,
    stoicCategoryId: stoicCategoryId ?? this.stoicCategoryId,
    name: name ?? this.name,
    description: description ?? this.description,
    customDescription: customDescription.present
        ? customDescription.value
        : this.customDescription,
    defaultWeekNumber: defaultWeekNumber ?? this.defaultWeekNumber,
  );
  FranklinVirtue copyWithCompanion(FranklinVirtuesCompanion data) {
    return FranklinVirtue(
      id: data.id.present ? data.id.value : this.id,
      stoicCategoryId: data.stoicCategoryId.present
          ? data.stoicCategoryId.value
          : this.stoicCategoryId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      customDescription: data.customDescription.present
          ? data.customDescription.value
          : this.customDescription,
      defaultWeekNumber: data.defaultWeekNumber.present
          ? data.defaultWeekNumber.value
          : this.defaultWeekNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FranklinVirtue(')
          ..write('id: $id, ')
          ..write('stoicCategoryId: $stoicCategoryId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('customDescription: $customDescription, ')
          ..write('defaultWeekNumber: $defaultWeekNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    stoicCategoryId,
    name,
    description,
    customDescription,
    defaultWeekNumber,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FranklinVirtue &&
          other.id == this.id &&
          other.stoicCategoryId == this.stoicCategoryId &&
          other.name == this.name &&
          other.description == this.description &&
          other.customDescription == this.customDescription &&
          other.defaultWeekNumber == this.defaultWeekNumber);
}

class FranklinVirtuesCompanion extends UpdateCompanion<FranklinVirtue> {
  final Value<int> id;
  final Value<int> stoicCategoryId;
  final Value<String> name;
  final Value<String> description;
  final Value<String?> customDescription;
  final Value<int> defaultWeekNumber;
  const FranklinVirtuesCompanion({
    this.id = const Value.absent(),
    this.stoicCategoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.customDescription = const Value.absent(),
    this.defaultWeekNumber = const Value.absent(),
  });
  FranklinVirtuesCompanion.insert({
    this.id = const Value.absent(),
    required int stoicCategoryId,
    required String name,
    required String description,
    this.customDescription = const Value.absent(),
    required int defaultWeekNumber,
  }) : stoicCategoryId = Value(stoicCategoryId),
       name = Value(name),
       description = Value(description),
       defaultWeekNumber = Value(defaultWeekNumber);
  static Insertable<FranklinVirtue> custom({
    Expression<int>? id,
    Expression<int>? stoicCategoryId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? customDescription,
    Expression<int>? defaultWeekNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (stoicCategoryId != null) 'stoic_category_id': stoicCategoryId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (customDescription != null) 'custom_description': customDescription,
      if (defaultWeekNumber != null) 'default_week_number': defaultWeekNumber,
    });
  }

  FranklinVirtuesCompanion copyWith({
    Value<int>? id,
    Value<int>? stoicCategoryId,
    Value<String>? name,
    Value<String>? description,
    Value<String?>? customDescription,
    Value<int>? defaultWeekNumber,
  }) {
    return FranklinVirtuesCompanion(
      id: id ?? this.id,
      stoicCategoryId: stoicCategoryId ?? this.stoicCategoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      customDescription: customDescription ?? this.customDescription,
      defaultWeekNumber: defaultWeekNumber ?? this.defaultWeekNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (stoicCategoryId.present) {
      map['stoic_category_id'] = Variable<int>(stoicCategoryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (customDescription.present) {
      map['custom_description'] = Variable<String>(customDescription.value);
    }
    if (defaultWeekNumber.present) {
      map['default_week_number'] = Variable<int>(defaultWeekNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FranklinVirtuesCompanion(')
          ..write('id: $id, ')
          ..write('stoicCategoryId: $stoicCategoryId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('customDescription: $customDescription, ')
          ..write('defaultWeekNumber: $defaultWeekNumber')
          ..write(')'))
        .toString();
  }
}

class $DailyLogsTable extends DailyLogs
    with TableInfo<$DailyLogsTable, DailyLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _virtueIdMeta = const VerificationMeta(
    'virtueId',
  );
  @override
  late final GeneratedColumn<int> virtueId = GeneratedColumn<int>(
    'virtue_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES franklin_virtues (id)',
    ),
  );
  static const VerificationMeta _strikesCountMeta = const VerificationMeta(
    'strikesCount',
  );
  @override
  late final GeneratedColumn<int> strikesCount = GeneratedColumn<int>(
    'strikes_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _noteControlledMeta = const VerificationMeta(
    'noteControlled',
  );
  @override
  late final GeneratedColumn<String> noteControlled = GeneratedColumn<String>(
    'note_controlled',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteUncontrolledMeta = const VerificationMeta(
    'noteUncontrolled',
  );
  @override
  late final GeneratedColumn<String> noteUncontrolled = GeneratedColumn<String>(
    'note_uncontrolled',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _strikeNoteMeta = const VerificationMeta(
    'strikeNote',
  );
  @override
  late final GeneratedColumn<String> strikeNote = GeneratedColumn<String>(
    'strike_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    virtueId,
    strikesCount,
    noteControlled,
    noteUncontrolled,
    strikeNote,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('virtue_id')) {
      context.handle(
        _virtueIdMeta,
        virtueId.isAcceptableOrUnknown(data['virtue_id']!, _virtueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_virtueIdMeta);
    }
    if (data.containsKey('strikes_count')) {
      context.handle(
        _strikesCountMeta,
        strikesCount.isAcceptableOrUnknown(
          data['strikes_count']!,
          _strikesCountMeta,
        ),
      );
    }
    if (data.containsKey('note_controlled')) {
      context.handle(
        _noteControlledMeta,
        noteControlled.isAcceptableOrUnknown(
          data['note_controlled']!,
          _noteControlledMeta,
        ),
      );
    }
    if (data.containsKey('note_uncontrolled')) {
      context.handle(
        _noteUncontrolledMeta,
        noteUncontrolled.isAcceptableOrUnknown(
          data['note_uncontrolled']!,
          _noteUncontrolledMeta,
        ),
      );
    }
    if (data.containsKey('strike_note')) {
      context.handle(
        _strikeNoteMeta,
        strikeNote.isAcceptableOrUnknown(data['strike_note']!, _strikeNoteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {date, virtueId},
  ];
  @override
  DailyLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      virtueId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}virtue_id'],
      )!,
      strikesCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}strikes_count'],
      )!,
      noteControlled: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note_controlled'],
      ),
      noteUncontrolled: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note_uncontrolled'],
      ),
      strikeNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}strike_note'],
      ),
    );
  }

  @override
  $DailyLogsTable createAlias(String alias) {
    return $DailyLogsTable(attachedDatabase, alias);
  }
}

class DailyLog extends DataClass implements Insertable<DailyLog> {
  final int id;
  final DateTime date;
  final int virtueId;
  final int strikesCount;
  final String? noteControlled;
  final String? noteUncontrolled;

  /// Deprecated (schema 3): day-level note. Prefer [StrikeNotes] per ordinal.
  final String? strikeNote;
  const DailyLog({
    required this.id,
    required this.date,
    required this.virtueId,
    required this.strikesCount,
    this.noteControlled,
    this.noteUncontrolled,
    this.strikeNote,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['virtue_id'] = Variable<int>(virtueId);
    map['strikes_count'] = Variable<int>(strikesCount);
    if (!nullToAbsent || noteControlled != null) {
      map['note_controlled'] = Variable<String>(noteControlled);
    }
    if (!nullToAbsent || noteUncontrolled != null) {
      map['note_uncontrolled'] = Variable<String>(noteUncontrolled);
    }
    if (!nullToAbsent || strikeNote != null) {
      map['strike_note'] = Variable<String>(strikeNote);
    }
    return map;
  }

  DailyLogsCompanion toCompanion(bool nullToAbsent) {
    return DailyLogsCompanion(
      id: Value(id),
      date: Value(date),
      virtueId: Value(virtueId),
      strikesCount: Value(strikesCount),
      noteControlled: noteControlled == null && nullToAbsent
          ? const Value.absent()
          : Value(noteControlled),
      noteUncontrolled: noteUncontrolled == null && nullToAbsent
          ? const Value.absent()
          : Value(noteUncontrolled),
      strikeNote: strikeNote == null && nullToAbsent
          ? const Value.absent()
          : Value(strikeNote),
    );
  }

  factory DailyLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyLog(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      virtueId: serializer.fromJson<int>(json['virtueId']),
      strikesCount: serializer.fromJson<int>(json['strikesCount']),
      noteControlled: serializer.fromJson<String?>(json['noteControlled']),
      noteUncontrolled: serializer.fromJson<String?>(json['noteUncontrolled']),
      strikeNote: serializer.fromJson<String?>(json['strikeNote']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'virtueId': serializer.toJson<int>(virtueId),
      'strikesCount': serializer.toJson<int>(strikesCount),
      'noteControlled': serializer.toJson<String?>(noteControlled),
      'noteUncontrolled': serializer.toJson<String?>(noteUncontrolled),
      'strikeNote': serializer.toJson<String?>(strikeNote),
    };
  }

  DailyLog copyWith({
    int? id,
    DateTime? date,
    int? virtueId,
    int? strikesCount,
    Value<String?> noteControlled = const Value.absent(),
    Value<String?> noteUncontrolled = const Value.absent(),
    Value<String?> strikeNote = const Value.absent(),
  }) => DailyLog(
    id: id ?? this.id,
    date: date ?? this.date,
    virtueId: virtueId ?? this.virtueId,
    strikesCount: strikesCount ?? this.strikesCount,
    noteControlled: noteControlled.present
        ? noteControlled.value
        : this.noteControlled,
    noteUncontrolled: noteUncontrolled.present
        ? noteUncontrolled.value
        : this.noteUncontrolled,
    strikeNote: strikeNote.present ? strikeNote.value : this.strikeNote,
  );
  DailyLog copyWithCompanion(DailyLogsCompanion data) {
    return DailyLog(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      virtueId: data.virtueId.present ? data.virtueId.value : this.virtueId,
      strikesCount: data.strikesCount.present
          ? data.strikesCount.value
          : this.strikesCount,
      noteControlled: data.noteControlled.present
          ? data.noteControlled.value
          : this.noteControlled,
      noteUncontrolled: data.noteUncontrolled.present
          ? data.noteUncontrolled.value
          : this.noteUncontrolled,
      strikeNote: data.strikeNote.present
          ? data.strikeNote.value
          : this.strikeNote,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyLog(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('virtueId: $virtueId, ')
          ..write('strikesCount: $strikesCount, ')
          ..write('noteControlled: $noteControlled, ')
          ..write('noteUncontrolled: $noteUncontrolled, ')
          ..write('strikeNote: $strikeNote')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    virtueId,
    strikesCount,
    noteControlled,
    noteUncontrolled,
    strikeNote,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyLog &&
          other.id == this.id &&
          other.date == this.date &&
          other.virtueId == this.virtueId &&
          other.strikesCount == this.strikesCount &&
          other.noteControlled == this.noteControlled &&
          other.noteUncontrolled == this.noteUncontrolled &&
          other.strikeNote == this.strikeNote);
}

class DailyLogsCompanion extends UpdateCompanion<DailyLog> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> virtueId;
  final Value<int> strikesCount;
  final Value<String?> noteControlled;
  final Value<String?> noteUncontrolled;
  final Value<String?> strikeNote;
  const DailyLogsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.virtueId = const Value.absent(),
    this.strikesCount = const Value.absent(),
    this.noteControlled = const Value.absent(),
    this.noteUncontrolled = const Value.absent(),
    this.strikeNote = const Value.absent(),
  });
  DailyLogsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required int virtueId,
    this.strikesCount = const Value.absent(),
    this.noteControlled = const Value.absent(),
    this.noteUncontrolled = const Value.absent(),
    this.strikeNote = const Value.absent(),
  }) : date = Value(date),
       virtueId = Value(virtueId);
  static Insertable<DailyLog> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? virtueId,
    Expression<int>? strikesCount,
    Expression<String>? noteControlled,
    Expression<String>? noteUncontrolled,
    Expression<String>? strikeNote,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (virtueId != null) 'virtue_id': virtueId,
      if (strikesCount != null) 'strikes_count': strikesCount,
      if (noteControlled != null) 'note_controlled': noteControlled,
      if (noteUncontrolled != null) 'note_uncontrolled': noteUncontrolled,
      if (strikeNote != null) 'strike_note': strikeNote,
    });
  }

  DailyLogsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<int>? virtueId,
    Value<int>? strikesCount,
    Value<String?>? noteControlled,
    Value<String?>? noteUncontrolled,
    Value<String?>? strikeNote,
  }) {
    return DailyLogsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      virtueId: virtueId ?? this.virtueId,
      strikesCount: strikesCount ?? this.strikesCount,
      noteControlled: noteControlled ?? this.noteControlled,
      noteUncontrolled: noteUncontrolled ?? this.noteUncontrolled,
      strikeNote: strikeNote ?? this.strikeNote,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (virtueId.present) {
      map['virtue_id'] = Variable<int>(virtueId.value);
    }
    if (strikesCount.present) {
      map['strikes_count'] = Variable<int>(strikesCount.value);
    }
    if (noteControlled.present) {
      map['note_controlled'] = Variable<String>(noteControlled.value);
    }
    if (noteUncontrolled.present) {
      map['note_uncontrolled'] = Variable<String>(noteUncontrolled.value);
    }
    if (strikeNote.present) {
      map['strike_note'] = Variable<String>(strikeNote.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyLogsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('virtueId: $virtueId, ')
          ..write('strikesCount: $strikesCount, ')
          ..write('noteControlled: $noteControlled, ')
          ..write('noteUncontrolled: $noteUncontrolled, ')
          ..write('strikeNote: $strikeNote')
          ..write(')'))
        .toString();
  }
}

class $PracticeCyclesTable extends PracticeCycles
    with TableInfo<$PracticeCyclesTable, PracticeCycle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PracticeCyclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sequenceNumberMeta = const VerificationMeta(
    'sequenceNumber',
  );
  @override
  late final GeneratedColumn<int> sequenceNumber = GeneratedColumn<int>(
    'sequence_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _successPercentMeta = const VerificationMeta(
    'successPercent',
  );
  @override
  late final GeneratedColumn<int> successPercent = GeneratedColumn<int>(
    'success_percent',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weakPillarIdMeta = const VerificationMeta(
    'weakPillarId',
  );
  @override
  late final GeneratedColumn<int> weakPillarId = GeneratedColumn<int>(
    'weak_pillar_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalStrikesMeta = const VerificationMeta(
    'totalStrikes',
  );
  @override
  late final GeneratedColumn<int> totalStrikes = GeneratedColumn<int>(
    'total_strikes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startedAt,
    endedAt,
    sequenceNumber,
    successPercent,
    weakPillarId,
    totalStrikes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'practice_cycles';
  @override
  VerificationContext validateIntegrity(
    Insertable<PracticeCycle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('sequence_number')) {
      context.handle(
        _sequenceNumberMeta,
        sequenceNumber.isAcceptableOrUnknown(
          data['sequence_number']!,
          _sequenceNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sequenceNumberMeta);
    }
    if (data.containsKey('success_percent')) {
      context.handle(
        _successPercentMeta,
        successPercent.isAcceptableOrUnknown(
          data['success_percent']!,
          _successPercentMeta,
        ),
      );
    }
    if (data.containsKey('weak_pillar_id')) {
      context.handle(
        _weakPillarIdMeta,
        weakPillarId.isAcceptableOrUnknown(
          data['weak_pillar_id']!,
          _weakPillarIdMeta,
        ),
      );
    }
    if (data.containsKey('total_strikes')) {
      context.handle(
        _totalStrikesMeta,
        totalStrikes.isAcceptableOrUnknown(
          data['total_strikes']!,
          _totalStrikesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PracticeCycle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PracticeCycle(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      sequenceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sequence_number'],
      )!,
      successPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}success_percent'],
      ),
      weakPillarId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weak_pillar_id'],
      ),
      totalStrikes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_strikes'],
      ),
    );
  }

  @override
  $PracticeCyclesTable createAlias(String alias) {
    return $PracticeCyclesTable(attachedDatabase, alias);
  }
}

class PracticeCycle extends DataClass implements Insertable<PracticeCycle> {
  final int id;

  /// Понедельник недели 1 (добродетель 1).
  final DateTime startedAt;

  /// null = активный; иначе дата закрытия (обычно [startedAt] + 13 недель).
  final DateTime? endedAt;

  /// Глобальный порядковый номер (1, 2, 3…).
  final int sequenceNumber;

  /// Заполняется при закрытии: средний % успеха (0–100).
  final int? successPercent;

  /// Stoic category id самой слабой колонны в цикле.
  final int? weakPillarId;
  final int? totalStrikes;
  const PracticeCycle({
    required this.id,
    required this.startedAt,
    this.endedAt,
    required this.sequenceNumber,
    this.successPercent,
    this.weakPillarId,
    this.totalStrikes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['sequence_number'] = Variable<int>(sequenceNumber);
    if (!nullToAbsent || successPercent != null) {
      map['success_percent'] = Variable<int>(successPercent);
    }
    if (!nullToAbsent || weakPillarId != null) {
      map['weak_pillar_id'] = Variable<int>(weakPillarId);
    }
    if (!nullToAbsent || totalStrikes != null) {
      map['total_strikes'] = Variable<int>(totalStrikes);
    }
    return map;
  }

  PracticeCyclesCompanion toCompanion(bool nullToAbsent) {
    return PracticeCyclesCompanion(
      id: Value(id),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      sequenceNumber: Value(sequenceNumber),
      successPercent: successPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(successPercent),
      weakPillarId: weakPillarId == null && nullToAbsent
          ? const Value.absent()
          : Value(weakPillarId),
      totalStrikes: totalStrikes == null && nullToAbsent
          ? const Value.absent()
          : Value(totalStrikes),
    );
  }

  factory PracticeCycle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PracticeCycle(
      id: serializer.fromJson<int>(json['id']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      sequenceNumber: serializer.fromJson<int>(json['sequenceNumber']),
      successPercent: serializer.fromJson<int?>(json['successPercent']),
      weakPillarId: serializer.fromJson<int?>(json['weakPillarId']),
      totalStrikes: serializer.fromJson<int?>(json['totalStrikes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'sequenceNumber': serializer.toJson<int>(sequenceNumber),
      'successPercent': serializer.toJson<int?>(successPercent),
      'weakPillarId': serializer.toJson<int?>(weakPillarId),
      'totalStrikes': serializer.toJson<int?>(totalStrikes),
    };
  }

  PracticeCycle copyWith({
    int? id,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    int? sequenceNumber,
    Value<int?> successPercent = const Value.absent(),
    Value<int?> weakPillarId = const Value.absent(),
    Value<int?> totalStrikes = const Value.absent(),
  }) => PracticeCycle(
    id: id ?? this.id,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    sequenceNumber: sequenceNumber ?? this.sequenceNumber,
    successPercent: successPercent.present
        ? successPercent.value
        : this.successPercent,
    weakPillarId: weakPillarId.present ? weakPillarId.value : this.weakPillarId,
    totalStrikes: totalStrikes.present ? totalStrikes.value : this.totalStrikes,
  );
  PracticeCycle copyWithCompanion(PracticeCyclesCompanion data) {
    return PracticeCycle(
      id: data.id.present ? data.id.value : this.id,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      sequenceNumber: data.sequenceNumber.present
          ? data.sequenceNumber.value
          : this.sequenceNumber,
      successPercent: data.successPercent.present
          ? data.successPercent.value
          : this.successPercent,
      weakPillarId: data.weakPillarId.present
          ? data.weakPillarId.value
          : this.weakPillarId,
      totalStrikes: data.totalStrikes.present
          ? data.totalStrikes.value
          : this.totalStrikes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PracticeCycle(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('sequenceNumber: $sequenceNumber, ')
          ..write('successPercent: $successPercent, ')
          ..write('weakPillarId: $weakPillarId, ')
          ..write('totalStrikes: $totalStrikes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    startedAt,
    endedAt,
    sequenceNumber,
    successPercent,
    weakPillarId,
    totalStrikes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PracticeCycle &&
          other.id == this.id &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.sequenceNumber == this.sequenceNumber &&
          other.successPercent == this.successPercent &&
          other.weakPillarId == this.weakPillarId &&
          other.totalStrikes == this.totalStrikes);
}

class PracticeCyclesCompanion extends UpdateCompanion<PracticeCycle> {
  final Value<int> id;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<int> sequenceNumber;
  final Value<int?> successPercent;
  final Value<int?> weakPillarId;
  final Value<int?> totalStrikes;
  const PracticeCyclesCompanion({
    this.id = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.sequenceNumber = const Value.absent(),
    this.successPercent = const Value.absent(),
    this.weakPillarId = const Value.absent(),
    this.totalStrikes = const Value.absent(),
  });
  PracticeCyclesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    required int sequenceNumber,
    this.successPercent = const Value.absent(),
    this.weakPillarId = const Value.absent(),
    this.totalStrikes = const Value.absent(),
  }) : startedAt = Value(startedAt),
       sequenceNumber = Value(sequenceNumber);
  static Insertable<PracticeCycle> custom({
    Expression<int>? id,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? sequenceNumber,
    Expression<int>? successPercent,
    Expression<int>? weakPillarId,
    Expression<int>? totalStrikes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (sequenceNumber != null) 'sequence_number': sequenceNumber,
      if (successPercent != null) 'success_percent': successPercent,
      if (weakPillarId != null) 'weak_pillar_id': weakPillarId,
      if (totalStrikes != null) 'total_strikes': totalStrikes,
    });
  }

  PracticeCyclesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<int>? sequenceNumber,
    Value<int?>? successPercent,
    Value<int?>? weakPillarId,
    Value<int?>? totalStrikes,
  }) {
    return PracticeCyclesCompanion(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      sequenceNumber: sequenceNumber ?? this.sequenceNumber,
      successPercent: successPercent ?? this.successPercent,
      weakPillarId: weakPillarId ?? this.weakPillarId,
      totalStrikes: totalStrikes ?? this.totalStrikes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (sequenceNumber.present) {
      map['sequence_number'] = Variable<int>(sequenceNumber.value);
    }
    if (successPercent.present) {
      map['success_percent'] = Variable<int>(successPercent.value);
    }
    if (weakPillarId.present) {
      map['weak_pillar_id'] = Variable<int>(weakPillarId.value);
    }
    if (totalStrikes.present) {
      map['total_strikes'] = Variable<int>(totalStrikes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PracticeCyclesCompanion(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('sequenceNumber: $sequenceNumber, ')
          ..write('successPercent: $successPercent, ')
          ..write('weakPillarId: $weakPillarId, ')
          ..write('totalStrikes: $totalStrikes')
          ..write(')'))
        .toString();
  }
}

class $StrikeNotesTable extends StrikeNotes
    with TableInfo<$StrikeNotesTable, StrikeNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StrikeNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _virtueIdMeta = const VerificationMeta(
    'virtueId',
  );
  @override
  late final GeneratedColumn<int> virtueId = GeneratedColumn<int>(
    'virtue_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES franklin_virtues (id)',
    ),
  );
  static const VerificationMeta _ordinalMeta = const VerificationMeta(
    'ordinal',
  );
  @override
  late final GeneratedColumn<int> ordinal = GeneratedColumn<int>(
    'ordinal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, date, virtueId, ordinal, body];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'strike_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<StrikeNote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('virtue_id')) {
      context.handle(
        _virtueIdMeta,
        virtueId.isAcceptableOrUnknown(data['virtue_id']!, _virtueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_virtueIdMeta);
    }
    if (data.containsKey('ordinal')) {
      context.handle(
        _ordinalMeta,
        ordinal.isAcceptableOrUnknown(data['ordinal']!, _ordinalMeta),
      );
    } else if (isInserting) {
      context.missing(_ordinalMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {date, virtueId, ordinal},
  ];
  @override
  StrikeNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StrikeNote(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      virtueId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}virtue_id'],
      )!,
      ordinal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ordinal'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
    );
  }

  @override
  $StrikeNotesTable createAlias(String alias) {
    return $StrikeNotesTable(attachedDatabase, alias);
  }
}

class StrikeNote extends DataClass implements Insertable<StrikeNote> {
  final int id;
  final DateTime date;
  final int virtueId;

  /// Порядковый номер проступка в этот день (1 = первый, …).
  final int ordinal;
  final String body;
  const StrikeNote({
    required this.id,
    required this.date,
    required this.virtueId,
    required this.ordinal,
    required this.body,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['virtue_id'] = Variable<int>(virtueId);
    map['ordinal'] = Variable<int>(ordinal);
    map['body'] = Variable<String>(body);
    return map;
  }

  StrikeNotesCompanion toCompanion(bool nullToAbsent) {
    return StrikeNotesCompanion(
      id: Value(id),
      date: Value(date),
      virtueId: Value(virtueId),
      ordinal: Value(ordinal),
      body: Value(body),
    );
  }

  factory StrikeNote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StrikeNote(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      virtueId: serializer.fromJson<int>(json['virtueId']),
      ordinal: serializer.fromJson<int>(json['ordinal']),
      body: serializer.fromJson<String>(json['body']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'virtueId': serializer.toJson<int>(virtueId),
      'ordinal': serializer.toJson<int>(ordinal),
      'body': serializer.toJson<String>(body),
    };
  }

  StrikeNote copyWith({
    int? id,
    DateTime? date,
    int? virtueId,
    int? ordinal,
    String? body,
  }) => StrikeNote(
    id: id ?? this.id,
    date: date ?? this.date,
    virtueId: virtueId ?? this.virtueId,
    ordinal: ordinal ?? this.ordinal,
    body: body ?? this.body,
  );
  StrikeNote copyWithCompanion(StrikeNotesCompanion data) {
    return StrikeNote(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      virtueId: data.virtueId.present ? data.virtueId.value : this.virtueId,
      ordinal: data.ordinal.present ? data.ordinal.value : this.ordinal,
      body: data.body.present ? data.body.value : this.body,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StrikeNote(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('virtueId: $virtueId, ')
          ..write('ordinal: $ordinal, ')
          ..write('body: $body')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, virtueId, ordinal, body);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StrikeNote &&
          other.id == this.id &&
          other.date == this.date &&
          other.virtueId == this.virtueId &&
          other.ordinal == this.ordinal &&
          other.body == this.body);
}

class StrikeNotesCompanion extends UpdateCompanion<StrikeNote> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> virtueId;
  final Value<int> ordinal;
  final Value<String> body;
  const StrikeNotesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.virtueId = const Value.absent(),
    this.ordinal = const Value.absent(),
    this.body = const Value.absent(),
  });
  StrikeNotesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required int virtueId,
    required int ordinal,
    required String body,
  }) : date = Value(date),
       virtueId = Value(virtueId),
       ordinal = Value(ordinal),
       body = Value(body);
  static Insertable<StrikeNote> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? virtueId,
    Expression<int>? ordinal,
    Expression<String>? body,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (virtueId != null) 'virtue_id': virtueId,
      if (ordinal != null) 'ordinal': ordinal,
      if (body != null) 'body': body,
    });
  }

  StrikeNotesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<int>? virtueId,
    Value<int>? ordinal,
    Value<String>? body,
  }) {
    return StrikeNotesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      virtueId: virtueId ?? this.virtueId,
      ordinal: ordinal ?? this.ordinal,
      body: body ?? this.body,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (virtueId.present) {
      map['virtue_id'] = Variable<int>(virtueId.value);
    }
    if (ordinal.present) {
      map['ordinal'] = Variable<int>(ordinal.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StrikeNotesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('virtueId: $virtueId, ')
          ..write('ordinal: $ordinal, ')
          ..write('body: $body')
          ..write(')'))
        .toString();
  }
}

class $XpEventsTable extends XpEvents with TableInfo<$XpEventsTable, XpEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $XpEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES stoic_categories (id)',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _virtueIdMeta = const VerificationMeta(
    'virtueId',
  );
  @override
  late final GeneratedColumn<int> virtueId = GeneratedColumn<int>(
    'virtue_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES franklin_virtues (id)',
    ),
  );
  static const VerificationMeta _eventDateMeta = const VerificationMeta(
    'eventDate',
  );
  @override
  late final GeneratedColumn<DateTime> eventDate = GeneratedColumn<DateTime>(
    'event_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekStartMeta = const VerificationMeta(
    'weekStart',
  );
  @override
  late final GeneratedColumn<DateTime> weekStart = GeneratedColumn<DateTime>(
    'week_start',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dedupeKeyMeta = const VerificationMeta(
    'dedupeKey',
  );
  @override
  late final GeneratedColumn<String> dedupeKey = GeneratedColumn<String>(
    'dedupe_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    amount,
    kind,
    virtueId,
    eventDate,
    weekStart,
    dedupeKey,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'xp_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<XpEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('virtue_id')) {
      context.handle(
        _virtueIdMeta,
        virtueId.isAcceptableOrUnknown(data['virtue_id']!, _virtueIdMeta),
      );
    }
    if (data.containsKey('event_date')) {
      context.handle(
        _eventDateMeta,
        eventDate.isAcceptableOrUnknown(data['event_date']!, _eventDateMeta),
      );
    } else if (isInserting) {
      context.missing(_eventDateMeta);
    }
    if (data.containsKey('week_start')) {
      context.handle(
        _weekStartMeta,
        weekStart.isAcceptableOrUnknown(data['week_start']!, _weekStartMeta),
      );
    }
    if (data.containsKey('dedupe_key')) {
      context.handle(
        _dedupeKeyMeta,
        dedupeKey.isAcceptableOrUnknown(data['dedupe_key']!, _dedupeKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_dedupeKeyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {dedupeKey},
  ];
  @override
  XpEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return XpEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      virtueId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}virtue_id'],
      ),
      eventDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}event_date'],
      )!,
      weekStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}week_start'],
      ),
      dedupeKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dedupe_key'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $XpEventsTable createAlias(String alias) {
    return $XpEventsTable(attachedDatabase, alias);
  }
}

class XpEvent extends DataClass implements Insertable<XpEvent> {
  final int id;
  final int categoryId;

  /// Signed delta (e.g. +150, -10).
  final int amount;

  /// `weekBase` | `cleanDay` | `focusStrike` | `nonFocusStrike` | `archetypeBonus` | `dust`
  final String kind;
  final int? virtueId;

  /// Calendar day the event relates to (clean day / strike day / week Monday).
  final DateTime eventDate;

  /// Focus week Monday; null for lifetime bonuses (archetype).
  final DateTime? weekStart;
  final String dedupeKey;
  final DateTime createdAt;
  const XpEvent({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.kind,
    this.virtueId,
    required this.eventDate,
    this.weekStart,
    required this.dedupeKey,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_id'] = Variable<int>(categoryId);
    map['amount'] = Variable<int>(amount);
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || virtueId != null) {
      map['virtue_id'] = Variable<int>(virtueId);
    }
    map['event_date'] = Variable<DateTime>(eventDate);
    if (!nullToAbsent || weekStart != null) {
      map['week_start'] = Variable<DateTime>(weekStart);
    }
    map['dedupe_key'] = Variable<String>(dedupeKey);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  XpEventsCompanion toCompanion(bool nullToAbsent) {
    return XpEventsCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      amount: Value(amount),
      kind: Value(kind),
      virtueId: virtueId == null && nullToAbsent
          ? const Value.absent()
          : Value(virtueId),
      eventDate: Value(eventDate),
      weekStart: weekStart == null && nullToAbsent
          ? const Value.absent()
          : Value(weekStart),
      dedupeKey: Value(dedupeKey),
      createdAt: Value(createdAt),
    );
  }

  factory XpEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return XpEvent(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      amount: serializer.fromJson<int>(json['amount']),
      kind: serializer.fromJson<String>(json['kind']),
      virtueId: serializer.fromJson<int?>(json['virtueId']),
      eventDate: serializer.fromJson<DateTime>(json['eventDate']),
      weekStart: serializer.fromJson<DateTime?>(json['weekStart']),
      dedupeKey: serializer.fromJson<String>(json['dedupeKey']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<int>(categoryId),
      'amount': serializer.toJson<int>(amount),
      'kind': serializer.toJson<String>(kind),
      'virtueId': serializer.toJson<int?>(virtueId),
      'eventDate': serializer.toJson<DateTime>(eventDate),
      'weekStart': serializer.toJson<DateTime?>(weekStart),
      'dedupeKey': serializer.toJson<String>(dedupeKey),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  XpEvent copyWith({
    int? id,
    int? categoryId,
    int? amount,
    String? kind,
    Value<int?> virtueId = const Value.absent(),
    DateTime? eventDate,
    Value<DateTime?> weekStart = const Value.absent(),
    String? dedupeKey,
    DateTime? createdAt,
  }) => XpEvent(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    amount: amount ?? this.amount,
    kind: kind ?? this.kind,
    virtueId: virtueId.present ? virtueId.value : this.virtueId,
    eventDate: eventDate ?? this.eventDate,
    weekStart: weekStart.present ? weekStart.value : this.weekStart,
    dedupeKey: dedupeKey ?? this.dedupeKey,
    createdAt: createdAt ?? this.createdAt,
  );
  XpEvent copyWithCompanion(XpEventsCompanion data) {
    return XpEvent(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      amount: data.amount.present ? data.amount.value : this.amount,
      kind: data.kind.present ? data.kind.value : this.kind,
      virtueId: data.virtueId.present ? data.virtueId.value : this.virtueId,
      eventDate: data.eventDate.present ? data.eventDate.value : this.eventDate,
      weekStart: data.weekStart.present ? data.weekStart.value : this.weekStart,
      dedupeKey: data.dedupeKey.present ? data.dedupeKey.value : this.dedupeKey,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('XpEvent(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('kind: $kind, ')
          ..write('virtueId: $virtueId, ')
          ..write('eventDate: $eventDate, ')
          ..write('weekStart: $weekStart, ')
          ..write('dedupeKey: $dedupeKey, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoryId,
    amount,
    kind,
    virtueId,
    eventDate,
    weekStart,
    dedupeKey,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is XpEvent &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.amount == this.amount &&
          other.kind == this.kind &&
          other.virtueId == this.virtueId &&
          other.eventDate == this.eventDate &&
          other.weekStart == this.weekStart &&
          other.dedupeKey == this.dedupeKey &&
          other.createdAt == this.createdAt);
}

class XpEventsCompanion extends UpdateCompanion<XpEvent> {
  final Value<int> id;
  final Value<int> categoryId;
  final Value<int> amount;
  final Value<String> kind;
  final Value<int?> virtueId;
  final Value<DateTime> eventDate;
  final Value<DateTime?> weekStart;
  final Value<String> dedupeKey;
  final Value<DateTime> createdAt;
  const XpEventsCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.amount = const Value.absent(),
    this.kind = const Value.absent(),
    this.virtueId = const Value.absent(),
    this.eventDate = const Value.absent(),
    this.weekStart = const Value.absent(),
    this.dedupeKey = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  XpEventsCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    required int amount,
    required String kind,
    this.virtueId = const Value.absent(),
    required DateTime eventDate,
    this.weekStart = const Value.absent(),
    required String dedupeKey,
    this.createdAt = const Value.absent(),
  }) : categoryId = Value(categoryId),
       amount = Value(amount),
       kind = Value(kind),
       eventDate = Value(eventDate),
       dedupeKey = Value(dedupeKey);
  static Insertable<XpEvent> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<int>? amount,
    Expression<String>? kind,
    Expression<int>? virtueId,
    Expression<DateTime>? eventDate,
    Expression<DateTime>? weekStart,
    Expression<String>? dedupeKey,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (amount != null) 'amount': amount,
      if (kind != null) 'kind': kind,
      if (virtueId != null) 'virtue_id': virtueId,
      if (eventDate != null) 'event_date': eventDate,
      if (weekStart != null) 'week_start': weekStart,
      if (dedupeKey != null) 'dedupe_key': dedupeKey,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  XpEventsCompanion copyWith({
    Value<int>? id,
    Value<int>? categoryId,
    Value<int>? amount,
    Value<String>? kind,
    Value<int?>? virtueId,
    Value<DateTime>? eventDate,
    Value<DateTime?>? weekStart,
    Value<String>? dedupeKey,
    Value<DateTime>? createdAt,
  }) {
    return XpEventsCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
      kind: kind ?? this.kind,
      virtueId: virtueId ?? this.virtueId,
      eventDate: eventDate ?? this.eventDate,
      weekStart: weekStart ?? this.weekStart,
      dedupeKey: dedupeKey ?? this.dedupeKey,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (virtueId.present) {
      map['virtue_id'] = Variable<int>(virtueId.value);
    }
    if (eventDate.present) {
      map['event_date'] = Variable<DateTime>(eventDate.value);
    }
    if (weekStart.present) {
      map['week_start'] = Variable<DateTime>(weekStart.value);
    }
    if (dedupeKey.present) {
      map['dedupe_key'] = Variable<String>(dedupeKey.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('XpEventsCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('kind: $kind, ')
          ..write('virtueId: $virtueId, ')
          ..write('eventDate: $eventDate, ')
          ..write('weekStart: $weekStart, ')
          ..write('dedupeKey: $dedupeKey, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $StoicAudiencesTable extends StoicAudiences
    with TableInfo<$StoicAudiencesTable, StoicAudience> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoicAudiencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _virtueWeekNumberMeta = const VerificationMeta(
    'virtueWeekNumber',
  );
  @override
  late final GeneratedColumn<int> virtueWeekNumber = GeneratedColumn<int>(
    'virtue_week_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _virtueLabelMeta = const VerificationMeta(
    'virtueLabel',
  );
  @override
  late final GeneratedColumn<String> virtueLabel = GeneratedColumn<String>(
    'virtue_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _misdeedSummaryMeta = const VerificationMeta(
    'misdeedSummary',
  );
  @override
  late final GeneratedColumn<String> misdeedSummary = GeneratedColumn<String>(
    'misdeed_summary',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _userReflectionMeta = const VerificationMeta(
    'userReflection',
  );
  @override
  late final GeneratedColumn<String> userReflection = GeneratedColumn<String>(
    'user_reflection',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aiResponseMeta = const VerificationMeta(
    'aiResponse',
  );
  @override
  late final GeneratedColumn<String> aiResponse = GeneratedColumn<String>(
    'ai_response',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelIdMeta = const VerificationMeta(
    'modelId',
  );
  @override
  late final GeneratedColumn<String> modelId = GeneratedColumn<String>(
    'model_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _interruptedMeta = const VerificationMeta(
    'interrupted',
  );
  @override
  late final GeneratedColumn<bool> interrupted = GeneratedColumn<bool>(
    'interrupted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("interrupted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    virtueWeekNumber,
    virtueLabel,
    misdeedSummary,
    note,
    userReflection,
    aiResponse,
    modelId,
    interrupted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stoic_audiences';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoicAudience> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('virtue_week_number')) {
      context.handle(
        _virtueWeekNumberMeta,
        virtueWeekNumber.isAcceptableOrUnknown(
          data['virtue_week_number']!,
          _virtueWeekNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_virtueWeekNumberMeta);
    }
    if (data.containsKey('virtue_label')) {
      context.handle(
        _virtueLabelMeta,
        virtueLabel.isAcceptableOrUnknown(
          data['virtue_label']!,
          _virtueLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_virtueLabelMeta);
    }
    if (data.containsKey('misdeed_summary')) {
      context.handle(
        _misdeedSummaryMeta,
        misdeedSummary.isAcceptableOrUnknown(
          data['misdeed_summary']!,
          _misdeedSummaryMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('user_reflection')) {
      context.handle(
        _userReflectionMeta,
        userReflection.isAcceptableOrUnknown(
          data['user_reflection']!,
          _userReflectionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userReflectionMeta);
    }
    if (data.containsKey('ai_response')) {
      context.handle(
        _aiResponseMeta,
        aiResponse.isAcceptableOrUnknown(data['ai_response']!, _aiResponseMeta),
      );
    } else if (isInserting) {
      context.missing(_aiResponseMeta);
    }
    if (data.containsKey('model_id')) {
      context.handle(
        _modelIdMeta,
        modelId.isAcceptableOrUnknown(data['model_id']!, _modelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_modelIdMeta);
    }
    if (data.containsKey('interrupted')) {
      context.handle(
        _interruptedMeta,
        interrupted.isAcceptableOrUnknown(
          data['interrupted']!,
          _interruptedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoicAudience map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoicAudience(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      virtueWeekNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}virtue_week_number'],
      )!,
      virtueLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}virtue_label'],
      )!,
      misdeedSummary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}misdeed_summary'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
      userReflection: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_reflection'],
      )!,
      aiResponse: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ai_response'],
      )!,
      modelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_id'],
      )!,
      interrupted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}interrupted'],
      )!,
    );
  }

  @override
  $StoicAudiencesTable createAlias(String alias) {
    return $StoicAudiencesTable(attachedDatabase, alias);
  }
}

class StoicAudience extends DataClass implements Insertable<StoicAudience> {
  final String id;
  final DateTime createdAt;
  final int virtueWeekNumber;
  final String virtueLabel;
  final String misdeedSummary;
  final String note;
  final String userReflection;
  final String aiResponse;
  final String modelId;
  final bool interrupted;
  const StoicAudience({
    required this.id,
    required this.createdAt,
    required this.virtueWeekNumber,
    required this.virtueLabel,
    required this.misdeedSummary,
    required this.note,
    required this.userReflection,
    required this.aiResponse,
    required this.modelId,
    required this.interrupted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['virtue_week_number'] = Variable<int>(virtueWeekNumber);
    map['virtue_label'] = Variable<String>(virtueLabel);
    map['misdeed_summary'] = Variable<String>(misdeedSummary);
    map['note'] = Variable<String>(note);
    map['user_reflection'] = Variable<String>(userReflection);
    map['ai_response'] = Variable<String>(aiResponse);
    map['model_id'] = Variable<String>(modelId);
    map['interrupted'] = Variable<bool>(interrupted);
    return map;
  }

  StoicAudiencesCompanion toCompanion(bool nullToAbsent) {
    return StoicAudiencesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      virtueWeekNumber: Value(virtueWeekNumber),
      virtueLabel: Value(virtueLabel),
      misdeedSummary: Value(misdeedSummary),
      note: Value(note),
      userReflection: Value(userReflection),
      aiResponse: Value(aiResponse),
      modelId: Value(modelId),
      interrupted: Value(interrupted),
    );
  }

  factory StoicAudience.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoicAudience(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      virtueWeekNumber: serializer.fromJson<int>(json['virtueWeekNumber']),
      virtueLabel: serializer.fromJson<String>(json['virtueLabel']),
      misdeedSummary: serializer.fromJson<String>(json['misdeedSummary']),
      note: serializer.fromJson<String>(json['note']),
      userReflection: serializer.fromJson<String>(json['userReflection']),
      aiResponse: serializer.fromJson<String>(json['aiResponse']),
      modelId: serializer.fromJson<String>(json['modelId']),
      interrupted: serializer.fromJson<bool>(json['interrupted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'virtueWeekNumber': serializer.toJson<int>(virtueWeekNumber),
      'virtueLabel': serializer.toJson<String>(virtueLabel),
      'misdeedSummary': serializer.toJson<String>(misdeedSummary),
      'note': serializer.toJson<String>(note),
      'userReflection': serializer.toJson<String>(userReflection),
      'aiResponse': serializer.toJson<String>(aiResponse),
      'modelId': serializer.toJson<String>(modelId),
      'interrupted': serializer.toJson<bool>(interrupted),
    };
  }

  StoicAudience copyWith({
    String? id,
    DateTime? createdAt,
    int? virtueWeekNumber,
    String? virtueLabel,
    String? misdeedSummary,
    String? note,
    String? userReflection,
    String? aiResponse,
    String? modelId,
    bool? interrupted,
  }) => StoicAudience(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    virtueWeekNumber: virtueWeekNumber ?? this.virtueWeekNumber,
    virtueLabel: virtueLabel ?? this.virtueLabel,
    misdeedSummary: misdeedSummary ?? this.misdeedSummary,
    note: note ?? this.note,
    userReflection: userReflection ?? this.userReflection,
    aiResponse: aiResponse ?? this.aiResponse,
    modelId: modelId ?? this.modelId,
    interrupted: interrupted ?? this.interrupted,
  );
  StoicAudience copyWithCompanion(StoicAudiencesCompanion data) {
    return StoicAudience(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      virtueWeekNumber: data.virtueWeekNumber.present
          ? data.virtueWeekNumber.value
          : this.virtueWeekNumber,
      virtueLabel: data.virtueLabel.present
          ? data.virtueLabel.value
          : this.virtueLabel,
      misdeedSummary: data.misdeedSummary.present
          ? data.misdeedSummary.value
          : this.misdeedSummary,
      note: data.note.present ? data.note.value : this.note,
      userReflection: data.userReflection.present
          ? data.userReflection.value
          : this.userReflection,
      aiResponse: data.aiResponse.present
          ? data.aiResponse.value
          : this.aiResponse,
      modelId: data.modelId.present ? data.modelId.value : this.modelId,
      interrupted: data.interrupted.present
          ? data.interrupted.value
          : this.interrupted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoicAudience(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('virtueWeekNumber: $virtueWeekNumber, ')
          ..write('virtueLabel: $virtueLabel, ')
          ..write('misdeedSummary: $misdeedSummary, ')
          ..write('note: $note, ')
          ..write('userReflection: $userReflection, ')
          ..write('aiResponse: $aiResponse, ')
          ..write('modelId: $modelId, ')
          ..write('interrupted: $interrupted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    virtueWeekNumber,
    virtueLabel,
    misdeedSummary,
    note,
    userReflection,
    aiResponse,
    modelId,
    interrupted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoicAudience &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.virtueWeekNumber == this.virtueWeekNumber &&
          other.virtueLabel == this.virtueLabel &&
          other.misdeedSummary == this.misdeedSummary &&
          other.note == this.note &&
          other.userReflection == this.userReflection &&
          other.aiResponse == this.aiResponse &&
          other.modelId == this.modelId &&
          other.interrupted == this.interrupted);
}

class StoicAudiencesCompanion extends UpdateCompanion<StoicAudience> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<int> virtueWeekNumber;
  final Value<String> virtueLabel;
  final Value<String> misdeedSummary;
  final Value<String> note;
  final Value<String> userReflection;
  final Value<String> aiResponse;
  final Value<String> modelId;
  final Value<bool> interrupted;
  final Value<int> rowid;
  const StoicAudiencesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.virtueWeekNumber = const Value.absent(),
    this.virtueLabel = const Value.absent(),
    this.misdeedSummary = const Value.absent(),
    this.note = const Value.absent(),
    this.userReflection = const Value.absent(),
    this.aiResponse = const Value.absent(),
    this.modelId = const Value.absent(),
    this.interrupted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StoicAudiencesCompanion.insert({
    required String id,
    required DateTime createdAt,
    required int virtueWeekNumber,
    required String virtueLabel,
    this.misdeedSummary = const Value.absent(),
    this.note = const Value.absent(),
    required String userReflection,
    required String aiResponse,
    required String modelId,
    this.interrupted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       virtueWeekNumber = Value(virtueWeekNumber),
       virtueLabel = Value(virtueLabel),
       userReflection = Value(userReflection),
       aiResponse = Value(aiResponse),
       modelId = Value(modelId);
  static Insertable<StoicAudience> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<int>? virtueWeekNumber,
    Expression<String>? virtueLabel,
    Expression<String>? misdeedSummary,
    Expression<String>? note,
    Expression<String>? userReflection,
    Expression<String>? aiResponse,
    Expression<String>? modelId,
    Expression<bool>? interrupted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (virtueWeekNumber != null) 'virtue_week_number': virtueWeekNumber,
      if (virtueLabel != null) 'virtue_label': virtueLabel,
      if (misdeedSummary != null) 'misdeed_summary': misdeedSummary,
      if (note != null) 'note': note,
      if (userReflection != null) 'user_reflection': userReflection,
      if (aiResponse != null) 'ai_response': aiResponse,
      if (modelId != null) 'model_id': modelId,
      if (interrupted != null) 'interrupted': interrupted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StoicAudiencesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<int>? virtueWeekNumber,
    Value<String>? virtueLabel,
    Value<String>? misdeedSummary,
    Value<String>? note,
    Value<String>? userReflection,
    Value<String>? aiResponse,
    Value<String>? modelId,
    Value<bool>? interrupted,
    Value<int>? rowid,
  }) {
    return StoicAudiencesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      virtueWeekNumber: virtueWeekNumber ?? this.virtueWeekNumber,
      virtueLabel: virtueLabel ?? this.virtueLabel,
      misdeedSummary: misdeedSummary ?? this.misdeedSummary,
      note: note ?? this.note,
      userReflection: userReflection ?? this.userReflection,
      aiResponse: aiResponse ?? this.aiResponse,
      modelId: modelId ?? this.modelId,
      interrupted: interrupted ?? this.interrupted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (virtueWeekNumber.present) {
      map['virtue_week_number'] = Variable<int>(virtueWeekNumber.value);
    }
    if (virtueLabel.present) {
      map['virtue_label'] = Variable<String>(virtueLabel.value);
    }
    if (misdeedSummary.present) {
      map['misdeed_summary'] = Variable<String>(misdeedSummary.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (userReflection.present) {
      map['user_reflection'] = Variable<String>(userReflection.value);
    }
    if (aiResponse.present) {
      map['ai_response'] = Variable<String>(aiResponse.value);
    }
    if (modelId.present) {
      map['model_id'] = Variable<String>(modelId.value);
    }
    if (interrupted.present) {
      map['interrupted'] = Variable<bool>(interrupted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoicAudiencesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('virtueWeekNumber: $virtueWeekNumber, ')
          ..write('virtueLabel: $virtueLabel, ')
          ..write('misdeedSummary: $misdeedSummary, ')
          ..write('note: $note, ')
          ..write('userReflection: $userReflection, ')
          ..write('aiResponse: $aiResponse, ')
          ..write('modelId: $modelId, ')
          ..write('interrupted: $interrupted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StoicCategoriesTable stoicCategories = $StoicCategoriesTable(
    this,
  );
  late final $FranklinVirtuesTable franklinVirtues = $FranklinVirtuesTable(
    this,
  );
  late final $DailyLogsTable dailyLogs = $DailyLogsTable(this);
  late final $PracticeCyclesTable practiceCycles = $PracticeCyclesTable(this);
  late final $StrikeNotesTable strikeNotes = $StrikeNotesTable(this);
  late final $XpEventsTable xpEvents = $XpEventsTable(this);
  late final $StoicAudiencesTable stoicAudiences = $StoicAudiencesTable(this);
  late final JournalDao journalDao = JournalDao(this as AppDatabase);
  late final VirtuesDao virtuesDao = VirtuesDao(this as AppDatabase);
  late final CyclesDao cyclesDao = CyclesDao(this as AppDatabase);
  late final XpEventsDao xpEventsDao = XpEventsDao(this as AppDatabase);
  late final AudiencesDao audiencesDao = AudiencesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    stoicCategories,
    franklinVirtues,
    dailyLogs,
    practiceCycles,
    strikeNotes,
    xpEvents,
    stoicAudiences,
  ];
}

typedef $$StoicCategoriesTableCreateCompanionBuilder =
    StoicCategoriesCompanion Function({
      Value<int> id,
      required String name,
      required String description,
      Value<String?> iconPath,
    });
typedef $$StoicCategoriesTableUpdateCompanionBuilder =
    StoicCategoriesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> description,
      Value<String?> iconPath,
    });

final class $$StoicCategoriesTableReferences
    extends
        BaseReferences<_$AppDatabase, $StoicCategoriesTable, StoicCategory> {
  $$StoicCategoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$FranklinVirtuesTable, List<FranklinVirtue>>
  _franklinVirtuesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.franklinVirtues,
    aliasName: 'stoic_categories__id__franklin_virtues__stoic_category_id',
  );

  $$FranklinVirtuesTableProcessedTableManager get franklinVirtuesRefs {
    final manager = $$FranklinVirtuesTableTableManager(
      $_db,
      $_db.franklinVirtues,
    ).filter((f) => f.stoicCategoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _franklinVirtuesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$XpEventsTable, List<XpEvent>> _xpEventsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.xpEvents,
    aliasName: 'stoic_categories__id__xp_events__category_id',
  );

  $$XpEventsTableProcessedTableManager get xpEventsRefs {
    final manager = $$XpEventsTableTableManager(
      $_db,
      $_db.xpEvents,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_xpEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StoicCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $StoicCategoriesTable> {
  $$StoicCategoriesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconPath => $composableBuilder(
    column: $table.iconPath,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> franklinVirtuesRefs(
    Expression<bool> Function($$FranklinVirtuesTableFilterComposer f) f,
  ) {
    final $$FranklinVirtuesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.franklinVirtues,
      getReferencedColumn: (t) => t.stoicCategoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FranklinVirtuesTableFilterComposer(
            $db: $db,
            $table: $db.franklinVirtues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> xpEventsRefs(
    Expression<bool> Function($$XpEventsTableFilterComposer f) f,
  ) {
    final $$XpEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.xpEvents,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$XpEventsTableFilterComposer(
            $db: $db,
            $table: $db.xpEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StoicCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $StoicCategoriesTable> {
  $$StoicCategoriesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconPath => $composableBuilder(
    column: $table.iconPath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StoicCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoicCategoriesTable> {
  $$StoicCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconPath =>
      $composableBuilder(column: $table.iconPath, builder: (column) => column);

  Expression<T> franklinVirtuesRefs<T extends Object>(
    Expression<T> Function($$FranklinVirtuesTableAnnotationComposer a) f,
  ) {
    final $$FranklinVirtuesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.franklinVirtues,
      getReferencedColumn: (t) => t.stoicCategoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FranklinVirtuesTableAnnotationComposer(
            $db: $db,
            $table: $db.franklinVirtues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> xpEventsRefs<T extends Object>(
    Expression<T> Function($$XpEventsTableAnnotationComposer a) f,
  ) {
    final $$XpEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.xpEvents,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$XpEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.xpEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StoicCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StoicCategoriesTable,
          StoicCategory,
          $$StoicCategoriesTableFilterComposer,
          $$StoicCategoriesTableOrderingComposer,
          $$StoicCategoriesTableAnnotationComposer,
          $$StoicCategoriesTableCreateCompanionBuilder,
          $$StoicCategoriesTableUpdateCompanionBuilder,
          (StoicCategory, $$StoicCategoriesTableReferences),
          StoicCategory,
          PrefetchHooks Function({bool franklinVirtuesRefs, bool xpEventsRefs})
        > {
  $$StoicCategoriesTableTableManager(
    _$AppDatabase db,
    $StoicCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoicCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoicCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoicCategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> iconPath = const Value.absent(),
              }) => StoicCategoriesCompanion(
                id: id,
                name: name,
                description: description,
                iconPath: iconPath,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String description,
                Value<String?> iconPath = const Value.absent(),
              }) => StoicCategoriesCompanion.insert(
                id: id,
                name: name,
                description: description,
                iconPath: iconPath,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StoicCategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({franklinVirtuesRefs = false, xpEventsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (franklinVirtuesRefs) db.franklinVirtues,
                    if (xpEventsRefs) db.xpEvents,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (franklinVirtuesRefs)
                        await $_getPrefetchedData<
                          StoicCategory,
                          $StoicCategoriesTable,
                          FranklinVirtue
                        >(
                          currentTable: table,
                          referencedTable: $$StoicCategoriesTableReferences
                              ._franklinVirtuesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StoicCategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).franklinVirtuesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.stoicCategoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (xpEventsRefs)
                        await $_getPrefetchedData<
                          StoicCategory,
                          $StoicCategoriesTable,
                          XpEvent
                        >(
                          currentTable: table,
                          referencedTable: $$StoicCategoriesTableReferences
                              ._xpEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StoicCategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).xpEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
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

typedef $$StoicCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StoicCategoriesTable,
      StoicCategory,
      $$StoicCategoriesTableFilterComposer,
      $$StoicCategoriesTableOrderingComposer,
      $$StoicCategoriesTableAnnotationComposer,
      $$StoicCategoriesTableCreateCompanionBuilder,
      $$StoicCategoriesTableUpdateCompanionBuilder,
      (StoicCategory, $$StoicCategoriesTableReferences),
      StoicCategory,
      PrefetchHooks Function({bool franklinVirtuesRefs, bool xpEventsRefs})
    >;
typedef $$FranklinVirtuesTableCreateCompanionBuilder =
    FranklinVirtuesCompanion Function({
      Value<int> id,
      required int stoicCategoryId,
      required String name,
      required String description,
      Value<String?> customDescription,
      required int defaultWeekNumber,
    });
typedef $$FranklinVirtuesTableUpdateCompanionBuilder =
    FranklinVirtuesCompanion Function({
      Value<int> id,
      Value<int> stoicCategoryId,
      Value<String> name,
      Value<String> description,
      Value<String?> customDescription,
      Value<int> defaultWeekNumber,
    });

final class $$FranklinVirtuesTableReferences
    extends
        BaseReferences<_$AppDatabase, $FranklinVirtuesTable, FranklinVirtue> {
  $$FranklinVirtuesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StoicCategoriesTable _stoicCategoryIdTable(_$AppDatabase db) => db
      .stoicCategories
      .createAlias('franklin_virtues__stoic_category_id__stoic_categories__id');

  $$StoicCategoriesTableProcessedTableManager get stoicCategoryId {
    final $_column = $_itemColumn<int>('stoic_category_id')!;

    final manager = $$StoicCategoriesTableTableManager(
      $_db,
      $_db.stoicCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_stoicCategoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DailyLogsTable, List<DailyLog>>
  _dailyLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.dailyLogs,
    aliasName: 'franklin_virtues__id__daily_logs__virtue_id',
  );

  $$DailyLogsTableProcessedTableManager get dailyLogsRefs {
    final manager = $$DailyLogsTableTableManager(
      $_db,
      $_db.dailyLogs,
    ).filter((f) => f.virtueId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dailyLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StrikeNotesTable, List<StrikeNote>>
  _strikeNotesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.strikeNotes,
    aliasName: 'franklin_virtues__id__strike_notes__virtue_id',
  );

  $$StrikeNotesTableProcessedTableManager get strikeNotesRefs {
    final manager = $$StrikeNotesTableTableManager(
      $_db,
      $_db.strikeNotes,
    ).filter((f) => f.virtueId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_strikeNotesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$XpEventsTable, List<XpEvent>> _xpEventsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.xpEvents,
    aliasName: 'franklin_virtues__id__xp_events__virtue_id',
  );

  $$XpEventsTableProcessedTableManager get xpEventsRefs {
    final manager = $$XpEventsTableTableManager(
      $_db,
      $_db.xpEvents,
    ).filter((f) => f.virtueId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_xpEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FranklinVirtuesTableFilterComposer
    extends Composer<_$AppDatabase, $FranklinVirtuesTable> {
  $$FranklinVirtuesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customDescription => $composableBuilder(
    column: $table.customDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultWeekNumber => $composableBuilder(
    column: $table.defaultWeekNumber,
    builder: (column) => ColumnFilters(column),
  );

  $$StoicCategoriesTableFilterComposer get stoicCategoryId {
    final $$StoicCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stoicCategoryId,
      referencedTable: $db.stoicCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoicCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.stoicCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> dailyLogsRefs(
    Expression<bool> Function($$DailyLogsTableFilterComposer f) f,
  ) {
    final $$DailyLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyLogs,
      getReferencedColumn: (t) => t.virtueId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyLogsTableFilterComposer(
            $db: $db,
            $table: $db.dailyLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> strikeNotesRefs(
    Expression<bool> Function($$StrikeNotesTableFilterComposer f) f,
  ) {
    final $$StrikeNotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.strikeNotes,
      getReferencedColumn: (t) => t.virtueId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StrikeNotesTableFilterComposer(
            $db: $db,
            $table: $db.strikeNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> xpEventsRefs(
    Expression<bool> Function($$XpEventsTableFilterComposer f) f,
  ) {
    final $$XpEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.xpEvents,
      getReferencedColumn: (t) => t.virtueId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$XpEventsTableFilterComposer(
            $db: $db,
            $table: $db.xpEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FranklinVirtuesTableOrderingComposer
    extends Composer<_$AppDatabase, $FranklinVirtuesTable> {
  $$FranklinVirtuesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customDescription => $composableBuilder(
    column: $table.customDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultWeekNumber => $composableBuilder(
    column: $table.defaultWeekNumber,
    builder: (column) => ColumnOrderings(column),
  );

  $$StoicCategoriesTableOrderingComposer get stoicCategoryId {
    final $$StoicCategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stoicCategoryId,
      referencedTable: $db.stoicCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoicCategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.stoicCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FranklinVirtuesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FranklinVirtuesTable> {
  $$FranklinVirtuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customDescription => $composableBuilder(
    column: $table.customDescription,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultWeekNumber => $composableBuilder(
    column: $table.defaultWeekNumber,
    builder: (column) => column,
  );

  $$StoicCategoriesTableAnnotationComposer get stoicCategoryId {
    final $$StoicCategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stoicCategoryId,
      referencedTable: $db.stoicCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoicCategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.stoicCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> dailyLogsRefs<T extends Object>(
    Expression<T> Function($$DailyLogsTableAnnotationComposer a) f,
  ) {
    final $$DailyLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyLogs,
      getReferencedColumn: (t) => t.virtueId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> strikeNotesRefs<T extends Object>(
    Expression<T> Function($$StrikeNotesTableAnnotationComposer a) f,
  ) {
    final $$StrikeNotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.strikeNotes,
      getReferencedColumn: (t) => t.virtueId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StrikeNotesTableAnnotationComposer(
            $db: $db,
            $table: $db.strikeNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> xpEventsRefs<T extends Object>(
    Expression<T> Function($$XpEventsTableAnnotationComposer a) f,
  ) {
    final $$XpEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.xpEvents,
      getReferencedColumn: (t) => t.virtueId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$XpEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.xpEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FranklinVirtuesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FranklinVirtuesTable,
          FranklinVirtue,
          $$FranklinVirtuesTableFilterComposer,
          $$FranklinVirtuesTableOrderingComposer,
          $$FranklinVirtuesTableAnnotationComposer,
          $$FranklinVirtuesTableCreateCompanionBuilder,
          $$FranklinVirtuesTableUpdateCompanionBuilder,
          (FranklinVirtue, $$FranklinVirtuesTableReferences),
          FranklinVirtue,
          PrefetchHooks Function({
            bool stoicCategoryId,
            bool dailyLogsRefs,
            bool strikeNotesRefs,
            bool xpEventsRefs,
          })
        > {
  $$FranklinVirtuesTableTableManager(
    _$AppDatabase db,
    $FranklinVirtuesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FranklinVirtuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FranklinVirtuesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FranklinVirtuesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> stoicCategoryId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> customDescription = const Value.absent(),
                Value<int> defaultWeekNumber = const Value.absent(),
              }) => FranklinVirtuesCompanion(
                id: id,
                stoicCategoryId: stoicCategoryId,
                name: name,
                description: description,
                customDescription: customDescription,
                defaultWeekNumber: defaultWeekNumber,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int stoicCategoryId,
                required String name,
                required String description,
                Value<String?> customDescription = const Value.absent(),
                required int defaultWeekNumber,
              }) => FranklinVirtuesCompanion.insert(
                id: id,
                stoicCategoryId: stoicCategoryId,
                name: name,
                description: description,
                customDescription: customDescription,
                defaultWeekNumber: defaultWeekNumber,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FranklinVirtuesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                stoicCategoryId = false,
                dailyLogsRefs = false,
                strikeNotesRefs = false,
                xpEventsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (dailyLogsRefs) db.dailyLogs,
                    if (strikeNotesRefs) db.strikeNotes,
                    if (xpEventsRefs) db.xpEvents,
                  ],
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
                        if (stoicCategoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.stoicCategoryId,
                                    referencedTable:
                                        $$FranklinVirtuesTableReferences
                                            ._stoicCategoryIdTable(db),
                                    referencedColumn:
                                        $$FranklinVirtuesTableReferences
                                            ._stoicCategoryIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (dailyLogsRefs)
                        await $_getPrefetchedData<
                          FranklinVirtue,
                          $FranklinVirtuesTable,
                          DailyLog
                        >(
                          currentTable: table,
                          referencedTable: $$FranklinVirtuesTableReferences
                              ._dailyLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FranklinVirtuesTableReferences(
                                db,
                                table,
                                p0,
                              ).dailyLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.virtueId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (strikeNotesRefs)
                        await $_getPrefetchedData<
                          FranklinVirtue,
                          $FranklinVirtuesTable,
                          StrikeNote
                        >(
                          currentTable: table,
                          referencedTable: $$FranklinVirtuesTableReferences
                              ._strikeNotesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FranklinVirtuesTableReferences(
                                db,
                                table,
                                p0,
                              ).strikeNotesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.virtueId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (xpEventsRefs)
                        await $_getPrefetchedData<
                          FranklinVirtue,
                          $FranklinVirtuesTable,
                          XpEvent
                        >(
                          currentTable: table,
                          referencedTable: $$FranklinVirtuesTableReferences
                              ._xpEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FranklinVirtuesTableReferences(
                                db,
                                table,
                                p0,
                              ).xpEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.virtueId == item.id,
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

typedef $$FranklinVirtuesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FranklinVirtuesTable,
      FranklinVirtue,
      $$FranklinVirtuesTableFilterComposer,
      $$FranklinVirtuesTableOrderingComposer,
      $$FranklinVirtuesTableAnnotationComposer,
      $$FranklinVirtuesTableCreateCompanionBuilder,
      $$FranklinVirtuesTableUpdateCompanionBuilder,
      (FranklinVirtue, $$FranklinVirtuesTableReferences),
      FranklinVirtue,
      PrefetchHooks Function({
        bool stoicCategoryId,
        bool dailyLogsRefs,
        bool strikeNotesRefs,
        bool xpEventsRefs,
      })
    >;
typedef $$DailyLogsTableCreateCompanionBuilder =
    DailyLogsCompanion Function({
      Value<int> id,
      required DateTime date,
      required int virtueId,
      Value<int> strikesCount,
      Value<String?> noteControlled,
      Value<String?> noteUncontrolled,
      Value<String?> strikeNote,
    });
typedef $$DailyLogsTableUpdateCompanionBuilder =
    DailyLogsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<int> virtueId,
      Value<int> strikesCount,
      Value<String?> noteControlled,
      Value<String?> noteUncontrolled,
      Value<String?> strikeNote,
    });

final class $$DailyLogsTableReferences
    extends BaseReferences<_$AppDatabase, $DailyLogsTable, DailyLog> {
  $$DailyLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FranklinVirtuesTable _virtueIdTable(_$AppDatabase db) => db
      .franklinVirtues
      .createAlias('daily_logs__virtue_id__franklin_virtues__id');

  $$FranklinVirtuesTableProcessedTableManager get virtueId {
    final $_column = $_itemColumn<int>('virtue_id')!;

    final manager = $$FranklinVirtuesTableTableManager(
      $_db,
      $_db.franklinVirtues,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_virtueIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DailyLogsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyLogsTable> {
  $$DailyLogsTableFilterComposer({
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

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get strikesCount => $composableBuilder(
    column: $table.strikesCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get noteControlled => $composableBuilder(
    column: $table.noteControlled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get noteUncontrolled => $composableBuilder(
    column: $table.noteUncontrolled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get strikeNote => $composableBuilder(
    column: $table.strikeNote,
    builder: (column) => ColumnFilters(column),
  );

  $$FranklinVirtuesTableFilterComposer get virtueId {
    final $$FranklinVirtuesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.virtueId,
      referencedTable: $db.franklinVirtues,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FranklinVirtuesTableFilterComposer(
            $db: $db,
            $table: $db.franklinVirtues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyLogsTable> {
  $$DailyLogsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get strikesCount => $composableBuilder(
    column: $table.strikesCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get noteControlled => $composableBuilder(
    column: $table.noteControlled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get noteUncontrolled => $composableBuilder(
    column: $table.noteUncontrolled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get strikeNote => $composableBuilder(
    column: $table.strikeNote,
    builder: (column) => ColumnOrderings(column),
  );

  $$FranklinVirtuesTableOrderingComposer get virtueId {
    final $$FranklinVirtuesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.virtueId,
      referencedTable: $db.franklinVirtues,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FranklinVirtuesTableOrderingComposer(
            $db: $db,
            $table: $db.franklinVirtues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyLogsTable> {
  $$DailyLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get strikesCount => $composableBuilder(
    column: $table.strikesCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get noteControlled => $composableBuilder(
    column: $table.noteControlled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get noteUncontrolled => $composableBuilder(
    column: $table.noteUncontrolled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get strikeNote => $composableBuilder(
    column: $table.strikeNote,
    builder: (column) => column,
  );

  $$FranklinVirtuesTableAnnotationComposer get virtueId {
    final $$FranklinVirtuesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.virtueId,
      referencedTable: $db.franklinVirtues,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FranklinVirtuesTableAnnotationComposer(
            $db: $db,
            $table: $db.franklinVirtues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyLogsTable,
          DailyLog,
          $$DailyLogsTableFilterComposer,
          $$DailyLogsTableOrderingComposer,
          $$DailyLogsTableAnnotationComposer,
          $$DailyLogsTableCreateCompanionBuilder,
          $$DailyLogsTableUpdateCompanionBuilder,
          (DailyLog, $$DailyLogsTableReferences),
          DailyLog,
          PrefetchHooks Function({bool virtueId})
        > {
  $$DailyLogsTableTableManager(_$AppDatabase db, $DailyLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> virtueId = const Value.absent(),
                Value<int> strikesCount = const Value.absent(),
                Value<String?> noteControlled = const Value.absent(),
                Value<String?> noteUncontrolled = const Value.absent(),
                Value<String?> strikeNote = const Value.absent(),
              }) => DailyLogsCompanion(
                id: id,
                date: date,
                virtueId: virtueId,
                strikesCount: strikesCount,
                noteControlled: noteControlled,
                noteUncontrolled: noteUncontrolled,
                strikeNote: strikeNote,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required int virtueId,
                Value<int> strikesCount = const Value.absent(),
                Value<String?> noteControlled = const Value.absent(),
                Value<String?> noteUncontrolled = const Value.absent(),
                Value<String?> strikeNote = const Value.absent(),
              }) => DailyLogsCompanion.insert(
                id: id,
                date: date,
                virtueId: virtueId,
                strikesCount: strikesCount,
                noteControlled: noteControlled,
                noteUncontrolled: noteUncontrolled,
                strikeNote: strikeNote,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DailyLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({virtueId = false}) {
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
                    if (virtueId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.virtueId,
                                referencedTable: $$DailyLogsTableReferences
                                    ._virtueIdTable(db),
                                referencedColumn: $$DailyLogsTableReferences
                                    ._virtueIdTable(db)
                                    .id,
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

typedef $$DailyLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyLogsTable,
      DailyLog,
      $$DailyLogsTableFilterComposer,
      $$DailyLogsTableOrderingComposer,
      $$DailyLogsTableAnnotationComposer,
      $$DailyLogsTableCreateCompanionBuilder,
      $$DailyLogsTableUpdateCompanionBuilder,
      (DailyLog, $$DailyLogsTableReferences),
      DailyLog,
      PrefetchHooks Function({bool virtueId})
    >;
typedef $$PracticeCyclesTableCreateCompanionBuilder =
    PracticeCyclesCompanion Function({
      Value<int> id,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      required int sequenceNumber,
      Value<int?> successPercent,
      Value<int?> weakPillarId,
      Value<int?> totalStrikes,
    });
typedef $$PracticeCyclesTableUpdateCompanionBuilder =
    PracticeCyclesCompanion Function({
      Value<int> id,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<int> sequenceNumber,
      Value<int?> successPercent,
      Value<int?> weakPillarId,
      Value<int?> totalStrikes,
    });

class $$PracticeCyclesTableFilterComposer
    extends Composer<_$AppDatabase, $PracticeCyclesTable> {
  $$PracticeCyclesTableFilterComposer({
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

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sequenceNumber => $composableBuilder(
    column: $table.sequenceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get successPercent => $composableBuilder(
    column: $table.successPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weakPillarId => $composableBuilder(
    column: $table.weakPillarId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalStrikes => $composableBuilder(
    column: $table.totalStrikes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PracticeCyclesTableOrderingComposer
    extends Composer<_$AppDatabase, $PracticeCyclesTable> {
  $$PracticeCyclesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sequenceNumber => $composableBuilder(
    column: $table.sequenceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get successPercent => $composableBuilder(
    column: $table.successPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weakPillarId => $composableBuilder(
    column: $table.weakPillarId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalStrikes => $composableBuilder(
    column: $table.totalStrikes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PracticeCyclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PracticeCyclesTable> {
  $$PracticeCyclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get sequenceNumber => $composableBuilder(
    column: $table.sequenceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get successPercent => $composableBuilder(
    column: $table.successPercent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get weakPillarId => $composableBuilder(
    column: $table.weakPillarId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalStrikes => $composableBuilder(
    column: $table.totalStrikes,
    builder: (column) => column,
  );
}

class $$PracticeCyclesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PracticeCyclesTable,
          PracticeCycle,
          $$PracticeCyclesTableFilterComposer,
          $$PracticeCyclesTableOrderingComposer,
          $$PracticeCyclesTableAnnotationComposer,
          $$PracticeCyclesTableCreateCompanionBuilder,
          $$PracticeCyclesTableUpdateCompanionBuilder,
          (
            PracticeCycle,
            BaseReferences<_$AppDatabase, $PracticeCyclesTable, PracticeCycle>,
          ),
          PracticeCycle,
          PrefetchHooks Function()
        > {
  $$PracticeCyclesTableTableManager(
    _$AppDatabase db,
    $PracticeCyclesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PracticeCyclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PracticeCyclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PracticeCyclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int> sequenceNumber = const Value.absent(),
                Value<int?> successPercent = const Value.absent(),
                Value<int?> weakPillarId = const Value.absent(),
                Value<int?> totalStrikes = const Value.absent(),
              }) => PracticeCyclesCompanion(
                id: id,
                startedAt: startedAt,
                endedAt: endedAt,
                sequenceNumber: sequenceNumber,
                successPercent: successPercent,
                weakPillarId: weakPillarId,
                totalStrikes: totalStrikes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                required int sequenceNumber,
                Value<int?> successPercent = const Value.absent(),
                Value<int?> weakPillarId = const Value.absent(),
                Value<int?> totalStrikes = const Value.absent(),
              }) => PracticeCyclesCompanion.insert(
                id: id,
                startedAt: startedAt,
                endedAt: endedAt,
                sequenceNumber: sequenceNumber,
                successPercent: successPercent,
                weakPillarId: weakPillarId,
                totalStrikes: totalStrikes,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PracticeCyclesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PracticeCyclesTable,
      PracticeCycle,
      $$PracticeCyclesTableFilterComposer,
      $$PracticeCyclesTableOrderingComposer,
      $$PracticeCyclesTableAnnotationComposer,
      $$PracticeCyclesTableCreateCompanionBuilder,
      $$PracticeCyclesTableUpdateCompanionBuilder,
      (
        PracticeCycle,
        BaseReferences<_$AppDatabase, $PracticeCyclesTable, PracticeCycle>,
      ),
      PracticeCycle,
      PrefetchHooks Function()
    >;
typedef $$StrikeNotesTableCreateCompanionBuilder =
    StrikeNotesCompanion Function({
      Value<int> id,
      required DateTime date,
      required int virtueId,
      required int ordinal,
      required String body,
    });
typedef $$StrikeNotesTableUpdateCompanionBuilder =
    StrikeNotesCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<int> virtueId,
      Value<int> ordinal,
      Value<String> body,
    });

final class $$StrikeNotesTableReferences
    extends BaseReferences<_$AppDatabase, $StrikeNotesTable, StrikeNote> {
  $$StrikeNotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FranklinVirtuesTable _virtueIdTable(_$AppDatabase db) => db
      .franklinVirtues
      .createAlias('strike_notes__virtue_id__franklin_virtues__id');

  $$FranklinVirtuesTableProcessedTableManager get virtueId {
    final $_column = $_itemColumn<int>('virtue_id')!;

    final manager = $$FranklinVirtuesTableTableManager(
      $_db,
      $_db.franklinVirtues,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_virtueIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StrikeNotesTableFilterComposer
    extends Composer<_$AppDatabase, $StrikeNotesTable> {
  $$StrikeNotesTableFilterComposer({
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

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  $$FranklinVirtuesTableFilterComposer get virtueId {
    final $$FranklinVirtuesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.virtueId,
      referencedTable: $db.franklinVirtues,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FranklinVirtuesTableFilterComposer(
            $db: $db,
            $table: $db.franklinVirtues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StrikeNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $StrikeNotesTable> {
  $$StrikeNotesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  $$FranklinVirtuesTableOrderingComposer get virtueId {
    final $$FranklinVirtuesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.virtueId,
      referencedTable: $db.franklinVirtues,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FranklinVirtuesTableOrderingComposer(
            $db: $db,
            $table: $db.franklinVirtues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StrikeNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StrikeNotesTable> {
  $$StrikeNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get ordinal =>
      $composableBuilder(column: $table.ordinal, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  $$FranklinVirtuesTableAnnotationComposer get virtueId {
    final $$FranklinVirtuesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.virtueId,
      referencedTable: $db.franklinVirtues,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FranklinVirtuesTableAnnotationComposer(
            $db: $db,
            $table: $db.franklinVirtues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StrikeNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StrikeNotesTable,
          StrikeNote,
          $$StrikeNotesTableFilterComposer,
          $$StrikeNotesTableOrderingComposer,
          $$StrikeNotesTableAnnotationComposer,
          $$StrikeNotesTableCreateCompanionBuilder,
          $$StrikeNotesTableUpdateCompanionBuilder,
          (StrikeNote, $$StrikeNotesTableReferences),
          StrikeNote,
          PrefetchHooks Function({bool virtueId})
        > {
  $$StrikeNotesTableTableManager(_$AppDatabase db, $StrikeNotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StrikeNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StrikeNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StrikeNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> virtueId = const Value.absent(),
                Value<int> ordinal = const Value.absent(),
                Value<String> body = const Value.absent(),
              }) => StrikeNotesCompanion(
                id: id,
                date: date,
                virtueId: virtueId,
                ordinal: ordinal,
                body: body,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required int virtueId,
                required int ordinal,
                required String body,
              }) => StrikeNotesCompanion.insert(
                id: id,
                date: date,
                virtueId: virtueId,
                ordinal: ordinal,
                body: body,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StrikeNotesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({virtueId = false}) {
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
                    if (virtueId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.virtueId,
                                referencedTable: $$StrikeNotesTableReferences
                                    ._virtueIdTable(db),
                                referencedColumn: $$StrikeNotesTableReferences
                                    ._virtueIdTable(db)
                                    .id,
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

typedef $$StrikeNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StrikeNotesTable,
      StrikeNote,
      $$StrikeNotesTableFilterComposer,
      $$StrikeNotesTableOrderingComposer,
      $$StrikeNotesTableAnnotationComposer,
      $$StrikeNotesTableCreateCompanionBuilder,
      $$StrikeNotesTableUpdateCompanionBuilder,
      (StrikeNote, $$StrikeNotesTableReferences),
      StrikeNote,
      PrefetchHooks Function({bool virtueId})
    >;
typedef $$XpEventsTableCreateCompanionBuilder =
    XpEventsCompanion Function({
      Value<int> id,
      required int categoryId,
      required int amount,
      required String kind,
      Value<int?> virtueId,
      required DateTime eventDate,
      Value<DateTime?> weekStart,
      required String dedupeKey,
      Value<DateTime> createdAt,
    });
typedef $$XpEventsTableUpdateCompanionBuilder =
    XpEventsCompanion Function({
      Value<int> id,
      Value<int> categoryId,
      Value<int> amount,
      Value<String> kind,
      Value<int?> virtueId,
      Value<DateTime> eventDate,
      Value<DateTime?> weekStart,
      Value<String> dedupeKey,
      Value<DateTime> createdAt,
    });

final class $$XpEventsTableReferences
    extends BaseReferences<_$AppDatabase, $XpEventsTable, XpEvent> {
  $$XpEventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StoicCategoriesTable _categoryIdTable(_$AppDatabase db) => db
      .stoicCategories
      .createAlias('xp_events__category_id__stoic_categories__id');

  $$StoicCategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$StoicCategoriesTableTableManager(
      $_db,
      $_db.stoicCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FranklinVirtuesTable _virtueIdTable(_$AppDatabase db) => db
      .franklinVirtues
      .createAlias('xp_events__virtue_id__franklin_virtues__id');

  $$FranklinVirtuesTableProcessedTableManager? get virtueId {
    final $_column = $_itemColumn<int>('virtue_id');
    if ($_column == null) return null;
    final manager = $$FranklinVirtuesTableTableManager(
      $_db,
      $_db.franklinVirtues,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_virtueIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$XpEventsTableFilterComposer
    extends Composer<_$AppDatabase, $XpEventsTable> {
  $$XpEventsTableFilterComposer({
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

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get eventDate => $composableBuilder(
    column: $table.eventDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get weekStart => $composableBuilder(
    column: $table.weekStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dedupeKey => $composableBuilder(
    column: $table.dedupeKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$StoicCategoriesTableFilterComposer get categoryId {
    final $$StoicCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.stoicCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoicCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.stoicCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FranklinVirtuesTableFilterComposer get virtueId {
    final $$FranklinVirtuesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.virtueId,
      referencedTable: $db.franklinVirtues,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FranklinVirtuesTableFilterComposer(
            $db: $db,
            $table: $db.franklinVirtues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$XpEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $XpEventsTable> {
  $$XpEventsTableOrderingComposer({
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

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get eventDate => $composableBuilder(
    column: $table.eventDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get weekStart => $composableBuilder(
    column: $table.weekStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dedupeKey => $composableBuilder(
    column: $table.dedupeKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$StoicCategoriesTableOrderingComposer get categoryId {
    final $$StoicCategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.stoicCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoicCategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.stoicCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FranklinVirtuesTableOrderingComposer get virtueId {
    final $$FranklinVirtuesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.virtueId,
      referencedTable: $db.franklinVirtues,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FranklinVirtuesTableOrderingComposer(
            $db: $db,
            $table: $db.franklinVirtues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$XpEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $XpEventsTable> {
  $$XpEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<DateTime> get eventDate =>
      $composableBuilder(column: $table.eventDate, builder: (column) => column);

  GeneratedColumn<DateTime> get weekStart =>
      $composableBuilder(column: $table.weekStart, builder: (column) => column);

  GeneratedColumn<String> get dedupeKey =>
      $composableBuilder(column: $table.dedupeKey, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$StoicCategoriesTableAnnotationComposer get categoryId {
    final $$StoicCategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.stoicCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoicCategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.stoicCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FranklinVirtuesTableAnnotationComposer get virtueId {
    final $$FranklinVirtuesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.virtueId,
      referencedTable: $db.franklinVirtues,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FranklinVirtuesTableAnnotationComposer(
            $db: $db,
            $table: $db.franklinVirtues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$XpEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $XpEventsTable,
          XpEvent,
          $$XpEventsTableFilterComposer,
          $$XpEventsTableOrderingComposer,
          $$XpEventsTableAnnotationComposer,
          $$XpEventsTableCreateCompanionBuilder,
          $$XpEventsTableUpdateCompanionBuilder,
          (XpEvent, $$XpEventsTableReferences),
          XpEvent,
          PrefetchHooks Function({bool categoryId, bool virtueId})
        > {
  $$XpEventsTableTableManager(_$AppDatabase db, $XpEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$XpEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$XpEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$XpEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int?> virtueId = const Value.absent(),
                Value<DateTime> eventDate = const Value.absent(),
                Value<DateTime?> weekStart = const Value.absent(),
                Value<String> dedupeKey = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => XpEventsCompanion(
                id: id,
                categoryId: categoryId,
                amount: amount,
                kind: kind,
                virtueId: virtueId,
                eventDate: eventDate,
                weekStart: weekStart,
                dedupeKey: dedupeKey,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int categoryId,
                required int amount,
                required String kind,
                Value<int?> virtueId = const Value.absent(),
                required DateTime eventDate,
                Value<DateTime?> weekStart = const Value.absent(),
                required String dedupeKey,
                Value<DateTime> createdAt = const Value.absent(),
              }) => XpEventsCompanion.insert(
                id: id,
                categoryId: categoryId,
                amount: amount,
                kind: kind,
                virtueId: virtueId,
                eventDate: eventDate,
                weekStart: weekStart,
                dedupeKey: dedupeKey,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$XpEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false, virtueId = false}) {
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
                    if (categoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.categoryId,
                                referencedTable: $$XpEventsTableReferences
                                    ._categoryIdTable(db),
                                referencedColumn: $$XpEventsTableReferences
                                    ._categoryIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (virtueId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.virtueId,
                                referencedTable: $$XpEventsTableReferences
                                    ._virtueIdTable(db),
                                referencedColumn: $$XpEventsTableReferences
                                    ._virtueIdTable(db)
                                    .id,
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

typedef $$XpEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $XpEventsTable,
      XpEvent,
      $$XpEventsTableFilterComposer,
      $$XpEventsTableOrderingComposer,
      $$XpEventsTableAnnotationComposer,
      $$XpEventsTableCreateCompanionBuilder,
      $$XpEventsTableUpdateCompanionBuilder,
      (XpEvent, $$XpEventsTableReferences),
      XpEvent,
      PrefetchHooks Function({bool categoryId, bool virtueId})
    >;
typedef $$StoicAudiencesTableCreateCompanionBuilder =
    StoicAudiencesCompanion Function({
      required String id,
      required DateTime createdAt,
      required int virtueWeekNumber,
      required String virtueLabel,
      Value<String> misdeedSummary,
      Value<String> note,
      required String userReflection,
      required String aiResponse,
      required String modelId,
      Value<bool> interrupted,
      Value<int> rowid,
    });
typedef $$StoicAudiencesTableUpdateCompanionBuilder =
    StoicAudiencesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<int> virtueWeekNumber,
      Value<String> virtueLabel,
      Value<String> misdeedSummary,
      Value<String> note,
      Value<String> userReflection,
      Value<String> aiResponse,
      Value<String> modelId,
      Value<bool> interrupted,
      Value<int> rowid,
    });

class $$StoicAudiencesTableFilterComposer
    extends Composer<_$AppDatabase, $StoicAudiencesTable> {
  $$StoicAudiencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get virtueWeekNumber => $composableBuilder(
    column: $table.virtueWeekNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get virtueLabel => $composableBuilder(
    column: $table.virtueLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get misdeedSummary => $composableBuilder(
    column: $table.misdeedSummary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userReflection => $composableBuilder(
    column: $table.userReflection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aiResponse => $composableBuilder(
    column: $table.aiResponse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelId => $composableBuilder(
    column: $table.modelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get interrupted => $composableBuilder(
    column: $table.interrupted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StoicAudiencesTableOrderingComposer
    extends Composer<_$AppDatabase, $StoicAudiencesTable> {
  $$StoicAudiencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get virtueWeekNumber => $composableBuilder(
    column: $table.virtueWeekNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get virtueLabel => $composableBuilder(
    column: $table.virtueLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get misdeedSummary => $composableBuilder(
    column: $table.misdeedSummary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userReflection => $composableBuilder(
    column: $table.userReflection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aiResponse => $composableBuilder(
    column: $table.aiResponse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelId => $composableBuilder(
    column: $table.modelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get interrupted => $composableBuilder(
    column: $table.interrupted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StoicAudiencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoicAudiencesTable> {
  $$StoicAudiencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get virtueWeekNumber => $composableBuilder(
    column: $table.virtueWeekNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get virtueLabel => $composableBuilder(
    column: $table.virtueLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get misdeedSummary => $composableBuilder(
    column: $table.misdeedSummary,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get userReflection => $composableBuilder(
    column: $table.userReflection,
    builder: (column) => column,
  );

  GeneratedColumn<String> get aiResponse => $composableBuilder(
    column: $table.aiResponse,
    builder: (column) => column,
  );

  GeneratedColumn<String> get modelId =>
      $composableBuilder(column: $table.modelId, builder: (column) => column);

  GeneratedColumn<bool> get interrupted => $composableBuilder(
    column: $table.interrupted,
    builder: (column) => column,
  );
}

class $$StoicAudiencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StoicAudiencesTable,
          StoicAudience,
          $$StoicAudiencesTableFilterComposer,
          $$StoicAudiencesTableOrderingComposer,
          $$StoicAudiencesTableAnnotationComposer,
          $$StoicAudiencesTableCreateCompanionBuilder,
          $$StoicAudiencesTableUpdateCompanionBuilder,
          (
            StoicAudience,
            BaseReferences<_$AppDatabase, $StoicAudiencesTable, StoicAudience>,
          ),
          StoicAudience,
          PrefetchHooks Function()
        > {
  $$StoicAudiencesTableTableManager(
    _$AppDatabase db,
    $StoicAudiencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoicAudiencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoicAudiencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoicAudiencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> virtueWeekNumber = const Value.absent(),
                Value<String> virtueLabel = const Value.absent(),
                Value<String> misdeedSummary = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<String> userReflection = const Value.absent(),
                Value<String> aiResponse = const Value.absent(),
                Value<String> modelId = const Value.absent(),
                Value<bool> interrupted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StoicAudiencesCompanion(
                id: id,
                createdAt: createdAt,
                virtueWeekNumber: virtueWeekNumber,
                virtueLabel: virtueLabel,
                misdeedSummary: misdeedSummary,
                note: note,
                userReflection: userReflection,
                aiResponse: aiResponse,
                modelId: modelId,
                interrupted: interrupted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                required int virtueWeekNumber,
                required String virtueLabel,
                Value<String> misdeedSummary = const Value.absent(),
                Value<String> note = const Value.absent(),
                required String userReflection,
                required String aiResponse,
                required String modelId,
                Value<bool> interrupted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StoicAudiencesCompanion.insert(
                id: id,
                createdAt: createdAt,
                virtueWeekNumber: virtueWeekNumber,
                virtueLabel: virtueLabel,
                misdeedSummary: misdeedSummary,
                note: note,
                userReflection: userReflection,
                aiResponse: aiResponse,
                modelId: modelId,
                interrupted: interrupted,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StoicAudiencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StoicAudiencesTable,
      StoicAudience,
      $$StoicAudiencesTableFilterComposer,
      $$StoicAudiencesTableOrderingComposer,
      $$StoicAudiencesTableAnnotationComposer,
      $$StoicAudiencesTableCreateCompanionBuilder,
      $$StoicAudiencesTableUpdateCompanionBuilder,
      (
        StoicAudience,
        BaseReferences<_$AppDatabase, $StoicAudiencesTable, StoicAudience>,
      ),
      StoicAudience,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StoicCategoriesTableTableManager get stoicCategories =>
      $$StoicCategoriesTableTableManager(_db, _db.stoicCategories);
  $$FranklinVirtuesTableTableManager get franklinVirtues =>
      $$FranklinVirtuesTableTableManager(_db, _db.franklinVirtues);
  $$DailyLogsTableTableManager get dailyLogs =>
      $$DailyLogsTableTableManager(_db, _db.dailyLogs);
  $$PracticeCyclesTableTableManager get practiceCycles =>
      $$PracticeCyclesTableTableManager(_db, _db.practiceCycles);
  $$StrikeNotesTableTableManager get strikeNotes =>
      $$StrikeNotesTableTableManager(_db, _db.strikeNotes);
  $$XpEventsTableTableManager get xpEvents =>
      $$XpEventsTableTableManager(_db, _db.xpEvents);
  $$StoicAudiencesTableTableManager get stoicAudiences =>
      $$StoicAudiencesTableTableManager(_db, _db.stoicAudiences);
}
