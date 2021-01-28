// To parse this JSON data, do
//
//     final providers = providersFromJson(jsonString);

// import 'dart:convert';
//import 'package:http/http.dart' as http;

// Providers providersFromJson(String str) => Providers.fromJson(json.decode(str));

// String providersToJson(Providers data) => json.encode(data.toJson());

class Providers {
  Providers({
    this.id,
    this.name,
    this.description,
    this.rating,
    this.address,
    this.images,
    this.activeStatus,
    this.providerType,
    this.state,
  });

  int id;
  String name;
  String description;
  int rating;
  String address;
  List<Image> images;
  String activeStatus;
  ProviderType providerType;
  ProviderType state;

  factory Providers.fromJson(Map<String, dynamic> json) {
    return Providers(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      rating: json["rating"] ?? 0,
      address: json["address"] ?? "",
      images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      activeStatus: json["active_status"] ?? "",
      providerType: json["provider_type"] == null ? null : ProviderType.fromJson(json["provider_type"]),
      state: json["state"] == null ? null : ProviderType.fromJson(json["state"]),
    );
  }

  Map<String, dynamic> toJson() => {
        // "id": id,
        "name": name,
        "description": description,
        // "rating": rating,
        "address": address,
        // "images": List<dynamic>.from(images.map((x) => x.toJson())),
        // "active_status": activeStatus,
        // "provider_type": providerType.toJson(),
        // "state": state.toJson(),
      };
}

class Image {
  Image({
    this.id,
    this.name,
    this.alternativeText,
    this.caption,
    this.width,
    this.height,
    this.formats,
    this.hash,
    this.ext,
    this.mime,
    this.size,
    this.url,
    this.previewUrl,
    this.provider,
    this.providerMetadata,
    this.related,
  });

  int id;
  String name;
  String alternativeText;
  String caption;
  int width;
  int height;
  Formats formats;
  String hash;
  String ext;
  String mime;
  double size;
  String url;
  String previewUrl;
  String provider;
  Formats providerMetadata;
  String related;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        alternativeText: json["alternativeText"] ?? "",
        caption: json["caption"] ?? "",
        width: json["width"] ?? 0,
        height: json["height"] ?? 0,
        formats: Formats.fromJson(json["formats"]),
        hash: json["hash"] ?? "",
        ext: json["ext"] ?? "",
        mime: json["mime"] ?? "",
        size: json["size"] ?? 0.0,
        url: json["url"] ?? "",
        previewUrl: json["previewUrl"] ?? "",
        provider: json["provider"] ?? "",
        providerMetadata: Formats.fromJson(json["provider_metadata"]),
        related: json["related"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "width": width,
        "height": height,
        "formats": formats.toJson(),
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider,
        "provider_metadata": providerMetadata.toJson(),
        "related": related,
      };
}

class Formats {
  Formats();

  factory Formats.fromJson(Map<String, dynamic> json) => Formats();

  Map<String, dynamic> toJson() => {};
}

class ProviderType {
  ProviderType({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory ProviderType.fromJson(Map<String, dynamic> json) => ProviderType(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
