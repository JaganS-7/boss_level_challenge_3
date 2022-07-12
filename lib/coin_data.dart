//TODO: Add your imports here.
import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '9EFC6477-0F76-4E00-AA66-DB01829707B7';

//const bitcoinAverageURL = 'https://apiv2.bitcoinaverage.com/indices/global/ticker'; //not working.404

class CoinData {
  //Create the Asynchronous method getCoinData() that returns a Future (the price data).
  Future getCoinData(String? selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL = '$coinAPIURL/BTC/$selectedCurrency?apiKey=$apiKey';
      //GET request to the URL and wait for the response.
      http.Response response = await http.get(Uri.parse(requestURL));
      // Check that the request was successful.
      if (response.statusCode == 200) {
        //Use the 'dart:convert' package to decode the JSON data that comes back from coinapi.io.
        var decodedData = jsonDecode(response.body);
        //Get the last price of bitcoin with the key 'last'.
        var lastPrice = decodedData['rate'];
        // Output the lastPrice from the method.
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        // Handle any errors that occur during the request.
        print(response.statusCode);
        //Optional: throw an error if our request fails.
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
