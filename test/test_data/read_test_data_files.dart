import 'dart:io';

String readTestData(String name) => File('test/test_data/$name').readAsStringSync();
