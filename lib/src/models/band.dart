class Band {
  late String id;
  late String name;

  late int votes;

  Band({required String idP, required String nameP, required int votesP}) {
    //orden de ejecucion: 2
    this.id = idP;
    this.name = nameP;

    this.votes = votesP;
  }

  factory Band.fromMap(Map<String, dynamic> object) {
    //orden de ejecucion:  1
    /*  
      Se llama a Band.fromMap, este recibe un object pero de tipo de mapa, ejemplo Json.
      luego con el return Band (ip: object ["id"].........) llama al constructor pero con variables temporales con valor asignado

       //orden de ejecucion: 2
      //en el constructor se le asignan a las  variables de atributo ejemplo this.id el valor de las variables temporables con su valor respectivo
    
      //returna una instancia de Band
    */
    return Band(
      idP: object["id"],
      nameP: object["name"],
      votesP: object["votes"] ?? 0,
    );
  }
}
