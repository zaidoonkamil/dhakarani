import 'package:flutter/material.dart';

import '../../core/local/cache_helper.dart';
import '../../core/styles/colors.dart';
import '../../core/widgets/navigation.dart';
import '../sick/sick.dart';
import '../sicksupervisor/sick_supervisor.dart';

class Choose extends StatelessWidget {
  const Choose({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          backgroundColor: const Color(0XFFF5F5F5),
          body: Stack(
            children: [
              SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Image.asset('assets/images/4c39184d9613bb94c361a0e25fa23b35.jpg',fit: BoxFit.fill,),
              ),
              Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('اختر الحالة التي تريدها'),
                        const SizedBox(height: 20,),
                        GestureDetector(
                          onTap: (){
                            CacheHelper.saveData(key: 'onChoose',value: "sick" );
                            navigateAndFinish(context, const Sick());
                          },
                          child: Center(
                            child: Container(
                              width: 140,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: primaryColor
                              ),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('مريظ',style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6,),
                        GestureDetector(
                          onTap: (){
                            CacheHelper.saveData(key: 'onChoose',value: "SickSupervisor" );
                            navigateAndFinish(context, const SickSupervisor());
                          },
                          child: Center(
                            child: Container(
                              width: 140,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: primaryColor
                              ),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('مشرف',style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
