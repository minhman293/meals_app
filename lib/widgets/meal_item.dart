import 'package:flutter/material.dart';

import 'package:meal_app/widgets/meal_item_info.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:meal_app/models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;
  final void Function(BuildContext context, Meal meal) onSelectMeal;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge, // force rounded child
      child: InkWell(
        onTap: () {
          onSelectMeal(context, meal);
        },
        child: Stack(
          children: [
            FadeInImage(
              // Placeholder image displayed while the target image is loading
              placeholder: MemoryImage(kTransparentImage),

              // Target image to be displayed once it's loaded
              image: NetworkImage(meal.imageUrl),

              // BoxFit determines how the image should be inscribed into the box
              fit: BoxFit.cover,

              // Height of the widget
              height: 200,

              // Width of the widget, set to occupy the available width (infinity)
              width: double.infinity,
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  color: const Color.fromARGB(81, 0, 0, 0),
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow
                            .ellipsis, // if text more than 2 lines, it will cut to '...'
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MealItemInfo(
                            icon: Icons.timer_outlined,
                            label: '${meal.duration} min',
                          ),
                          const SizedBox(width: 20),
                          MealItemInfo(
                            icon: Icons.equalizer,
                            label: meal.complexity.name,
                          ),
                          const SizedBox(width: 20),
                          MealItemInfo(
                            icon: Icons.attach_money,
                            label: meal.affordability.name,
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
