import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class ISMSBundleRepo {
  Future<DataState<String>> addSMSBundle(AddSMSBundleParms parms);
}
