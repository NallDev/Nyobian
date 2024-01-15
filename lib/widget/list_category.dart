import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/theme/font_style.dart';

class MyListCategory extends StatelessWidget {
  final String title;
  final List<Food>? food;
  final List<Drink>? drink;
  final String image;
  const MyListCategory({Key? key, required this.image ,required this.title, this.food, this.drink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.0,),
        Text(
          title,
          style: myTextTheme.titleSmall?.copyWith(color: Colors.pink),
        ),
        SizedBox(height: 8.0,),
        SizedBox(
          height: 180,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: food?.length ?? drink?.length ?? 0,
            itemBuilder: (context, index) {
              return Container(
                width: 120,
                height: 160,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      child: Image.asset(image,
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,),
                    ),
                    SizedBox(height: 8.0,),
                    Text(food?[index].name ?? drink?[index].name ?? "", style: myTextTheme.labelMedium, maxLines: 1, overflow: TextOverflow.ellipsis,)
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 16.0,),
          ),
        )
      ],
    );
  }
}
