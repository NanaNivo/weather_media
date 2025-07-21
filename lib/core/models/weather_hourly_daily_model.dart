class WeatherDaily {
  Meta? meta;
  List<Data>? data;

  WeatherDaily({this.meta, this.data});

  WeatherDaily.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
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
  String? generated;
  String? coco;

  Meta({this.generated,this.coco});

  Meta.fromJson(Map<String, dynamic> json) {
    generated = json['generated'];
    coco=json['coco'];
    print('json${json['coco']}');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['generated'] = generated;
    return data;
  }
}

class Data {
  String? date;
  String ?time;
  double? tavg;
  double? tmin;
  double? tmax;
  double? prcp;
  double? snow;
  double? wdir;
  double? wspd;
  double? wpgt;
  double? pres;
  double? tsun;
  int? coco;
  Data(
      {this.date,
        this.time,
        this.tavg,
        this.tmin,
        this.tmax,
        this.prcp,
        this.snow,
        this.wdir,
        this.wspd,
        this.wpgt,
        this.pres,
        this.tsun,this.coco});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
   // time=json['time'];

    tavg = json['tavg'];

    tmin = json['tmin'];

    tmax = json['tmax'];

    prcp = json['prcp'];

    snow = json['snow'];

    wdir = json['wdir'];

    wspd = json['wspd'];

    wpgt = json['wpgt'];

    pres = json['pres'];

    tsun = json['tsun'];
    coco = json['coco'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(data['date']!=null) {
      data['date'] = date;
    }
    // if(data['time']!=null)
    //     {
    //     data['time']=this.time;
    //     }

    print("bbb");
    data['tavg'] = tavg;
    data['tmin'] = tmin;
    data['tmax'] = tmax;
    data['prcp'] = prcp;
    data['snow'] = snow;
    data['wdir'] = wdir;
    data['wspd'] = wspd;
    data['wpgt'] = wpgt;
    data['pres'] = pres;
    data['tsun'] = tsun;
    data['coco'] = coco;
    return data;
  }
}


class WeatherHourly {
  Meta? meta;
  List<DataHour>? data;

  WeatherHourly({this.meta, this.data});

  WeatherHourly.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data =[];
      json['data'].forEach((v) {
        data?.add(DataHour.fromJson(v));
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

class DataHour {
  String? time;
  double? temp;
  double? dwpt;
  double? rhum;
  double? prcp;
  double? snow;
  double? wdir;
  double? wspd;
  double? wpgt;
  double? pres;
  int? tsun;
  int? coco;
 // IconData icon;
   String? icon;

  DataHour(
      {this.time,
        this.temp,
        this.dwpt,
        this.rhum,
        this.prcp,
        this.snow,
        this.wdir,
        this.wspd,
        this.wpgt,
        this.pres,
        this.tsun,
        this.coco,this.icon});

  DataHour.fromJson(Map<String, dynamic> json) {
    time = json['time'];

    temp = json['temp'];

    dwpt = json['dwpt'];

    rhum = json['rhum'];

    prcp = json['prcp'];

    snow = json['snow'];

    wdir = json['wdir'];

    wspd = json['wspd'];

    wpgt = json['wpgt'];

    pres = json['pres'];

    tsun = json['tsun'];

    coco = json['coco'];
    icon=json['icon'];
    print("lll");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['temp'] = temp;
    data['dwpt'] = dwpt;
    data['rhum'] = rhum;
    data['prcp'] = prcp;
    data['snow'] = snow;
    data['wdir'] = wdir;
    data['wspd'] = wspd;
    data['wpgt'] = wpgt;
    data['pres'] = pres;
    data['tsun'] = tsun;
    data['coco'] = coco;
    return data;
  }
}
