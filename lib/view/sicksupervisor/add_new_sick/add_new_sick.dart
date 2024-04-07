import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/cubit/cubit.dart';
import '../../../core/cubit/states.dart';
import '../../../core/widgets/arrow_back.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_form_field.dart';
import '../../../core/widgets/navigation.dart';
import '../../../core/widgets/snack_bar.dart';
import '../sick_supervisor.dart';

class AddNewSick extends StatelessWidget {
  const AddNewSick({super.key});

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController nameController = TextEditingController();
  static TextEditingController nameSupervisorController = TextEditingController();
  static TextEditingController ageController = TextEditingController();
  static TextEditingController locationController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController phoneSupervisorController = TextEditingController();
  static String image = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase2(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState) {
            nameController.text = '';
            ageController.text = '';
            locationController.text = '';
            phoneController.text = '';
            image = '';
            navigateAndFinish(context, const SickSupervisor());
          }
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Stack(
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: 240,
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .bottomNavigationBarTheme
                              .backgroundColor!,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(220),
                            bottomLeft: Radius.circular(220),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 32),
                        child: Container(
                            alignment: Alignment.topCenter,
                            child: const Text(
                              'تسجيل مريظ جديد',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  navigateBack(context);
                                },
                                child: ArrowBack(
                                  iconData: Icons.arrow_back_ios,
                                  colorIcon: Theme.of(context).scaffoldBackgroundColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final picker = ImagePicker();
                              final imagee = await picker.pickImage(source: ImageSource.gallery);
                              image = imagee!.path;
                              cubit.emitt();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ClipOval(
                                  child: image.isNotEmpty
                                      ? Image.file(
                                          File(image),
                                          width: 140.0,
                                          height: 140.0,
                                          fit: BoxFit.cover,
                                        )
                                      : const Icon(Icons.add_photo_alternate,size: 140,),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 19.0, vertical: 21),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'الاسم   ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      CustomFormField(
                                        textStyleHint: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                        controller: nameController,
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'رجائا ادخل الاسم';
                                          }
                                        },
                                        hintText: 'محمد علي',
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'رقم الهاتف   ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      CustomFormField(
                                        textStyleHint: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                        textInputType: TextInputType.phone,
                                        controller: phoneController,
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'رجائا ادخل رقم الهاتف';
                                          }
                                        },
                                        hintText: '07xxxxxxxxx',
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'اسم الطبيب   ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      CustomFormField(
                                        textStyleHint: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                        controller: nameSupervisorController,
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'رجائا ادخل الاسم';
                                          }
                                        },
                                        hintText: 'د.اسماعيل علي',
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'رقم هاتف الطبيب   ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      CustomFormField(
                                        textStyleHint: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                        textInputType: TextInputType.phone,
                                        controller: phoneSupervisorController,
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'رجائا ادخل رقم الهاتف';
                                          }
                                        },
                                        hintText: '07xxxxxxxxx',
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child:  Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            const Text(
                                              'العمر   ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            CustomFormField(
                                              textStyleHint: Theme.of(context).textTheme.headline3,
                                              textInputType: TextInputType.phone,
                                              controller: ageController,
                                              validate: (String? value) {
                                                if (value!.isEmpty) {
                                                  return 'رجائا ادخل العمر';
                                                }
                                              },
                                              hintText: '52',
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 14,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const Text(
                                              'الموقع   ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            CustomFormField(
                                              textStyleHint: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                              textInputType:
                                                  TextInputType.text,
                                              controller: locationController,
                                              validate: (String? value) {
                                                if (value!.isEmpty) {
                                                  return 'رجائا ادخل الموقع';
                                                }
                                              },
                                              hintText: 'بعقوبة ',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 42,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomBottom(
                                        onTap: () async {
                                          if (formKey.currentState!.validate()) {
                                            if (image.isNotEmpty) {
                                              cubit.insertToDatabase2(
                                                context: context,
                                                name: nameController.text.trim(),
                                                phone: phoneController.text,
                                                age: ageController.text,
                                                location: locationController.text,
                                                imagePath: image,
                                                nameSupervisor: nameSupervisorController.text.trim(),
                                                phoneSupervisor: phoneSupervisorController.text,
                                              );
                                            } else {
                                              showSnackBar(
                                                  context,
                                                  'قم بأختيار صورة',
                                                  Colors.red);
                                            }
                                          }
                                        },
                                        horizontal: 38,
                                        borderRadius: BorderRadius.circular(14),
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        text: 'حفظ المريظ',
                                        colorBottom: Theme.of(context)
                                            .bottomNavigationBarTheme
                                            .backgroundColor!,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                ],
                              ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
