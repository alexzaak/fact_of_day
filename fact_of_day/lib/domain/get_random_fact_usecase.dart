import '../data/fact_repository.dart';
import 'get_language_code_usecase.dart';
import 'model/fact.dart';

class GetRandomFactUseCase {
  final GetLanguageCodeUseCase _getLanguageCodeUseCase;
  final FactRepository _factRepository;

  GetRandomFactUseCase(this._getLanguageCodeUseCase, this._factRepository);

  Future<Fact> getRandom() async {
    String languageCode = await _getLanguageCodeUseCase.getLanguageCode();

    return _factRepository.getRandomFact(languageCode);
  }
}
