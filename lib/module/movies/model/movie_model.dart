class Movie {
  bool adult;
  String backdropPath;
  dynamic belongsToCollection;
  int budget;
  List<Genre> genres;
  String homepage;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompany> productionCompanies;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'] ?? "",
      belongsToCollection: json['belongs_to_collection'],
      budget: json['budget'] ?? 0,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((genre) => Genre.fromJson(genre))
          .toList() ?? [],
      homepage: json['homepage'] ?? "",
      overview: json['overview'] ?? "",
      popularity: json['popularity'] ?? 0.0,
      posterPath: json['poster_path'] ?? "",
      productionCompanies: (json['production_companies'] as List<dynamic>?)
          ?.map((company) => ProductionCompany.fromJson(company))
          .toList() ?? [],
    );
  }
}

class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
    );
  }
}

class ProductionCompany {
  int id;
  String logoPath;
  String name;
  String originCountry;

  ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'] ?? 0,
      logoPath: json['logo_path'] ?? "",
      name: json['name'] ?? "",
      originCountry: json['origin_country'] ?? "",
    );
  }
}