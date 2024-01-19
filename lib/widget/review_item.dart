import 'package:flutter/material.dart';
import 'package:restaurant_app/theme/font_style.dart';

import '../data/model/detail_restaurant_respone.dart';

class ListReview extends StatelessWidget {
  final List<CustomerReview> customerReview;
  final String title;

  const ListReview({Key? key, required this.title, required this.customerReview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8.0,),
        Text(
          title,
          style: myTextTheme.titleSmall?.copyWith(color: Colors.pink),
        ),
        ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return _reviewItem(customerReview[index],
              );
            },
            separatorBuilder: (_, index) => const SizedBox(
              height: 8.0,
            ),
            itemCount:
            customerReview.length > 5 ? 5 : customerReview.length),
      ],
    );
  }

  Widget _reviewItem(CustomerReview item) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 16.0,
              spreadRadius: 1.0,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Expanded(
                child: Icon(Icons.supervised_user_circle)),
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: myTextTheme.labelMedium?.copyWith(color: Colors.pinkAccent),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      item.review,
                      style: myTextTheme.labelSmall,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}