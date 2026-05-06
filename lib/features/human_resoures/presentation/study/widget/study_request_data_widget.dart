import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/features/human_resoures/presentation/controller/study/study_cubit.dart';

class StudyRequestDataWidget extends StatelessWidget {

  const StudyRequestDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudyCubit, StudyState>(
      builder: (context, state) {
        return Column(
          children: [

            /// tilte
            Center(child: Text("بيانات الطلب")),
            Column(
              children: [
                Text('نوع الدراسه'),
                Text('الدراسه المطلوبه '),
                Text('الجهه المقذمه للدراسه المطلوبه '),
                Text('الجهه المقذمه للدراسه المطلوبه '),
              ],
            ),

            /// tilte
            Center(child: Text("مببرات الطلب")),
            Container(
              child: Text("تكست عن مببرات الطلب"),
            ),

            /// tilte
            Center(child: Text("مده الدراسه")),
            Column(
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text('من تاريخ ميلادي '),
                    Text('ميلادي الي تاريخ '),
                  ],
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text('من تاريخ هجزي '),
                    Text('هجري الي تاريخ '),
                  ],
                ),
                Text(
                    'مده الدراسه: المده محسوبه بالايام والشهور  بناء علي البدايه والنهاريه'),
              ],
            ),
          ],
        );
      },
    );
  }
}
