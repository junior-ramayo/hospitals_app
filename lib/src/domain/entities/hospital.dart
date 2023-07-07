

class DataHospitals {
    
  final int total;
  final int currentPage;
  final int totalPages;
  final List<Hospital> hospitals;

  const DataHospitals({
   required this.total,
   required this.currentPage,
   required this.totalPages,
   required this.hospitals,
  });

}

class Hospital {

  final String id;
  final String name;
  final String? foto;
  final String? logo;
  final String direccion;
  final String urlGoogleMaps;
  final bool enabled;
  final String telefono;
  final String horario;
  final String estadoCode;
  final String municipio;
  final String observaciones;
  final Location location;
  final List<int> aseguradora;
  final int v;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Dist dist;

  const Hospital({
   required this.id,
   required this.name,
   required this.foto,
   this.logo,
   required this.direccion,
   required this.urlGoogleMaps,
   required this.enabled,
   required this.telefono,
   required this.horario,
   required this.estadoCode,
   required this.municipio,
   required this.observaciones,
   required this.location,
   required this.aseguradora,
   required this.v,
   required this.createdAt,
   required this.updatedAt,
   required this.dist,
  });

}

class Dist {

  final double calculated;
  final Location location;
  
  const Dist({
   required this.calculated,
   required this.location,
  });


}

class Location {
    
  final String type;
  final List<double> coordinates;
  
  const Location({
   required this.type,
   required this.coordinates,
  });
  
}
