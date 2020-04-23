import 'package:mobx/mobx.dart';
import 'package:mobx_observable_list/components/home_controller.dart';
part 'item_models.g.dart';


class ItemModel = _ItemModelBase with _$ItemModel;


abstract class _ItemModelBase with Store{

  _ItemModelBase({this.title, this.check = false});

  @observable
  String title;

  @observable
  bool check;

  @action
  setTitle(String value) => title = value;

  @action
  setCheck(bool value) => check = value;
}