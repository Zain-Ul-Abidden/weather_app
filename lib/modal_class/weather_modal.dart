class WeatherModal {
  final Weather weather;
  final Main main;
  final Wind wind;
  final String name;

  WeatherModal(
      {required this.weather,
      required this.main,
      required this.wind,
      required this.name});
  factory WeatherModal.fromjson(Map<String, dynamic> json) {
    return WeatherModal(
        weather: Weather.fromjson(json['weather'][0]),
        main: Main.fromjson(json['main']),
        wind: Wind.fromjson(json['wind']),
        name: json['name']);
  }
  Map<String, dynamic> toMap() {
    return {
      'weather': weather.toMap(),
      'main': main.toMap(),
      'wind': wind.toJson(),
      'name': name
    };
  }
}

class Weather {
  final int id;
  final String main;
  final String description;

  Weather({required this.id, required this.main, required this.description});
  factory Weather.fromjson(Map<String, dynamic> json) {
    return Weather(
        id: json['id'], main: json['main'], description: json['description']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'main': main, 'description': description};
  }
}

class Main {
  final double temp;
  final int humidity;

  Main({required this.temp, required this.humidity});
  factory Main.fromjson(Map<String, dynamic> json) {
    return Main(temp: json['temp'], humidity: json['humidity']);
  }
  Map<String, dynamic> toMap() {
    return {'temp': temp, 'humidity': humidity};
  }
}

class Wind {
  final double speed;

  Wind({required this.speed});
  factory Wind.fromjson(Map<String, dynamic> json) {
    return Wind(speed: json['speed']);
  }
  Map<String, dynamic> toJson() {
    return {'speed': speed};
  }
}
