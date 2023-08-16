import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

parsePokemonIdFromUrl(String pokemonUrl) {
  return pokemonUrl.split('/').toSet().toList().last;
}

showErrorDialog(
    {String errorMsg = 'Oops, Something went wrong!!',
    required GestureTapCallback? onRefresh}) {
  BotToast.showCustomLoading(toastBuilder: (_) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              errorMsg,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                BotToast.closeAllLoading();
                if (onRefresh != null) {
                  onRefresh();
                }
              },
              child: Container(
                width: 150,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.5),
                    border: Border.all(color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Try Again',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const Center(
                        child: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ))
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  });
}
