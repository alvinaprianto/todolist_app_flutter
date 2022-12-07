import 'package:flutter/material.dart';

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({
    Key? key,
    required PageController pageController,
    required this.imgOnboardList,
    required int currentPage,
    required onTap,
  })  : _pageController = pageController,
        _currentPage = currentPage,
        _onTap = onTap,
        super(key: key);

  final PageController _pageController;
  final Map<String, List<String>> imgOnboardList;
  final int _currentPage;
  final void Function(int)? _onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.7,
      child: PageView(
        onPageChanged: _onTap,
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: imgOnboardList.entries.map((e) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                e.key,
                height: 240,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 4,
                  width: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: ((context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 5, left: 5),
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _currentPage == index
                                ? Colors.white
                                : Colors.grey,
                          ),
                        );
                      })),
                ),
              ),
              Text(
                e.value[0],
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  e.value[1],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
