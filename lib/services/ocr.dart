// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:io';
// import 'dart:convert';
// import 'package:image_picker/image_picker.dart';
// import 'dart:ui' as ui;

// class Ocr {
//   late final String apiKey;
//   late final String region;
//   late final String endpoint;
//   String? _filePath;

//   // Load .env
//   Ocr() {
//     _initialize();
//   }

//   Future<void> _initialize() async {
//     await dotenv.load(fileName: ".env");

//     // Get the endpoint from .env
//     apiKey = dotenv.env['OCR_KEY'] ?? '';
//     region = dotenv.env['OCR_REGION'] ?? '';
//     endpoint = dotenv.env['OCR_ENDPOINT'] ?? '';

//     // Optionally, set a default path
//     Directory tempDir = await getTemporaryDirectory();
//     _filePath = '${tempDir.path}/image.png';

//     debugPrint('dangtiendung1201: API Key: $apiKey');
//     debugPrint('dangtiendung1201: Region: $region');
//     debugPrint('dangtiendung1201: Endpoint: $endpoint');
//   }

//   Future<String> extractTextFromImage(XFile imageFile) async {
//     final uri = Uri.parse(
//         '$endpoint/computervision/imageanalysis:analyze?features=caption,read&model-version=latest&language=en&api-version=2024-02-01');
//     final headers = {
//       'Content-Type': 'application/json',
//       'Ocp-Apim-Subscription-Key': apiKey,
//     };

//     // Read the image file as bytes
//     // Resize the image to reduce the payload size
//     final image = await decodeImageFromList(await imageFile.readAsBytes());
//     final resizedImage = await image.toByteData(format: ui.ImageByteFormat.png);
//     final bytes = resizedImage!.buffer.asUint8List();
//     final base64Image = base64Encode(bytes);
//     final body = jsonEncode({'data': base64Image});

//     final response = await http.post(uri, headers: headers, body: body);

//     // Print payload size
//     debugPrint('dangtiendung1201: Payload size: ${bytes.length} bytes');

//     // Print payload for debugging
//     debugPrint('dangtiendung1201: Payload: $body');

//     // Print all the response for debugging
//     debugPrint('dangtiendung1201: Response from OCR: ${response.body}');
//     debugPrint(
//         'dangtiendung1201: Status code from OCR: ${response.statusCode}');
//     debugPrint('dangtiendung1201: Image path: ${imageFile.path}');
//     return '';

//     // Print response for debugging
//     // debugPrint('dangtiendung1201: Response from OCR: ${response.body}');
//     // debugPrint(
//     //     'dangtiendung1201: Status code from OCR: ${response.statusCode}');

//     // final jsonResponse = jsonDecode(response.body);
//     // debugPrint('dangtiendung1201: JSON response: $jsonResponse');
//     // return '';

//     // if (response.statusCode == 200) {
//     //   final jsonResponse = jsonDecode(response.body);
//     //   final text = jsonResponse['analyzeResult']['readResults']
//     //       .map((result) =>
//     //           result['lines'].map((line) => line['text']).join('\n'))
//     //       .join('\n');
//     //   debugPrint('dangtiendung1201: Text extracted from image: $text');
//     //   return text;
//     // } else {
//     //   throw Exception(
//     //       'Failed to extract text: ${response.body}, ${response.statusCode}');
//     // }
//   }
// }

//   // curl -v -X POST "https://westcentralus.api.cognitive.microsoft.com/vision/v3.2/read/analyze?model-version=2022-04-30" -H "Content-Type: application/json" -H "Ocp-Apim-Subscription-Key: <subscription key>" --data-ascii "{'url':'https://learn.microsoft.com/azure/ai-services/computer-vision/media/quickstarts/presentation.png'}"
// // curl.exe -H "Ocp-Apim-Subscription-Key: <subscriptionKey>" -H "Content-Type: application/json" "<endpoint>/computervision/imageanalysis:analyze?features=caption,read&model-version=latest&language=en&api-version=2024-02-01" -d "{'url':'https://learn.microsoft.com/azure/ai-services/computer-vision/media/quickstarts/presentation.png'}"

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class Ocr {
  late final String apiKey;
  late final String region;
  late final String endpoint;
  String? _filePath;

  // Load .env
  Ocr() {
    _initialize();
  }

  Future<void> _initialize() async {
    await dotenv.load(fileName: ".env");

    // Get the endpoint from .env
    apiKey = dotenv.env['OCR_KEY'] ?? '';
    region = dotenv.env['OCR_REGION'] ?? '';
    endpoint = dotenv.env['OCR_ENDPOINT'] ?? '';

    // Optionally, set a default path
    Directory tempDir = (await getExternalStorageDirectory())!;
    _filePath = '${tempDir.path}/image.png';

    debugPrint('API Key: $apiKey');
    debugPrint('Region: $region');
    debugPrint('Endpoint: $endpoint');
  }

  Future<String> extractTextFromImage(XFile imageFile) async {
    final uri = Uri.parse(
        '$endpoint/computervision/imageanalysis:analyze?features=caption,read&model-version=latest&language=en&api-version=2024-02-01');
    final headers = {
      'Content-Type': 'application/octet-stream',
      'Ocp-Apim-Subscription-Key': apiKey,
    };

    // Read and resize the image
    final bytes = await imageFile.readAsBytes();
    final originalImage = img.decodeImage(bytes);
    final resizedImage = img.copyResize(originalImage!, width: 800);
    final resizedBytes = img.encodePng(resizedImage);

    // Send the image as binary data
    final response = await http.post(uri, headers: headers, body: resizedBytes);

    // Print payload size
    debugPrint('Payload size: ${resizedBytes.length} bytes');

    // Print response for debugging
    debugPrint('Response from OCR: ${response.body}');
    debugPrint('Status code from OCR: ${response.statusCode}');
    debugPrint('Image path: ${imageFile.path}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      debugPrint('JSON response: $jsonResponse');
      // Process the JSON response to extract text

      // {"modelVersion":"2023-10-01","captionResult":{"text":"a screenshot of a cell phone","confidence":0.7385161519050598},"metadata":{"width":800,"height":797},"readResult":{"blocks":[{"lines":[{"text":"世界各地の絶景の中を空からゆったりと旅をす","boundingPolygon":[{"x":26,"y":9},{"x":772,"y":8},{"x":772,"y":46},{"x":26,"y":47}],"words":[{"text":"世","boundingPolygon":[{"x":29,"y":10},{"x":58,"y":10},{"x":57,"y":48},{"x":28,"y":48}],"confidence":0.995},{"text":"界","boundingPolygon":[{"x":64,"y":10},{"x":89,"y":10},{"x":88,"y":48},{"x":63,"y":48}],"confidence":0.996},{"text":"各","boundingPolygon":[{"x":99,"y":10},{"x":124,"y":10},{"x":123,"y":48},{"x":98,"y":48}],"confidence":0.995},{"text":"地","boundingPolygon":[{"x":134,"y":10},{"x":159,"y":9},{"x":158,"y":48},{"x":134,"y":48}],"confidence":0.996},{"text":"の","boundingPolygon":[{"x":170,"y":9},{"x":194,"y":9},{"x":193,"y":48},{"x":169,"y":48}],"confidence":0.996},{"text":"絶","boundingPolygon":[{"x":205,"y":9},{"
      final text = jsonResponse['readResult']['blocks']
          .map((block) => block['lines'].map((line) => line['text']).join('\n'))
          .join('\n');
      return text;
    } else {
      throw Exception(
          'Failed to extract text: ${response.body}, ${response.statusCode}');
    }
  }
}
