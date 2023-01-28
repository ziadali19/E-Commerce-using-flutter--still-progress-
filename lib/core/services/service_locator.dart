import 'package:e_commerce/features/categories/controller/cubit/categories_cubit.dart';
import 'package:e_commerce/features/categories/controller/cubit/category_details_cubit.dart';
import 'package:e_commerce/features/categories/controller/cubit/sub_categories_details_cubit.dart';
import 'package:e_commerce/features/categories/data/remote_data_source/category_remote_data_source.dart';
import 'package:e_commerce/features/categories/data/repository/category_repository.dart';
import 'package:e_commerce/features/home/data/remote_data_source/home_remote_data_source.dart';
import 'package:e_commerce/features/product/controller/cubit/products_cubit.dart';
import 'package:e_commerce/features/product/data/repository/product_repository.dart';
import 'package:e_commerce/features/register/data/remote_data_source/register_remote_data_source.dart';
import 'package:e_commerce/features/register/data/repository/register_remote_data_repository.dart';
import 'package:get_it/get_it.dart';

import '../../features/cart/controller/cubit/cart_cubit.dart';
import '../../features/cart/data/remote_data_source/cart_remote_data_source.dart';
import '../../features/cart/data/repository/cart_repository.dart';
import '../../features/categories/controller/cubit/brand_details_cubit.dart';
import '../../features/favorite/controller/cubit/favorite_cubit.dart';
import '../../features/favorite/data/remote_data_source/favorite_remote_data_source.dart';
import '../../features/favorite/data/repository/favorite_repository.dart';
import '../../features/filter/controller/cubit/filter_cubit.dart';
import '../../features/filter/data/remote_data_source/filter_remote_data_source.dart';
import '../../features/filter/data/repository/filter_repository.dart';
import '../../features/forget password/controller/cubit/forget_cubit.dart';
import '../../features/forget password/data/remote_data_source/forget_remote_data_source.dart';
import '../../features/forget password/data/repository/forget_repository.dart';
import '../../features/home/controller/cubit/home_cubit.dart';
import '../../features/home/data/repository/home_repository.dart';
import '../../features/login/controller/cubit/login_cubit.dart';
import '../../features/login/data/remote_data_source.dart/login_remote_data_source.dart';
import '../../features/login/data/repository/login_repository.dart';
import '../../features/payments/controller/cubit/payments_cubit.dart';
import '../../features/payments/data/remote_data_source/payments_remote_data_source.dart';
import '../../features/payments/data/repository/payments_repository.dart';
import '../../features/product/data/remote_data_source/product_remote_data_source.dart';
import '../../features/register/controller/cubit/register_cubit.dart';
import '../../features/search/controller/cubit/search_cubit.dart';
import '../../features/search/data/remote_data_source.dart/search_remote_data_source.dart';
import '../../features/search/data/repository/search_repository.dart';
import '../../features/settings/controller/cubit/address_cubit.dart';
import '../../features/settings/controller/cubit/my_account_cubit.dart';
import '../../features/settings/controller/cubit/orders_cubit.dart';
import '../../features/settings/data/remote_data_source/settings_remote_data_source.dart';
import '../../features/settings/data/repository/settings_repository.dart';

final sl = GetIt.instance;

class ServicesLocator {
  static void init() {
    sl.registerFactory(() => RegisterCubit(sl()));

    sl.registerLazySingleton<BaseRegisterRepository>(
        () => RegisterRepository(sl()));
    sl.registerLazySingleton<BaseRegisterRemoteDataSource>(
        () => RegisterRemoteDataSource());
    sl.registerFactory(() => LoginCubit(sl()));
    sl.registerLazySingleton<BaseLoginRepository>(() => LoginRepository(sl()));
    sl.registerLazySingleton<BaseLoginRemoteDataSource>(
        () => LoginRemoteDataSource());
    sl.registerFactory(() => HomeCubit(sl(), sl()));
    sl.registerLazySingleton<HomeBaseRepository>(() => HomeRepository(sl()));
    sl.registerLazySingleton<HomeBaseRemoteDataSource>(
        () => HomeRemoteDataSource());

    sl.registerFactory(() => CategoriesCubit(sl()));
    sl.registerLazySingleton<BaseCategoriesRepository>(
        () => CategoriesRepository(sl()));
    sl.registerLazySingleton<BaseCategoryRemoteDataSource>(
        () => CategoryRemoteDataSource());

    sl.registerFactory(() => CategoryDetailsCubit(sl(), sl()));

    sl.registerFactory(() => ProductsCubit(sl()));
    sl.registerLazySingleton<BaseProductRemoteDataSource>(
        () => ProductRemoteDataSource());
    sl.registerLazySingleton<BaseProductRepository>(
        () => ProductRepository(sl()));

    sl.registerFactory(() => CartCubit(sl(), sl()));
    sl.registerLazySingleton<BaseCartRemoteDataSource>(
        () => CartRemoteDataSource());
    sl.registerLazySingleton<BaseCartRepository>(() => CartRepository(sl()));

    sl.registerFactory(() => FavoriteCubit(sl()));
    sl.registerLazySingleton<BaseFavoriteRemoteDataSource>(
        () => FavoriteRemoteDataSource());
    sl.registerLazySingleton<BaseFavoriteRepository>(
        () => FavoriteRepository(sl()));

    sl.registerFactory(() => SearchCubit(sl(), sl()));
    sl.registerLazySingleton<BaseSearchRemoteDataSource>(
        () => SearchRemoteDataSource());
    sl.registerLazySingleton<BaseSearchRepository>(
        () => SearchRepository(sl()));

    sl.registerFactory(() => ForgetCubit(sl()));
    sl.registerLazySingleton<BaseForgetRemoteDataSource>(
        () => ForgetRemoteDataSource());
    sl.registerLazySingleton<BaseForgetRepository>(
        () => ForgetRepository(sl()));

    sl.registerFactory(() => FilterCubit(sl(), sl()));
    sl.registerLazySingleton<BaseFilterRemoteDataSource>(
        () => FilterRemoteDataSource());
    sl.registerLazySingleton<BaseFilterRepository>(
        () => FilterRepository(sl()));

    sl.registerFactory(() => SubCategoriesDetailsCubit(sl(), sl()));
    sl.registerFactory(() => BrandDetailsCubit(sl(), sl()));

    sl.registerFactory(() => AddressCubit(sl()));
    sl.registerLazySingleton<BaseSettingsRemoteDataSource>(
        () => SettingsRemoteDataSource());
    sl.registerLazySingleton<BaseSettingsRepository>(
        () => SettingsRepository(sl()));

    sl.registerFactory(() => MyAccountCubit(sl()));

    sl.registerFactory(() => PaymentsCubit(sl()));
    sl.registerLazySingleton<BasePaymentsRemoteDataSource>(
        () => PaymentsRemoteDataSource());
    sl.registerLazySingleton<BasePaymentsRepository>(
        () => PaymentsRepository(sl()));

    sl.registerFactory(() => OrdersCubit(sl()));
  }
}
