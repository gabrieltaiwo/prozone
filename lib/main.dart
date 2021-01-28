import 'package:flutter/material.dart';
import 'screens/providers_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Providers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProvidersListScreen(),
    );
  }
}

// class ProvidersListScreen extends StatefulWidget {
//   @override
//   _ProvidersListScreenState createState() => _ProvidersListScreenState();
// }
//
// class _ProvidersListScreenState extends State<ProvidersListScreen> {
//   List<Providers> providersList = List();
//   Providers provider;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     this.getProvidersData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('List of Providers'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         //color: Colors.blue,
//         child: Text(
//           'Add',
//           style: TextStyle(color: Colors.white),
//         ),
//         onPressed: () {
//           showModalBottomSheet(
//             context: context,
//             isScrollControlled: true,
//             builder: (context) => SingleChildScrollView(
//               child: Container(
//                 padding: EdgeInsets.only(
//                     bottom: MediaQuery.of(context).viewInsets.bottom),
//                 child: AddProvidersScreen(),
//               ),
//             ),
//           );
//         },
//       ),
//       body: ListView.builder(
//         itemCount: providersList.length,
//         itemBuilder: (context, index) {
//           return FlatButton(
//             child: ListTile(
//               title: Text(providersList[index].name),
//               //subtitle: Text(providerslist[index].description),
//             ),
//             onPressed: () => showAlertDialog(context, index),
//           );
//         },
//       ),
//     );
//   }
//
//   showAlertDialog(BuildContext context, int index) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return ProvAlertDialog(providersList[index]);
//       },
//     );
//   }
//
//   //{HttpHeaders.authorizationHeader: token},
//   //{"Content-Type": "application/json"}
//   //https://pro-zone.herokuapp.com/documentation/v1.0.0#/Provider/get_providers
//   Future<List<Providers>> getProvidersData() async {
//     const providerURL = "https://pro-zone.herokuapp.com/providers";
//     // const token =
//     //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjExNTYzNjEzLCJleHAiOjE2MTQxNTU2MTN9.e5Df8V75KU44Hz4IG1ilKby0ptkJzX7hFcbX5XZ-EEI";
//     String requestURL = '$providerURL';
//     http.Response response = await http.get(requestURL, headers: {
//       HttpHeaders.authorizationHeader:
//           'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjExNTYzNTg3LCJleHAiOjE2MTQxNTU1ODd9.KLKN7sJGyoz8y2tFHCiYbTkxRFqtJUuhSzaxtuDedco'
//     });
//     print(response.statusCode);
//     print(response.body);
//     var res = response.body;
//     var list = json.decode(res) as List;
//     List<Providers> listvalues =
//         list.map((e) => Providers.fromJson(e)).toList();
//
//     this.setState(() {
//       providersList.addAll(listvalues);
//     });
//     return listvalues;
//   }
//
//   void getProviderData(int providerId) async {
//     String providerURL = "https://pro-zone.herokuapp.com/providers/$providerId";
//     // const token =
//     //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjExNTYzNjEzLCJleHAiOjE2MTQxNTU2MTN9.e5Df8V75KU44Hz4IG1ilKby0ptkJzX7hFcbX5XZ-EEI";
//     String requestURL = '$providerURL';
//     http.Response response = await http.get(requestURL, headers: {
//       HttpHeaders.authorizationHeader:
//           'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjExNTYzNTg3LCJleHAiOjE2MTQxNTU1ODd9.KLKN7sJGyoz8y2tFHCiYbTkxRFqtJUuhSzaxtuDedco'
//     });
//     print(response.statusCode);
//     print(response.body);
//     var res = response.body;
//     var providerJson = json.decode(res);
//
//     this.setState(() {
//       provider = Providers.fromJson(providerJson);
//     });
//   }
// }
