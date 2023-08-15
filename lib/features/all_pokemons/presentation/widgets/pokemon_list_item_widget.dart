import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon/core/constants/color_constants.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class PokemonListItemWidget extends StatelessWidget {
  const PokemonListItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorConstant.isabelline,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '#001',
                              style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstant.darkCharcoal),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'name',
                              style: GoogleFonts.roboto(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(20)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/1.gif",
                          // "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1281.png",
                          placeholder: (context, url) => Shimmer(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              CachedNetworkImage(
                            imageUrl:
                                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
                            // "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1281.png",
                            placeholder: (context, url) => Shimmer(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
          
  }
}