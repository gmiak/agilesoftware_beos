import 'package:app/model/movieModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

/*
** Klassen tar in en parameter som är listan av alla filmer,
** Därmed målas varje filmer med samma format på skärmen.med syftet
** att användare ska bärja swipe
**/
class SwipeMovieView extends StatelessWidget {
  final List<Movie> movies;
  final Function liked;
  //constructor
  SwipeMovieView({this.movies, this.liked});
  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.
    return new Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: new TinderSwapCard(
          swipeUp: false,
          swipeDown: false,
          orientation: AmassOrientation.BOTTOM,
          totalNum: movies.length,
          stackNum: 3,
          swipeEdge: 4.0,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.width * 0.9,
          minWidth: MediaQuery.of(context).size.width * 0.8,
          minHeight: MediaQuery.of(context).size.width * 0.8,
          cardBuilder: (context, index) => Card(
            child: Image.network(
                "https://image.tmdb.org/t/p/w780${movies[index].poster}"),
          ),
          cardController: controller = CardController(),
          swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
            /// Get swiping card's alignment
            if (align.x < 0) {
              //Card is LEFT swiping
            } else if (align.x > 0) {
              //Card is RIGHT swiping
            }
            //print(align.x);
          },
          swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
            /// Get orientation & index of swiped card!
            if (orientation == CardSwipeOrientation.RIGHT) {
              liked();
            }
          },
        ),
      ),
    );
  }
}
