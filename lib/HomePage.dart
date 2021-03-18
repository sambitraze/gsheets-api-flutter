import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "gseets-sambitraze",
  "private_key_id": "968362e588fb5c45f7e1e36a86af70d9c859f23d",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDJ6JI3lLTrOTZm\nNhdlluNE/WdHhvztNZHlMPu5qWPeYgeQ9IjDBjNCiEpDDfQAzIdmLW2D/E9vbn09\npUEdWGVB5b3l1x/rfgDI/1QAdYvP4M++XTC2C/1aGdOPkEU8ZYUdHTfhv8YgT12M\nGC5V3E5/0P76JI+SlJePJJe2o7uadhPByLPfOP/xxQ9R6koC8AeLZEnf3ng2pxBl\nydvN+uArc65Zn7amZix1QyklExXLSXtb3WUwzhqKhRo3jGH/zZVvGXoI1ulCBW5q\nMk4ToDEKIwQZalESHoFchGfxfXoBICNpZxeE0ZwL8WgV6W0XRlxGtvYNJI1Kjr84\n3eSVkeubAgMBAAECggEAHEHkVMsHFvSG3H8tfxZC8GDWl3gY5cndhUn5sN44D+OA\nU5UlnsW7XtBcNE47m/ED8hThgttI8rtv47TBDC5W3YYdsZEN8pNL4NV7GCVbT9iS\nun2oV5IN/xImPa1fQziiDJUOQRXp0JPK79Rih7mxcsn5JWEAhu8s1ue0I+d+Vft4\n0XAperAdMmLlX8YNC/RK6nPVLmmeyYO++c6bDxkMk7Ajyy3/1PkjXr3vchIsIUNs\n1FhsrQYMbR9h8Ju9NXnr7rjCE5Wir2wmg22J2cdHhguL9jwSbz+5ZGPf49vR4eEs\nm4PEyw79Wjg72RrH96jcXnJxPZ090DuvffrGNvMgAQKBgQDsLK5kYltTG44APpbo\nxpIG90LeXApbS6fSdnDao9llfLOuoG5Xx/KoAD6uD8xeN7Gt0+ResWETWluk0fOH\nFDQ4XljmZye1kZCyVmuCV9kXO3TosH/xS6NdMRU2PJpOCJ3grafLWqovEXDLEmdS\noPr9ZyI97NldDyeLUltzWyA/mwKBgQDa24XaoOHru/nidHjejmNkiQBFmtxXVPz+\n0AsNgnAyijjsiiQAOTDbNTt11e3JdJF+DANEpKOU4z6V4rQLrMSHzqPADm8OCSJJ\nismps3wKI+P5pMF+Yn/P/J6/KsqsUGYrKEE+IVcWFewuObGiQ87i97qv3Ocr1jYy\n2WJIiq3EAQKBgEi3ERKTPe7+ot/sZWZSDQ/b/VidGgs15fvkv6ZxoDOhC2mOt6qL\nQ2j6elH5R0ETAL+2Z6/ICU1+Go1KnyJN1C4uzkxSImXC5bwi44MELTD7+2jRPvM6\nCJhezlsemZvBB2rvzKPNzGwlgIblqa5FJkHzCRXr4JjIW7KHruR7gBhVAoGAXyoP\nVRaZxhhRuu9sU1HU1DViQeHpp6vT6rTp6XDren5x7CDRMKutm9PUzBM+t1eRoB53\nGVUBsE7zutb99Qml12u59lwQXCkKmLHZqIncCMi8a6QBYwRPkU/Gc1eXE0BOfLuf\nSvXSWU8lCKCbpfQYNMcFjUzf1EbsAEZYHzT2BAECgYBwNPh6RcyhsRJPhuBlqd4F\nNteKsrABlulSSh2SbOEW7pdK+3Ze0Os+mXJX+RTeBsSHDX1buPX85VOUBxyvEfYR\n1dpDqoV71lHGQbAJ47F1SLt+GSli/6f8V59jlSX/fNjGZEYRniGgJ4T4T2xzKiFK\nX3l8kk4XcxmHhxclOhe3VQ==\n-----END PRIVATE KEY-----\n",
  "client_email": "sambitraze@gseets-sambitraze.iam.gserviceaccount.com",
  "client_id": "113331154037034031104",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/sambitraze%40gseets-sambitraze.iam.gserviceaccount.com"
}
''';
// your spreadsheet id
  static const _spreadsheetId = '1IsOKgZ-C9rIeZwpqDkEIFtQMUqbULYMOFNg-biPFP4E';

  runapp() async {
    final gsheets = GSheets(_credentials);
    // fetch spreadsheet by its id
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    // get worksheet by its title
    var sheet = ss.worksheetByTitle('example');
    // create worksheet if it does not exist yet
    sheet ??= await ss.addWorksheet('example');

    // update cell at 'B2' by inserting string 'new'
    await sheet.values.insertValue('new', column: 2, row: 2);
    // prints 'new'
    print(await sheet.values.value(column: 2, row: 2));
    // get cell at 'B2' as Cell object
    final cell = await sheet.cells.cell(column: 2, row: 2);
    // prints 'new'
    print(cell.value);
    // update cell at 'B2' by inserting 'new2'
    await cell.post('new2');
    // prints 'new2'
    print(cell.value);
    // also prints 'new2'
    print(await sheet.values.value(column: 2, row: 2));

    // insert list in row #1
    final firstRow = ['index', 'letter', 'number', 'label'];
    await sheet.values.insertRow(1, firstRow);
    // prints [index, letter, number, label]
    print(await sheet.values.row(1));

    // insert list in column 'A', starting from row #2
    final firstColumn = ['0', '1', '2', '3', '4'];
    await sheet.values.insertColumn(1, firstColumn, fromRow: 2);
    // prints [0, 1, 2, 3, 4, 5]
    print(await sheet.values.column(1, fromRow: 2));

    // insert list into column named 'letter'
    final secondColumn = ['a', 'b', 'c', 'd', 'e'];
    await sheet.values.insertColumnByKey('letter', secondColumn);
    // prints [a, b, c, d, e, f]
    print(await sheet.values.columnByKey('letter'));

    // insert map values into column 'C' mapping their keys to column 'A'
    // order of map entries does not matter
    final thirdColumn = {
      '0': '1',
      '1': '2',
      '2': '3',
      '3': '4',
      '4': '5',
    };
    await sheet.values.map.insertColumn(3, thirdColumn, mapTo: 1);
    // prints {index: number, 0: 1, 1: 2, 2: 3, 3: 4, 4: 5, 5: 6}
    print(await sheet.values.map.column(3));

    // insert map values into column named 'label' mapping their keys to column
    // named 'letter'
    // order of map entries does not matter
    final fourthColumn = {
      'a': 'a1',
      'b': 'b2',
      'c': 'c3',
      'd': 'd4',
      'e': 'e5',
    };
    await sheet.values.map.insertColumnByKey(
      'label',
      fourthColumn,
      mapTo: 'letter',
    );
    // prints {a: a1, b: b2, c: c3, d: d4, e: e5, f: f6}
    print(await sheet.values.map.columnByKey('label', mapTo: 'letter'));

    // appends map values as new row at the end mapping their keys to row #1
    // order of map entries does not matter
    final secondRow = {
      'index': '5',
      'letter': 'f',
      'number': '6',
      'label': 'f6',
    };
    await sheet.values.map.appendRow(secondRow);
    // prints {index: 5, letter: f, number: 6, label: f6}
    print(await sheet.values.map.lastRow());

    // get first row as List of Cell objects
    final cellsRow = await sheet.cells.row(1);
    // update each cell's value by adding char '_' at the beginning
    cellsRow.forEach((cell) => cell.value = '_${cell.value}');
    // actually updating sheets cells
    await sheet.cells.insert(cellsRow);
    // prints [_index, _letter, _number, _label]
    print(await sheet.values.row(1));
  }

  @override
  void initState() {
    super.initState();
    runapp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
