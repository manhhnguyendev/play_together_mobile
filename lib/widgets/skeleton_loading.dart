import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoading extends StatefulWidget {
  const SkeletonLoading({Key? key}) : super(key: key);

  @override
  State<SkeletonLoading> createState() => _SkeletonLoadingState();
}

class _SkeletonLoadingState extends State<SkeletonLoading> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      period: const Duration(milliseconds: 1000),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 15, 5),
            child: Container(
              width: 180,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  shape: BoxShape.rectangle,
                  color: Colors.grey),
            ),
          ),
          SingleChildScrollView(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                      height: 230.0,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return buildBox();
                          })),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBox() {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 15),
        child: SizedBox(
          width: 140 / 365 * size.width,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  padding: EdgeInsets.all(1 / 1000 * size.width),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
                      color: Colors.grey),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 20,
                padding: EdgeInsets.all(1 / 1000 * size.width),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                    color: Colors.grey),
              ),
              const SizedBox(height: 5),
              Container(
                height: 20,
                padding: EdgeInsets.all(1 / 1000 * size.width),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                    color: Colors.grey),
              ),
            ],
          ),
        ));
  }
}
