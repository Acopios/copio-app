import 'dart:convert';
import 'dart:developer';

import 'package:acopios/src/ui/pages/auth/login_model.dart';
import 'package:dio/dio.dart';

class ServiceLogin {
  Future<Loginmodel> login({required String user, required String pass}) async {
    try {
      final r = await Dio().post("http://localhost:8080/acopios/v1/dev/autenticacion/login", data: {"usuario": user, "contrasenia": pass});
    log("$r");
    
      return Loginmodel.fromJson(r.data );
    } catch (e) {
      log("$e");
           return Loginmodel(body: Body(token: "", ), message: "", success: false); 
    }
  }
}
