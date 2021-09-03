import 'package:flutter/material.dart';
import 'package:foody/helper.dart';
import 'package:foody/models/meal.dart';
import 'package:foody/screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  const MealItem({
    Key? key,
    required this.meal,
  }) : super(key: key);

  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(MealDetailScreen.routeName, arguments: {
      'meal': meal,
    });
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Hero(
                      tag: meal.id,
                      child: InteractiveViewer(
                        child: FadeInImage(
                          width: double.infinity,
                          height: 200,
                          placeholder: AssetImage('assets/images/a2.png'),
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            '${meal.imageUrl}',
                          ),
                        ),
                      ),
                    ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                        )),
                    child: Text(
                      toText('meal-${meal.id}', context),
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: Theme.of(context).buttonColor,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                          "${meal.duration} ${meal.duration == 1 || meal.duration > 10 ? toText('min', context) : toText('min2', context)}")
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.work,
                        color: Theme.of(context).buttonColor,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(toText('${meal.complexity}', context)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        color: Theme.of(context).buttonColor,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(toText('${meal.affordability}', context)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
