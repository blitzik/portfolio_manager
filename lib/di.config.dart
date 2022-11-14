// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'drift/database.dart' as _i3;
import 'screens/homepage/home_page_bloc.dart' as _i4;
import 'screens/project/project_bloc.dart' as _i5;
import 'screens/project_detail/project_detail_bloc.dart' as _i6;
import 'screens/transaction/transaction_bloc.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.Database>(_i3.Database());
  gh.factory<_i4.HomePageBloc>(() => _i4.HomePageBloc(get<_i3.Database>()));
  gh.factory<_i5.ProjectBloc>(() => _i5.ProjectBloc(get<_i3.Database>()));
  gh.lazySingleton<_i6.ProjectDetailBlocFactory>(
      () => _i6.ProjectDetailBlocFactory(get<_i3.Database>()));
  gh.lazySingleton<_i7.TransactionBlocFactory>(
      () => _i7.TransactionBlocFactory(get<_i3.Database>()));
  return get;
}
