import 'package:weather/core/error/base_error.dart';
import 'package:weather/core/param/no_param.dart';
import 'package:weather/core/result/result.dart';
import 'package:weather/core/usecases/base_use_case.dart';
import 'package:weather/presentation/hom_flow/repository/repository_home.dart';
import 'package:geolocator/geolocator.dart';
class LocationUseCase extends UseCase<Future<Result<BaseError,Position > >,NoParams>
{
  final RepositoryHome homeRepository;
  LocationUseCase({required this.homeRepository});
  @override
  Future<Result<BaseError,Position > > call(NoParams params) async {

    final result=await homeRepository.getMyLocation( );
    if (result.hasDataOnly) {
      print("hrrrrr");

      return Result(data: result.data);
    }
    return Result(error: result.error);
  }
}