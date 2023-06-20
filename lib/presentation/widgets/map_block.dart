import 'package:flutter/material.dart';
import 'package:our_story/presentation/theme/L10n.dart';
import 'package:our_story/presentation/widgets/prefecture.dart';

//佐賀から沖縄まで
class block1 extends StatelessWidget {
  const block1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrefectureS(text: L10n.saga),
                PrefectureS(text: L10n.hukuoka),
                PrefectureS(text: L10n.ooita),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    PrefectureS(text: L10n.nagasaki),
                    PrefectureS(text: L10n.kumamoto),
                  ],
                ),
                PrefectureWide(text: L10n.kagoshima),
              ],
            ),
            PrefectureTall(text: L10n.miyazaki),
          ],
        ),
        PrefectureS(text: L10n.okinawa),
      ],
    );
  }
}

//山口から徳島まで
class block2 extends StatelessWidget {
  const block2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            PrefectureTall(text: L10n.yamaguchi),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrefectureS(text: L10n.shimane),
                    PrefectureS(text: L10n.tottori),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrefectureS(text: L10n.hiroshima),
                    PrefectureS(text: L10n.okayama),
                  ],
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrefectureS(text: L10n.ehime),
                PrefectureS(text: L10n.kagawa),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrefectureS(text: L10n.kouti),
                PrefectureS(text: L10n.tokushima),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

//兵庫から和歌山まで
class block3 extends StatelessWidget {
  const block3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrefectureS(text: L10n.hyogo),
            PrefectureS(text: L10n.kyoto),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrefectureS(text: L10n.oosaka),
            PrefectureS(text: L10n.nara),
          ],
        ),
        PrefectureWide(text: L10n.wakayama),
        SizedBox(height: h),
      ],
    );
  }
}

//石川から静岡まで
class block4 extends StatelessWidget {
  const block4({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrefectureS(text: L10n.ishikawa),
            PrefectureS(text: L10n.toyama),
            PrefectureS(text: L10n.niigata),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                PrefectureS(text: L10n.hukui),
                PrefectureS(text: L10n.siga)
              ],
            ),
            PrefectureTall(text: L10n.gihu),
            PrefectureTall(text: L10n.nagano),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrefectureS(text: L10n.mie),
            PrefectureS(text: L10n.aiti),
            PrefectureS(text: L10n.yamanashi),
          ],
        ),
        SizedBox(
            width: w3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [PrefectureS(text: L10n.sizuoka)],
            )),
      ],
    );
  }
}

//北海道から千葉まで
class block5 extends StatelessWidget {
  const block5({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PrefectureBig(text: L10n.hokkai),
        SizedBox(height: 20),
        PrefectureWide(text: L10n.aomori),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrefectureS(text: L10n.akita),
            PrefectureS(text: L10n.iwate),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrefectureS(text: L10n.yamagata),
            PrefectureS(text: L10n.miyagi),
          ],
        ),
        PrefectureWide(text: L10n.hukushima),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrefectureS(text: L10n.gunma),
            PrefectureS(text: L10n.totigi),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrefectureS(text: L10n.saitama),
            PrefectureS(text: L10n.ibaraki),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                PrefectureS(text: L10n.tokyo),
                PrefectureS(text: L10n.kanagawa),
              ],
            ),
            PrefectureTall(text: L10n.tiba),
          ],
        ),
      ],
    );
  }
}
