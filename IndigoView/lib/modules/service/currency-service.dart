import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:indigo/modules/currency/models/currency-model.dart';
import 'package:indigo/modules/profile/profile-content.dart';
import 'package:intl/number_symbols_data.dart';

class CurrencyService{
  String apiUrl;
  Map<String, String> headers = {"Content-type": "application/json"};
 
 CurrencyService(){
   this.apiUrl = "http://localhost:3000/";
 }

  Future<bool> getList() async{
    final response = await http.get('${this.apiUrl}currencies', headers: headers);

    if (response.statusCode == 200){
     
      var resJson = json.decode(response.body);
      final noInsert = resJson['data'];
      
      return true;
    }
    else
      throw Exception('Failed to load data');
  }

  Future<bool> getActive() async{
    final response = await http.get('${this.apiUrl}currencies/getactives', headers: headers);

    if (response.statusCode == 200){
      var resJson = json.decode(response.body);
      final noInsert = resJson['data'];
      
      return true;
    }
    else
      throw Exception('Failed to load data');
  }

  Future<Currency> getById(int id) async{
    Currency currency = new Currency();

    final response = await http.get('${this.apiUrl}currencies/' + id.toString(), headers: headers);

    if (response.statusCode == 200){
      final prueba = json.decode(response.body);
      currency = currency.fromJson(prueba['data']);
    }
    else
      throw Exception('Failed to load data');
  } 

  Future<bool> create(Currency currency) async{
      final response = await http.post('${this.apiUrl}currencies', headers: headers, body: json.encode(currency));

      if (response.statusCode == 200)
        return true;
      else
        throw Exception('Failed to save data');
  }

  Future<bool> update(Currency currency) async{
    final response = await http.put('${this.apiUrl}currencies/7', headers: headers, body: json.encode(currency));

      if (response.statusCode == 200)
        return true;
      else
        throw Exception('Failed to save data');
  }

}