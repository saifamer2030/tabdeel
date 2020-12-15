

class TrackingClass{
int success;
String id;
String driver_id;
String order_id;
String driver_lat;
String driver_lon;
String update_at;

TrackingClass(this.id, this.success, this.driver_id, this.order_id, this.driver_lat, this.driver_lon,
    this.update_at);



  TrackingClass.fromJson( Map<String,dynamic> map ){
    if( map['id'] == null ){
      throw Exception(' ID is not set');
    }
  /**/  this.id = map['id'];


    /**/ this.success = map['success'];
    if( map['driver_id'] == null ){
      throw Exception('driver_id is not set');
    }
    /**/ this.driver_id = map['driver_id'];

    /**/ this.order_id = map['order_id'];
    if( map['driver_lat'] == null ){
      throw Exception('driver_lat is not set');
    }
    /**/ this.driver_lat = map['driver_lat'];

    if( map['driver_lon'] == null ){
      throw Exception('driver_lon is not set');
    }
    /**/ this.driver_lon = map['driver_lon'];

    this.update_at = map['update_at'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['success'] = this.success;
    data['driver_id'] = this.driver_id;
    data['order_id'] = this.order_id;
    data['driver_lat'] = this.driver_lat;
    data['driver_lon'] = this.driver_lon;
    data['update_at'] = this.update_at;

    return data;
  }

}
