import 'package:conduit/conduit.dart';
import 'package:coschon/models/ad_title.dart';
import 'package:coschon/models/transaction_status.dart';

class AdTitleTransaction extends ManagedObject<_AdTitleTransaction> implements _AdTitleTransaction {}
class _AdTitleTransaction {
  @primaryKey
  int? id;

  TransactionStatus? status;

  String? identitatis;

  AdTitle? adTitle;
}