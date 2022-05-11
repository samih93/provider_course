import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_learning/providers/home_provider.dart';
import 'package:provider_learning/providers/student_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return HomeProvider();
        }),
        ChangeNotifierProvider(create: (context) {
          return StudentProvider();
        })
      ],
      child: Scaffold(
        body: Column(
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

            // !! this return an error cz out child of changenotifierProdvider
            // MaterialButton(
            //   onPressed: () {
            //     Provider.of<HomeProvider>(context, listen: false).changeAge();
            //   },
            //   child: Text("test provider"),
            // ),

            Consumer<StudentProvider>(builder: (context, model, child) {
              return MaterialButton(
                onPressed: () {
                  model.addStudent("ali");
                  //model.addStudent("samih");
                  //  model.addStudent("ahmad");
                },
                color: Colors.blue,
                child: Text("Add Student"),
              );
            }),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child:
                  Consumer<StudentProvider>(builder: (context, model, child) {
                return model.listOfStudent.length == 0
                    ? Center(child: Text("List Is Empty"))
                    : ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Text(
                            model.listOfStudent[index],
                            style: TextStyle(fontSize: 20),
                          );
                        },
                        itemCount: model.listOfStudent.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class WidgetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ! if listen =false => can't read data from provider  directly from model like context.read<HomeProvider>().age
    // ! if listen = true => i can access varaible direclty from model like model.age
    //! but i feature Context.watch ==> can access data throw it

    //NOTE Example
    //! context.read<HomeProvider>() === Provider.of<HomeProvider>(context, listen: false)
    //! context.watch<HomeProvider>() === Provider.of<HomeProvider>(context, listen: true)

    var model = Provider.of<HomeProvider>(context, listen: false);
    return MaterialButton(
      onPressed: () {
        print('change age button');
        // context.read<HomeProvider>().changeAge();   same model.changeAge()
        model.changeAge();
      },
      color: Colors.blue,
      child: Text("change age ${context.watch<HomeProvider>().age}"),
    );
  }
}
