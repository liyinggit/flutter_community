import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageGridList extends StatefulWidget {
  @override
  _ImageGridListState createState() => _ImageGridListState();
}

typedef BannerTapCallback = void Function(Photo photo);

class Photo {
  Photo({this.assetName, this.title, this.caption});

  final String assetName;
  final String title;
  final String caption;

  bool isFavorite;

  String get tag => assetName;

  bool get isValid =>
      assetName != null &&
      title != null &&
      caption != null &&
      isFavorite != null;
}

class _ImageGridListState extends State<ImageGridList> {
  List<Photo> photos = <Photo>[
    Photo(
      assetName: 'images/india_chennai_flower_market.png',
      title: 'Chennai',
      caption: 'Flower Market',
    ),
    Photo(
      assetName: 'images/india_tanjore_bronze_works.png',
      title: 'Tanjore',
      caption: 'Bronze Works',
    ),
    Photo(
      assetName: 'images/india_tanjore_market_merchant.png',
      title: 'Tanjore',
      caption: 'Market',
    ),
    Photo(
      assetName: 'images/india_tanjore_thanjavur_temple.png',
      title: 'Tanjore',
      caption: 'Thanjavur Temple',
    ),
    Photo(
      assetName: 'images/india_tanjore_thanjavur_temple_carvings.png',
      title: 'Tanjore',
      caption: 'Thanjavur Temple',
    ),
    Photo(
      assetName: 'images/india_pondicherry_salt_farm.png',
      title: 'Pondicherry',
      caption: 'Salt Farm',
    ),
    Photo(
      assetName: 'images/india_chennai_highway.png',
      title: 'Chennai',
      caption: 'Scooters',
    ),
    Photo(
      assetName: 'images/india_chettinad_silk_maker.png',
      title: 'Chettinad',
      caption: 'Silk Maker',
    ),
    Photo(
      assetName: 'images/india_chettinad_produce.png',
      title: 'Chettinad',
      caption: 'Lunch Prep',
    ),
    Photo(
      assetName: 'images/india_tanjore_market_technology.png',
      title: 'Tanjore',
      caption: 'Market',
    ),
    Photo(
      assetName: 'images/india_pondicherry_beach.png',
      title: 'Pondicherry',
      caption: 'Beach',
    ),
    Photo(
      assetName: 'images/india_pondicherry_fisherman.png',
      title: 'Pondicherry',
      caption: 'Fisherman',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;

    ///检测横屏竖屏的

    return Scaffold(
      appBar: new AppBar(
        title: const Text('Grid List'),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuItem>[
              const PopupMenuItem(
                value: 'Image Only',
                child: Text('Image only'),
              ),
              const PopupMenuItem(
                value: 'Image Only',
                child: Text('Image only'),
              ),
              const PopupMenuItem(
                value: 'Image Only',
                child: Text('Image only'),
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SafeArea(
              top: false,
              bottom: false,
              child: GridView.count(
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                padding: const EdgeInsets.all(4.0),
                childAspectRatio:
                    (orientation == Orientation.portrait) ? 1.0 : 1.3,
                children: photos.map<Widget>((Photo photo) {
                  return GridDemoPhotoItem(
                    photo: photo,
                    onBannerTap: (Photo photo) {
                      setState(() {
                        photo.isFavorite = !photo.isFavorite;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

///每一块
class GridDemoPhotoItem extends StatelessWidget {
  GridDemoPhotoItem({
    Key key,
    @required this.photo,
    @required this.onBannerTap,
  })  : assert(photo != null && photo.isValid),
        assert(onBannerTap != null),
        super(key: key);

  final Photo photo;
  final BannerTapCallback
      onBannerTap; // User taps on the photo's header or footer.

  ///打开大图
  void showPhoto(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(photo.title),
          ),
          body: SizedBox.expand(
            child: Hero(
              tag: photo.tag,
              child: null,
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    ///图片
    final Widget image = GestureDetector(
      onTap: () {
        showPhoto(context);
      },
      child: Hero(
        key: Key(photo.assetName),
        tag: photo.tag,
        child: Image.asset(
          photo.assetName,
          fit: BoxFit.cover,
        ),
      ),
    );

    ///图标
    final IconData icon = photo.isFavorite ? Icons.star : Icons.star_border;

    return GridTile(
      footer: GestureDetector(
        onTap: () { onBannerTap(photo); },
        child: GridTileBar(
          backgroundColor: Colors.black45,
          title: _GridTitleText(photo.title),
          subtitle: _GridTitleText(photo.caption),
          trailing: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
      child: image,
    );
  }
}

///标题部分,可以传参进入
class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Text(text),
    );
  }
}
