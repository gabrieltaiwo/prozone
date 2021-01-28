import 'package:flutter/material.dart'; // set
import 'package:prozone/model/providers_model.dart' as model;

class ProvAlertDialog extends StatelessWidget {
  final model.Providers providers;
  ProvAlertDialog(this.providers);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(providers.name),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          providers?.images == null || providers.images.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Image.network(providers?.images?.first?.url),
          Text("name : ${providers.name}"),
          Text("description : ${providers.description}"),
          Text("address : ${providers.address}"),
          Text("status : ${providers.activeStatus}"),
          Text("rating : ${providers.rating.toString()}"),
          //Text("provider type : ${providers.state.runtimeType}"),
        ],
      ),
    );
  }
}
