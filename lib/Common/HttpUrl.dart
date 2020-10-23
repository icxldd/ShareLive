import 'dart:html';
import 'dart:js' as js;
import 'package:flutter/material.dart';

Map<String, String> getQueryParameters() {
  var uri = Uri.dataFromString(window.location.href);
  var qp = uri.queryParameters;
  return qp;
}
