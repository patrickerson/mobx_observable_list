import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_observable_list/components/home_controller.dart';
import 'package:mobx_observable_list/models/item_models.dart';
import 'item_widget.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    final controller = HomeController();
    _dialog(){
      var model = ItemModel();
      showDialog(
          context: context,
          builder: (_){
            return AlertDialog(
              title: TextField(
                onChanged: model.setTitle,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Novo item'
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: (){
                    controller.addItem(model);
                    Navigator.pop(context);
                    },
                  child: Text('Salvar'),
                ),
                FlatButton(
                  onPressed: (){},
                  child: Text('Cancelar'),
                )
              ],

            );
          }
      );
    }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  AppBar(
        title: TextField(
          onChanged: controller.setFilter,
          decoration: InputDecoration(hintText: 'Pesquisar...'),
        ),
        actions: <Widget>[IconButton(
          onPressed: (){},
          icon: Observer(
            builder: (_){
              return Text(
                  "${controller.totalChecked}");
              },
          ),
        )
        ],
      ),
      body: Observer(
        builder: (_){
          if(controller.output.data == null){
            return Center(child: CircularProgressIndicator(),);

          }
          return ListView.builder(
              itemCount: controller.output.data.length,
              itemBuilder: (_,index) {
                var item = controller.output.data[index];
                return ItemWidget(item: item, removeClicked: (){
                  controller.removeItem(item);
                },);
              });
        },
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: _dialog,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),


    );
  }
}
