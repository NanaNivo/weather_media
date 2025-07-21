class WeatherMeta {
  Meta? meta;
  List<DataWeather>? data;

  WeatherMeta({this.meta, this.data});

  WeatherMeta.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;

    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataWeather.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['meta'] = meta?.toJson();
    data['data'] = this.data?.map((v) => v.toJson()).toList();
    return data;
  }
}

class Meta {
  double? execTime;
  String? generated;

  Meta({this.execTime, this.generated});

  Meta.fromJson(Map<String, dynamic> json) {
    execTime = json['exec_time'];
    generated = json['generated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exec_time'] = execTime;
    data['generated'] = generated;
    return data;
  }
}

class DataWeather {
  String? id;
  Name? name;
  String? country;
  String? region;
  Identifier? identifier;
  Location? location;
  String? timezone;
  Inventory? inventory;

  DataWeather(
      {this.id,
      this.name,
      this.country,
      this.region,
      this.identifier,
      this.location,
      this.timezone,
      this.inventory});

  DataWeather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    country = json['country'];
    region = json['region'];
    identifier = json['identifier'] != null
        ? Identifier.fromJson(json['identifier'])
        : null;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    timezone = json['timezone'];
    inventory = json['inventory'] != null
        ? Inventory.fromJson(json['inventory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name?.toJson();
    data['country'] = country;
    data['region'] = region;
    data['identifier'] = identifier?.toJson();
    data['location'] = location?.toJson();
    data['timezone'] = timezone;
    data['inventory'] = inventory?.toJson();
    return data;
  }
}

class Name {
  String? de;
  String? es;
  String? en;

  Name({this.de, this.es, this.en});

  Name.fromJson(Map<String, dynamic> json) {
    de = json['de'];
    es = json['es'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['de'] = de;
    data['es'] = es;
    data['en'] = en;
    return data;
  }
}

class Identifier {
  String? national;
  String? wmo;
  String? icao;

  Identifier({this.national, this.wmo, this.icao});

  Identifier.fromJson(Map<String, dynamic> json) {
    national = json['national'];
    wmo = json['wmo'];
    icao = json['icao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['national'] = national;
    data['wmo'] = wmo;
    data['icao'] = icao;
    return data;
  }
}

class Location {
  double? latitude;
  double? longitude;
  int? elevation;

  Location({this.latitude, this.longitude, this.elevation});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    elevation = json['elevation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['elevation'] = elevation;
    return data;
  }
}

class Inventory {
  Model? model;
  Model? hourly;
  Model? daily;
  Monthly? monthly;
  Monthly? normals;

  Inventory({this.model, this.hourly, this.daily, this.monthly, this.normals});

  Inventory.fromJson(Map<String, dynamic> json) {
    model = json['model'] != null ? Model.fromJson(json['model']) : null;
    hourly = json['hourly'] != null ? Model.fromJson(json['hourly']) : null;
    daily = json['daily'] != null ? Model.fromJson(json['daily']) : null;
    monthly =
        json['monthly'] != null ? Monthly.fromJson(json['monthly']) : null;
    normals =
        json['normals'] != null ? Monthly.fromJson(json['normals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['model'] = model?.toJson();
    data['hourly'] = hourly?.toJson();
    data['daily'] = daily?.toJson();
    data['monthly'] = monthly?.toJson();
    data['normals'] = normals?.toJson();
    return data;
  }
}

class Model {
  String? start;
  String? end;

  Model({this.start, this.end});

  Model.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start'] = start;
    data['end'] = end;
    return data;
  }
}

class Monthly {
  int? start;
  int? end;

  Monthly({this.start, this.end});

  Monthly.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start'] = start;
    data['end'] = end;
    return data;
  }
}

class WeatherStation {
  String? id;
  String? name;
  double? latitude;
  double? longitude;
  double? elevation;
  String? country;
  String? region;
  String? national;
  String? wmo;
  String? icao;
  DateTime? timezone;
  bool? active;

  WeatherStation({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.elevation,
    this.country,
    this.region,
    this.national,
    this.wmo,
    this.icao,
    this.timezone,
    this.active,
  });

  WeatherStation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude']?.toDouble();
    longitude = json['longitude']?.toDouble();
    elevation = json['elevation']?.toDouble();
    country = json['country'];
    region = json['region'];
    national = json['national'];
    wmo = json['wmo'];
    icao = json['icao'];
    timezone =
        json['timezone'] != null ? DateTime.parse(json['timezone']) : null;
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['elevation'] = elevation;
    data['country'] = country;
    data['region'] = region;
    data['national'] = national;
    data['wmo'] = wmo;
    data['icao'] = icao;
    data['timezone'] = timezone?.toIso8601String();
    data['active'] = active;
    return data;
  }
}
