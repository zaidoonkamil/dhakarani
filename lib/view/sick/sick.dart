import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/cubit.dart';
import '../../core/cubit/states.dart';
import '../../core/local/cache_helper.dart';
import '../../core/styles/colors.dart';
import '../../core/widgets/card_home_active.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_form_field.dart';
import '../../core/widgets/navigation.dart';
import '../../core/widgets/snack_bar.dart';
import '../chose/chose.dart';
import 'add_treatment/add_treatment.dart';

class Sick extends StatelessWidget {
  const Sick({super.key});

  static TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase()..callbackDispatcher('اهلا بعودتك ايها المريظ قم بمراجعة الادوية'),
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
                                                  colorBottom: Colors.black,
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
                                  navigateTo(context, const AddTreatment());
                                },
                                borderRadius: BorderRadius.circular(14),
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                text: 'اضافة دواء جديد',
                                colorBottom: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(width: 10,),
                        Row(
                          children: [
                            Expanded(
                              child: CustomBottom(
                                height: 50,
                                onTap: () {
                                    if(searchController.text.isNotEmpty){
                                      cubit.newTasks= cubit.searchByName(searchController.text);
                                      cubit.emitt();
                                    }else{
                                      cubit.createDatabase();
                                    }
                                    },
                                borderRadius: BorderRadius.circular(14),
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                text: 'بحث',
                                colorBottom: Theme.of(context).primaryColor,
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              flex: 3,
                              child: CustomFormField(
                                width: double.maxFinite,
                                textStyleHint: Theme.of(context).textTheme.displaySmall,
                                textInputType: TextInputType.text,
                                controller: searchController,
                                hintText: 'بحث',
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
                        itemCount: cubit.newTasks.length,
                        itemBuilder: (context, index) {
                          int out=
                              int.parse('${cubit.newTasks[index]['numberDoses']}') ~/
                              int.parse('${cubit.newTasks[index]['dosageAmount']}');
                          String outStock= out.toString();
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: CardHomeActive(
                              cubit: cubit,
                              outStock: outStock,
                              name: cubit.newTasks[index]['name'],
                              type: cubit.newTasks[index]['type'],
                              image: cubit.newTasks[index]['image'],
                              dosageAmount: cubit.newTasks[index]['dosageAmount'],
                              doseTime: cubit.newTasks[index]['doseTime'],
                              numberDoses: cubit.newTasks[index]['numberDoses'],
                              documentId: cubit.newTasks[index]['id'],
                              index: index+1,
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
