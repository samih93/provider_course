import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_learning/providers/home_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: Scaffold(
        body: ListView(
          children: [
            //! only build this selector on notifilistener
            Selector<HomeProvider, String>(
              selector: (context, prov_name) => prov_name.name,
              builder: (context, prov_name, child) {
                print('name ${prov_name}');
                return Text(prov_name);
              },
            ),
            SizedBox(
              height: 10,
            ),
            Selector<HomeProvider, String>(
              selector: (context, prov_lastname) => prov_lastname.lastname,
              builder: (context, prov_lastname, child) {
                print('lastname ${prov_lastname}');
                return Text(prov_lastname);
              },
            ),

            Selector<HomeProvider, int>(
              selector: (context, prov_age) => prov_age.age,
              builder: (context, prov_age, child) {
                print('lastname ${prov_age}');
                return Text(prov_age.toString());
              },
            ),

            SizedBox(
              height: 10,
            ),

            // ! if an update happen in home provider => rebuilb all method have cosumer
            Consumer<HomeProvider>(builder: (context, model, child) {
              return MaterialButton(
                onPressed: () {
                  print('change name button');

                  model.changeName();
                },
                color: Colors.blue,
                child: Text("change name"),
              );
            }),
            SizedBox(
              height: 10,
            ),
            Consumer<HomeProvider>(builder: (context, model, child) {
              return MaterialButton(
                onPressed: () {
                  print('change last name button');

                  model.changelastname();
                },
                color: Colors.blue,
                child: Text("change lastname"),
              );
            }),

            SizedBox(
              height: 10,
            ),
            // ! to use provider.of(context)
            // !we need to create separet widget to make provider inside this child of changenotifierProdvider
            WidgetButton(),
            SizedBox(
              height: 10,
            ),

            //!! this return an error cz out child of changenotifierProdvider
            // MaterialButton(
            //   onPressed: () {
            //     Provider.of<HomeProvider>(context, listen: false).changeAge();
            //   },
            //   child: Text("test provider"),
            // ),
          ],
        ),
      ),
    );
  }
}

class WidgetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<HomeProvider>(context);
    return MaterialButton(
      onPressed: () {
        print('change last name button');

        model.changeAge();
      },
      color: Colors.blue,
      child: Text("change age ${model.age}"),
    );
  }
}
