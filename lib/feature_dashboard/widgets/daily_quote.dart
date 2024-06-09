import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_Auth/getx_controllers/user_controller.dart';
import 'package:coupler_app/feature_dashboard/models/daily_quote_model.dart';
import 'package:coupler_app/feature_dashboard/utils/daily_stuff_class.dart';
import 'package:coupler_app/shared_widgets/bubble_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyQuote extends HookWidget {
  const DailyQuote({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();

    var dailyQuote = useState<DailyQuoteModel?>(null);

    DailyStuffClass dailyStuffClass = DailyStuffClass();

    Future getQuoteOfTheDay() async {
      var response = await dailyStuffClass
          .getDailyQuote(userController.user.value.accessToken);

      dailyQuote.value = response;
    }

    useEffect(() {
      getQuoteOfTheDay();
    }, []);

    return BubbleContainer(
        imageUrl: 'assets/images/thought_of_the_day_unsplash_amy_shamblen.jpg',
        icon: FaIcon(
          FontAwesomeIcons.quoteLeft,
          color: Theme.of(context).colorScheme.light,
        ),
        position: 'START',
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -60.0,
                left: 60.0,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).colorScheme.darkPink),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
                    child: Text(
                      'lbl_QuoteOfTheDay'.tr,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.light),
                    ),
                  ),
                ),
              ),
              dailyQuote.value == null
                  ? const SizedBox()
                  : Text(
                      dailyQuote.value!.textContent.originalText
                          .split(' - ')
                          .first,
                      style: GoogleFonts.merienda(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.light)),
            ],
          ),
          dailyQuote.value == null
              ? const SizedBox()
              : Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    dailyQuote.value!.textContent.originalText.split(' - ')[1],
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Theme.of(context).colorScheme.light),
                  ),
                )
        ]);
  }
}
