import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:puppeteer/puppeteer.dart' as p;

Future<Response> onRequest(RequestContext context) async {
  final params = context.request.uri.queryParameters;
  final site = params['s'] ?? 'https://google.com';

  final browser = await p.puppeteer.launch();

  final myPage = await browser.newPage();

  await myPage.goto(site, wait: p.Until.networkIdle);

  for (var a = 0; a < 10; a++) {
    await myPage.keyboard.press(p.Key.pageDown);
  }

  final dataPage = await myPage.content;

  await browser.close();

  return Response(
    body: dataPage,
    headers: {
      HttpHeaders.contentTypeHeader: ContentType.text.value,
    },
  );
}
