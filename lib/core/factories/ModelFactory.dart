class ModelFactory {
  final Map<String, dynamic Function(dynamic)> _modelMap = {};

  static final ModelFactory _instance = ModelFactory._internal();

  factory ModelFactory() {
    return _instance;
  }

  ModelFactory._internal();

  static ModelFactory getInstance() {
    return _instance;
  }

  void registerModel(
    String modelName,
    dynamic Function(dynamic) modelMapper,
  ) {
    _modelMap.putIfAbsent(modelName, () => modelMapper);
  }

  T createModel<T>(json) {
    final modelName = T.toString();
    if (!_modelMap.containsKey(modelName)) {
      throw Exception('Model $modelName not registered in ModelFactory');
    }
    return _modelMap[modelName]!(json) as T;
  }

  // List<T> createModelList<T>(json) {

  //   return (json as List)
  //       .map((item) => item == null ? null : createModel(item))
  //       .toList();
  // }
}
