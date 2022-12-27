// import 'package:conferenceapp/agenda/helpers/agenda_layout_helper.dart';
// import 'package:conferenceapp/agenda/widgets/new_populated_agenda_list.dart';
// import 'package:conferenceapp/model/agendas.dart';
// import 'package:conferenceapp/profile/auth_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';

// class NewPopulatedAgendaTable extends StatefulWidget {
//   const NewPopulatedAgendaTable(
//     this.talks,
//     this.pageController, {
//     this.isAgenda = false,
//     this.skipWidgetPreload = false,
//     Key? key,
//   }) : super(key: key);

//   final bool isAgenda;
//   final AgendasQuerySnapshot talks;
//   final PageController pageController;
//   final bool skipWidgetPreload;

//   @override
//   _NewPopulatedAgendaTableState createState() =>
//       _NewPopulatedAgendaTableState();
// }

// class _NewPopulatedAgendaTableState extends State<NewPopulatedAgendaTable> {
//   List<String>? fav;
//   @override
//   void initState() {
//     super.initState();
//     RepositoryProvider.of<AuthRepository>(context)
//         .favorites()
//         .then((value) => fav = value);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final layoutHelper = Provider.of<AgendaLayoutHelper>(context);
//     final compact = layoutHelper.isCompact();
//     return PageView(
//       controller: widget.pageController,
//       physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
//       children: <Widget>[
//         RefreshIndicator(
//           onRefresh: () async {
//             RepositoryProvider.of<AuthRepository>(context).favorites().then(
//               (value) {
//                 setState(() {
//                   fav = value;
//                 });
//               },
//             );
//           },
//           child: NewPopulatedAgendaDayListContent(
//             agenda: widget.isAgenda,
//             compact: compact,
//             layoutHelper: layoutHelper,
//             snapshot: widget.isAgenda
//                 ? widget.talks.docs.last.data.dayOne!
//                 : widget.talks.docs.last.data.dayOne!.where((element) {
//                     if (fav != null) {
//                       return fav!.contains(element.id);
//                     } else {
//                       return element.id == element.id;
//                     }
//                   }).toList(),
//           ),
//         ),
//         RefreshIndicator(
//           onRefresh: () async {
//             RepositoryProvider.of<AuthRepository>(context).favorites().then(
//               (value) {
//                 setState(() {
//                   fav = value;
//                 });
//               },
//             );
//           },
//           child: NewPopulatedAgendaDayListContent(
//             agenda: widget.isAgenda,
//             compact: compact,
//             layoutHelper: layoutHelper,
//             snapshot: widget.isAgenda
//                 ? widget.talks.docs.first.data.dayOne!
//                 : widget.talks.docs.first.data.dayOne!.where((element) {
//                     if (fav != null) {
//                       return fav!.contains(element.id);
//                     } else {
//                       return element.id == element.id;
//                     }
//                   }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class EmptyPopulated extends StatelessWidget {
//   const EmptyPopulated({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox.expand(
//       child: ListView(
//         physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Image.asset('assets/404.png'),
//           ),
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Text(
//                 'Seems like we have a connection problem. Try to restart the app.',
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
