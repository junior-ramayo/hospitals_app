

 class CodeState {

  static String getCodeState({required String administrativeArea}){
   Map<String, String> data = {
    "Aguascalientes": "AS",
    "Baja California": "BC",
    "Baja California Sur": "BS",
    "Campeche": "CC",
    "Coahuila de Zaragoza": "CL",
    "Colima": "CM",
    "Chiapas": "CS",
    "Chihuahua": "CH",
    "Durango": "DG",
    "Guanajuato": "GT",
    "Guerrero": "GR",
    "Hidalgo": "HG",
    "Jalisco": "JC",
    "Mexico City": "MC",
    "Michoacán de Ocampo": "MN",
    "Morelos": "MS",
    "Nayarit": "NT",
    "Nuevo León": "NL",
    "Oaxaca": "OC",
    "Puebla": "PL",
    "Querétaro": "QT",
    "Quintana Roo": "QR",
    "San Luis Potosí": "SP",
    "Sinaloa": "SL",
    "Sonora": "SR",
    "Tabasco": "TC",
    "Tamaulipas": "TS",
    "Tlaxcala": "TL",
    "Veracruz de Ignacio de la Llave": "VZ",
    "Yucatán": "YN",
    "Zacatecas": "ZS"
   };
   return data[administrativeArea] ?? 'N/A';
  }

 }