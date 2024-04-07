import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omran/view/sicksupervisor/persons_medications/persons_medications.dart';

import '../../core/cubit/cubit.dart';
import '../../core/cubit/states.dart';
import '../../core/local/cache_helper.dart';
import '../../core/styles/colors.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/navigation.dart';
import '../../core/widgets/person_sick.dart';
import '../../core/widgets/snack_bar.dart';
import '../chose/chose.dart';
import 'add_new_sick/add_new_sick.dart';

class SickSupervisor extends StatelessWidget {
  const SickSupervisor({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase2()..callbackDispatcher('اهلا بعودتك ايها المشرف قم بمراجعة المرظى'),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is AppDeleteDatabaseState){
            showSnackBar(context, 'تمت عملية الحذف بنجاح بنجاح', Colors.green);
          }
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                CacheHelper.saveData(key: 'onChoose',value: "notLogIn" );
                                navigateAndFinish(context, const Choose());
                              },
                              child: Icon(Icons.logout,color: primaryColor,),
                            ),
                            Text(
                              'ذكرني',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 22),
                            ),
                            GestureDetector(
                                onTap: (){
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor:
                                        Theme.of(context).cardColor,
                                        content: SizedBox(
                                          height: 70,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              const SizedBox(height: 20,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0),
                                                    child: Text(
                                                      'هل انت متأكد من عملية الحذف (الكلي)',
                                                      textAlign: TextAlign.end,
                                                      style:
                                                      Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 15),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: CustomBottom(
                                                  onTap: () {
                                                    navigateBack(context);
                                                  },
                                                  text: 'الغاء',
                                                  colorText: Colors.white,
                                                  colorBottom: primaryColor,
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Expanded(
                                                child: CustomBottom(
                                                  onTap: () {
                                                    navigateBack(context);
                                                    cubit.deleteAllData2(context);
                                                  },
                                                  text: 'تأكيد',
                                                  colorText: Theme.of(context).scaffoldBackgroundColor,
                                                  colorBottom: Theme.of(context).dividerColor,
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Icon(Icons.cleaning_services,color: primaryColor,)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomBottom(
                                onTap: () {
                                  navigateTo(context, const AddNewSick());
                                },
                                borderRadius: BorderRadius.circular(14),
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                text: 'اضافة مريظ جديد',
                                colorBottom: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cubit.newTasks2.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: GestureDetector(
                              onTap: (){
                                navigateTo(context, PersonsMedications(
                                  name: cubit.newTasks2[index]['name'],
                                  nameSupervisor: cubit.newTasks2[index]['nameSupervisor'],
                                  image: cubit.newTasks2[index]['image'],
                                  phone: cubit.newTasks2[index]['phone'],
                                  phoneSupervisor: cubit.newTasks2[index]['phoneSupervisor'],
                                  location: cubit.newTasks2[index]['location'],
                                  age: cubit.newTasks2[index]['age'],
                                  documentId: cubit.newTasks2[index]['id'],
                                ),);
                              },
                              child: PersonSick(
                                cubit: cubit,
                                name: cubit.newTasks2[index]['name'],
                                nameSupervisor: cubit.newTasks2[index]['nameSupervisor'],
                                image: cubit.newTasks2[index]['image'],
                                phone: cubit.newTasks2[index]['phone'],
                                phoneSupervisor: cubit.newTasks2[index]['phoneSupervisor'],
                                location: cubit.newTasks2[index]['location'],
                                age: cubit.newTasks2[index]['age'],
                                documentId: cubit.newTasks2[index]['id'],
                                index: index+1,
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
