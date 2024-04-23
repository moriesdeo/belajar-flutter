import 'package:belajar_flutter/data/repositories.dart';
import 'package:belajar_flutter/domain/entities.dart';

class FetchGetAllStoryUseCase {
  late final MainRepository mainRepository;

  FetchGetAllStoryUseCase(this.mainRepository);

  Future<GetAllStories> call(int page, int size, int location) async {
    return await mainRepository.execute(page, size);
  }
}
