import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_work/AppState/providers/homeListingProvider.dart';
import 'package:team_work/pages/detail/detail.dart';
import 'package:team_work/widgets/loadingWidgets/verticalListLoading.dart';
import '../pages/listing/listing.dart';

class Listing extends StatelessWidget {
  const Listing({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeListingProvider>(context, listen: false).getHomeListing();
    });
    String curl = "?*";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Listing',
                style: GoogleFonts.ubuntu(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).secondaryHeaderColor),
              ),
              GestureDetector(
                onTap: () {
                  curl = "?*";
                  print(curl);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ListingPage(curl: curl),
                    ),
                  );
                },
                child: Text(
                  'View All',
                  style: GoogleFonts.ubuntu(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).secondaryHeaderColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // here it starts
          Consumer<HomeListingProvider>(
            builder: (context, value, child) {
              return value.isLoading
                  ? const VerticalListLoading()
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.homeListing.length,
                      itemBuilder: (context, index) {
                        return ListingCard(map: value.homeListing[index]);
                      },
                    );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ), backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      curl = "?*";
                      print(curl);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ListingPage(curl: curl)));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'View More',
                        style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ListingCard extends StatelessWidget {
  ListingCard({Key? key, required this.map}) : super(key: key);

  var map;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DetailPage(id: map.id);
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  width: 150.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(map.primary_image),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          map.title,
                          style: GoogleFonts.ubuntu(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).secondaryHeaderColor),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                            Expanded(
                              child: Text(
                                map.address,
                                style: GoogleFonts.ubuntu(
                                    fontSize: 12.0,
                                    color:
                                        Theme.of(context).secondaryHeaderColor),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  map.price + ' PKR',
                  style: GoogleFonts.ubuntu(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
