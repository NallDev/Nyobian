import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:restaurant_app/theme/font_style.dart';

class MyListCategory extends StatelessWidget {
  final String title;
  final List<Category> category;
  final String image;
  const MyListCategory(
      {Key? key,
      required this.image,
      required this.title,
      required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8.0,
        ),
        Text(
          title,
          style: myTextTheme.titleSmall?.copyWith(color: Colors.pink),
        ),
        const SizedBox(
          height: 8.0,
        ),
        SizedBox(
          height: 180,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: category.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 120,
                height: 160,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                      child: Image.asset(
                        image,
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      category[index].name,
                      style: myTextTheme.labelMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 16.0,
            ),
          ),
        )
      ],
    );
  }
}
