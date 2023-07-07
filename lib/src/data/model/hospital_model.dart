import 'dart:convert';
import '../../domain/entities/hospital.dart';


 class DataHospitalsModel extends DataHospitals {
  
  const DataHospitalsModel({
    required super.total, 
    required super.currentPage, 
    required super.totalPages, 
    required super.hospitals
  });

  factory DataHospitalsModel.fromJson(String str) => DataHospitalsModel.fromMap(json.decode(str));

  factory DataHospitalsModel.fromMap(Map<String, dynamic> json) => DataHospitalsModel(
   total: json["total"],
   currentPage: json["currentPage"],
   totalPages: json["totalPages"],
   hospitals: List<HospitalModel>.from(json["data"].map((x) => HospitalModel.fromMap(x))),
  );
  
 }

 class HospitalModel extends Hospital {
  
  const HospitalModel({
    required super.id, 
    required super.name, 
    required super.foto, 
    required super.logo, 
    required super.direccion, 
    required super.urlGoogleMaps, 
    required super.enabled, 
    required super.telefono, 
    required super.horario,
    required super.estadoCode, 
    required super.municipio, 
    required super.observaciones, 
    required super.location, 
    required super.aseguradora, 
    required super.v, 
    required super.createdAt, 
    required super.updatedAt, 
    required super.dist
  });

  factory HospitalModel.fromJson(String str) => HospitalModel.fromMap(json.decode(str));
   
  factory HospitalModel.fromMap(Map<String, dynamic> json) => HospitalModel(
    id: json["_id"],
    name: json["name"],
    foto: json["foto"] != "null" ? json["foto"] : null,
    logo: json["logo"],
    direccion: json["direccion"],
    urlGoogleMaps: json["urlGoogleMaps"],
    enabled: json["enabled"],
    telefono: json["telefono"],
    horario: json["horario"],
    estadoCode: json["estadoCode"],
    municipio: json["municipio"],
    observaciones: json["observaciones"],
    location: LocationModel.fromMap(json["location"]),
    aseguradora: List<int>.from(json["aseguradora"].map((x) => x)),
    v: json["__v"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    dist: DistModel.fromMap(json["dist"]),
  );
 }

 class DistModel extends Dist {
  
  
  const DistModel({
    required super.calculated, 
    required super.location
  });
    
  
  factory DistModel.fromJson(String str) => DistModel.fromMap(json.decode(str));
  
  factory DistModel.fromMap(Map<String, dynamic> json) => DistModel(
   calculated: json["calculated"]?.toDouble(),
   location: LocationModel.fromMap(json["location"]),
  );
  
}


class LocationModel extends Location {
  

  const LocationModel({
   required super.type, 
   required super.coordinates
  });
    
  factory LocationModel.fromJson(String str) => LocationModel.fromMap(json.decode(str));
  
  factory LocationModel.fromMap(Map<String, dynamic> json) => LocationModel(
      type: json["type"],
      coordinates: List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
  );

}