import 'package:floor/floor.dart';
import 'package:moviki/features/movie/data/data_sources/local/DAO/movie_dao.dart';
import 'package:moviki/features/movie/data/models/movie_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'app_database.g.dart';

@Database(version: 1, entities: [MovieModel])
abstract class AppDatabase extends FloorDatabase {
  MovieDao get movieDAO;
}
