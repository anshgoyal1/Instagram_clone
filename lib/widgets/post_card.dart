import 'package:flutter/material.dart';
import 'package:fluttergram/providers/user_provider.dart';
import 'package:fluttergram/resourses/firestore_methods.dart';
import 'package:fluttergram/utils/colors.dart';
import 'package:fluttergram/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class PostCard extends StatefulWidget {
  final snap;

  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).user;
    return Container(
      color: mobileBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),

            // HEADER SECTION
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.snap['profImage']),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Column(
                      children: [
                        Text(
                          widget.snap['userName'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shrinkWrap: true,
                            children: [
                              'Delete',
                            ]
                                .map(
                                  (e) => InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 16),
                                      child: Text(e),
                                    ),
                                  ),
                                )
                                .toList()),
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),

          // IMAGE SECTION
          GestureDetector(
            onDoubleTap: () async {
              await FireStoreMethods().likePost(
                user!.uid,
                widget.snap['postId'],
                widget.snap['likes'],
              );
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                    widget.snap['postUrl'],
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  duration: Duration(
                    milliseconds: 200,
                  ),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 120,
                    ),
                    isAnimating: isLikeAnimating,
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // LIKE COMMENT SECTION

          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user!.uid),
                smallLike: true,
                child: IconButton(
                    onPressed: () async {
                      await FireStoreMethods().likePost(
                        user.uid,
                        widget.snap['postId'],
                        widget.snap['likes'],
                      );
                    },
                    icon: widget.snap['likes'].contains(user.uid)
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite_outline,
                            color: secondaryColor,
                          )),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.comment_outlined,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.send,
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.bookmark_add_outlined),
                  alignment: Alignment.bottomRight,
                  onPressed: () {},
                ),
              ),
            ],
          ),

          //DESCRIPTION AND NUMBER OF COMMENTS

          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    "${widget.snap['likes'].length} likes",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: widget.snap['userName'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: " ${widget.snap['description']}",
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    child: Text(
                      'View all 20 Comments',
                      style: TextStyle(
                        fontSize: 16,
                        color: secondaryColor,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
                Container(
                  child: Text(
                    DateFormat.yMMMd().format(
                      widget.snap['datePublished'].toDate(),
                    ),
                    style: TextStyle(
                      fontSize: 12,
                      color: secondaryColor,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
