import 'package:http/http.dart' as http;
import 'base_url.dart';

Future<http.Response> getAllOffers() async {
  var baseURL =
      baseURL_APP+'Shops/GetAllOffers.php';
  var client = http.Client();
  try {
    return await client.get(
      baseURL,headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },
    );
  } finally {
    client.close();
  }
}

Future<http.Response> getOfferDetails(String offerID) async {
  var baseURL =
      baseURL_APP+'Shops/GetOffer.php?OfferID='+offerID;
  var client = http.Client();
  try {
    return await client.get(baseURL, headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },);
  } finally {
    client.close();
  }
}
