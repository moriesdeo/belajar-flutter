import 'package:belajar_flutter/data/data_sources.dart';
import 'package:belajar_flutter/domain/entities.dart';

abstract class MainRepository {
  final AllStoryDataNetworkSource allStoryDataNetworkSource;
  MainRepository(this.allStoryDataNetworkSource);
  Future<GetAllStories> execute(int page, int size) async {
    return await allStoryDataNetworkSource.fetchGetAllStory(page, size);
  }
}
