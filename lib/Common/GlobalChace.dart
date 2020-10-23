import 'package:localstorage/localstorage.dart';
import 'package:flutter/material.dart';

final LocalStorage storage = new LocalStorage('todo_web');

void setCookie(key, val) {
  storage.setItem(key, val);
}

String getCookie(key) {
  return storage.getItem(key);
}

String guildId;

String pastorId;

String liveId = '';
