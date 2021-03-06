import 'package:flutter/material.dart';

class ProductCreate extends StatefulWidget {
  final Function addProduct;
  ProductCreate(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreate();
  }
}

class _ProductCreate extends State<ProductCreate> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': 0.00,
    'image': 'assets/food.jpg',
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Product Title',
      ),
      validator: (String value) {
        // if(value.trim().length <= 0){
        if (value.isEmpty || value.trim().length < 5) {
          return 'Title is required and shoudld be 5 characters long';
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Price'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price is required and shoudld be a number';
        }
      },
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Description'),
      maxLines: 4,
      validator: (String value) {
        if (value.isEmpty || value.trim().length < 10) {
          return 'Description is required and shoudld be 10 characters long';
        }
      },
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    widget.addProduct(_formData);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildTitleTextField(),
              _buildDescriptionTextField(),
              _buildPriceTextField(),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text('Save'),
                onPressed: _submitForm,
              ),
              // GestureDetector(
              //   onTap: _submitForm,
              //   child: Container(
              //     color: Colors.green,
              //     padding: EdgeInsets.all(5.0),
              //     child: Text('Save'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
