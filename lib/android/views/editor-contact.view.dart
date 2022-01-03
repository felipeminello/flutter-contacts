import 'package:contacts/android/views/home.view.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:contacts/repositories/contact.repository.dart';
import 'package:flutter/material.dart';

class EditorContactView extends StatefulWidget {
  final ContactModel model;

  EditorContactView({required this.model});

  @override
  _EditorContactViewState createState() => _EditorContactViewState();
}

class _EditorContactViewState extends State<EditorContactView> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();
  final _repository = ContactRepository();

  onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // user caso o evento para alterar o modelo seja onSaved:
    //_formKey.currentState.save();
    if (widget.model.id == 0) {
      create();
    } else {
      update();
    }
  }

  create() {
    widget.model.id = null;
    widget.model.image = null;

    _repository
        .create(widget.model)
        .then(
          (value) => onSuccess(),
        )
        .catchError((_) => {onError()});
  }

  update() {
    _repository.update(widget.model).then((_) {
      onSuccess();
    }).catchError((_) {
      onError();
    });
  }

  onSuccess() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeView(),
      ),
    );
  }

  onError() {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text('Ops, algo deu errado!'),
    //   ),
    // );

    final snackBar = SnackBar(
      content: Text('Ops, algo deu errado!'),
    );
    
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: widget.model.id == 0
            ? Text("Novo Contato")
            : Text("Editar Contatos"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                initialValue: widget.model.name,
                onChanged: (val) {
                  widget.model.name = val;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nome inválido';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Telefone',
                ),
                keyboardType: TextInputType.number,
                initialValue: widget.model.phone,
                onChanged: (val) {
                  widget.model.phone = val;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Telefone inválido';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                initialValue: widget.model.email,
                onChanged: (val) {
                  widget.model.email = val;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email inválido';
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: TextButton.icon(
                  icon: Icon(Icons.save),
                  label: Text("Salvar"),
                  onPressed: onSubmit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
