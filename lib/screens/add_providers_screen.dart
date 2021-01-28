import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prozone/model/providers_model.dart' as model;
import 'package:prozone/networking/service.dart' as networkService;

class AddProvidersScreen extends StatefulWidget {
  @override
  _AddProvidersScreenState createState() => _AddProvidersScreenState();
}

class _AddProvidersScreenState extends State<AddProvidersScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  // final TextEditingController activeStatusController = TextEditingController();
  // final TextEditingController providerTypeController = TextEditingController();
  // final TextEditingController stateController = TextEditingController();
  model.Providers provider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ImagePicker _imagePicker = ImagePicker();

  bool _loading = false;

  File _selectedImage;

  int _step = 1;

  String _providerId;

  @override
  void initState() {
    provider = model.Providers();
    provider.activeStatus = statusController.text = "Pending";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Add Provider'),
        ),
        body: _step == 1
            ? _buildProviderForm(context)
            : _buildProviderPreviewImage(),
      ),
    );
  }

  Widget _buildProviderForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 15),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Enter provider name.',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    borderSide: BorderSide(
                        color: Colors.blue, style: BorderStyle.solid),
                  ),
                ),
                onSaved: _setProviderName,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                    labelText: 'Enter description.',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                        borderSide: BorderSide(
                            color: Colors.blue, style: BorderStyle.solid))),
                onSaved: _setProviderDescription,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Enter address.',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    borderSide: BorderSide(
                        color: Colors.blue, style: BorderStyle.solid),
                  ),
                ),
                onSaved: _setProviderAddress,
                keyboardType: TextInputType.streetAddress,
              ),
              SizedBox(height: 15),
              TextFormField(
                enabled: false,
                controller: statusController,
                decoration: InputDecoration(
                  labelText: 'Active Status',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    borderSide: BorderSide(
                        color: Colors.blue, style: BorderStyle.solid),
                  ),
                ),
                onSaved: _setProviderAddress,
                keyboardType: TextInputType.streetAddress,
              ),
              SizedBox(height: 15),
              Center(
                child: _loading == false
                    ? MaterialButton(
                        color: Theme.of(context).accentColor,
                        child: Text(
                          "Submit Provider Details",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          _formKey.currentState.save();
                          _saveProvider();
                        },
                      )
                    : Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProviderPreviewImage() {
    return Column(
      children: [
        _selectedImage == null
            ? FloatingActionButton(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () => _selectImage())
            : Container(
                width: 120.0,
                height: 120.0,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.file(
                      _selectedImage,
                      fit: BoxFit.cover,
                    ))),
        Center(
            child: _loading == false
                ? MaterialButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      "Submit Provider Image",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _uploadImage)
                : Center(child: CircularProgressIndicator())),
      ],
    );
  }

  _setProviderName(String providerName) {
    provider.name = providerName;
  }

  _setProviderDescription(String providerDescription) {
    provider.description = providerDescription;
  }

  _setProviderAddress(String providerAddress) {
    provider.address = providerAddress;
  }

  void _saveProvider() async {
    setState(() => _loading = true);

    Map<String, dynamic> response =
        await networkService.setProvidersData(provider.toJson());
    if (response["success"] = true) {
      _providerId = response["data"]["id"].toString();
      showSnackBar(context, "Provider Details Saved");
    } else {
      showSnackBar(context, response["data"]);
    }
    setState(() {
      _loading = false;
      _step = 2;
    });
  }

  showSnackBar(BuildContext context, String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  Future _selectImage() async {
    PickedFile pickedFile =
        await _imagePicker.getImage(source: ImageSource.gallery);
    File file = File(pickedFile.path);
    setState(() => _selectedImage = file);
  }

  void _uploadImage() async {
    if (_selectedImage == null) {
      showSnackBar(context, "Please select an image");
      return;
    }
    setState(() => _loading = true);

    Map<String, dynamic> response =
        await networkService.uploadImage(_selectedImage.path, _providerId);
    if (response["success"] == true) {
      showSnackBar(context, "Provider Image Saved");
    } else {
      showSnackBar(context, response["data"]);
    }
    setState(() => _loading = false);
  }
}