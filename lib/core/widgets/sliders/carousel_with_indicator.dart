
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




class CarouselSlide{
  final String imagePath;
  String? link;

  CarouselSlide({required this.imagePath , this.link});
}
class CarouselWithIndicator extends StatefulWidget {
  final List<CarouselSlide> imgList;
  final bool autoPlay;

  const CarouselWithIndicator({Key? key, required this.imgList,  this.autoPlay = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  // @override
  // void initState() {
  //   super.initState();
  //   loadAsset();
  // }
  //
  // void loadAsset() async {
  //   Uint8List data = (await rootBundle.load('assets/logo/loading2.png'))
  //       .buffer
  //       .asUint8List();
  //  print(data);
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.imgList.length == 0) return Container();

    List<Widget> imageSliders = widget.imgList
        .map((item) => InkWell(
          onTap: (){

          },
          child: Container(
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(

                      child: Container(
                        // decoration: BoxDecoration(
                        //   gradient: LinearGradient(
                        //     colors: [
                        //       // AppColors.primary[50]!,
                        //       // AppColors.white1,
                        //     ],
                        //     begin: Alignment.bottomCenter,
                        //     end: Alignment.topCenter,
                        //   ),
                        // ),
                        child: Stack(
                          children: <Widget>[
                            Image.network(
                               item.imagePath,

                              fit: BoxFit.fill,

                            ),
                            // FadeInImage.memoryNetwork(
                            //   placeholderScale: 0.1,
                            //   fit: BoxFit.cover,
                            //   placeholder:  transparentImage,
                            //   image: item,
                            //   width: 75.0.w ,
                            //   height: 30.0.h,
                            // ),
                            // Image.network(item, fit: BoxFit.cover, width: 75.0.w , height: 30.0.h,),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                // child: Text(
                                //   'No. ${widget.imgList.indexOf(item)} image',
                                //   style: TextStyle(
                                //     color: Colors.white,
                                //     fontSize: 20.0,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
        ))
        .toList();

    return Column(children: [
      CarouselSlider(
        items: imageSliders,
        carouselController: _controller,

        options: CarouselOptions(
          viewportFraction: 1,
            autoPlay: widget.autoPlay,
            height: 250.0,
            disableCenter: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.imgList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 7.0,
              height: 7.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.blue)
                      ?.withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
