import 'package:conferenceapp/agenda/widgets/talk_card.dart';
import 'package:conferenceapp/common/conference_info.dart';
import 'package:conferenceapp/common/europe_text_field.dart';
import 'package:conferenceapp/generated/l10n.dart';
import 'package:conferenceapp/model/ticket.dart';
import 'package:conferenceapp/model/user.dart';
import 'package:conferenceapp/profile/user_repository.dart';
import 'package:conferenceapp/ticket/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import 'widgets/add_ticket_email_info.dart';
import 'widgets/qr_image.dart';
import 'widgets/save_ticket_button.dart';
import 'widgets/scan_your_ticket_placeholder.dart';
import 'widgets/ticket_clipper.dart';
import 'widgets/ticket_page_title.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({Key? key}) : super(key: key);

  @override
  TicketPageState createState() => TicketPageState();
}

class TicketPageState extends State<TicketPage> {
  late TextEditingController orderController;
  late TextEditingController emailController;
  late TextEditingController ticketController;
  late TextEditingController personalEmailController;
  late FocusNode orderNode;
  late FocusNode emailNode;
  late FocusNode ticketNode;
  late FocusNode personalEmailNode;

  bool verifyByOrderNumber = false;
  bool verifyByTicketNumber = false;
  bool formValid = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    orderController = TextEditingController();
    orderNode = FocusNode();
    emailController = TextEditingController();
    emailNode = FocusNode();
    ticketController = TextEditingController();
    ticketNode = FocusNode();
    personalEmailController = TextEditingController();
    personalEmailNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketBloc, TicketState>(
      builder: (context, state) => Scaffold(
        body: Form(
          key: _formKey,
          child: TicketPageWrapper(
            children: <Widget>[
              Container(
                color: Theme.of(context).primaryColor,
                child: const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: TicketPageTitle(),
                ),
              ),
              if (state is TicketAddedState)
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 800),
                  crossFadeState: state is TicketValidatedState
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          S.current.showQr,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  secondChild: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          S.current.ticetValidated,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              if (state is TicketAddedState)
                QrCode(
                  ticketData: state.ticket,
                  validated: state is TicketValidatedState,
                )
              else
                NoQrCode(onTap: () {}),
              if (state is! TicketAddedState)
                ToggleButtons(
                  isSelected: [verifyByOrderNumber, verifyByTicketNumber],
                  onPressed: (index) {
                    setState(() {
                      if (index == 0) {
                        verifyByOrderNumber = true;
                        verifyByTicketNumber = false;
                      } else {
                        verifyByOrderNumber = false;
                        verifyByTicketNumber = true;
                      }
                      orderController.clear();
                      ticketController.clear();
                    });
                  },
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(S.current.orderNumber),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(S.current.ticketNumber),
                    )
                  ],
                ),
              if (verifyByOrderNumber && state is! TicketAddedState)
                EuropeTextFormField(
                  hint: S.current.hintOrderNumber,
                  onFieldSubmitted: onSubmit,
                  onChanged: validate,
                  maxLength: 9,
                  controller: orderController,
                  focusNode: orderNode,
                  keyboardType: TextInputType.visiblePassword,
                  textCapitalization: TextCapitalization.characters,
                  additionalValidator: (value) {
                    if (!value!.startsWith('OT') && !value.startsWith('ot')) {
                      return S.current.orderNumberValidation;
                    }
                    return null;
                  },
                ),
              if (verifyByTicketNumber && state is! TicketAddedState)
                EuropeTextFormField(
                  hint: S.current.ticketNumberHint,
                  onFieldSubmitted: onSubmit,
                  onChanged: validate,
                  maxLength: 20,
                  controller: ticketController,
                  focusNode: ticketNode,
                  keyboardType: TextInputType.visiblePassword,
                  textCapitalization: TextCapitalization.characters,
                ),
              // EuropeTextFormField(
              //   hint: 'E-mail connected with order',
              //   onFieldSubmitted: nextNode,
              //   controller: emailController,
              //   focusNode: emailNode,
              //   keyboardType: TextInputType.emailAddress,
              // ),
              // EuropeTextFormField(
              //   hint: 'Your e-mail (not needed if different than order e-mail)',
              //   onFieldSubmitted: nextNode,
              //   controller: personalEmailController,
              //   focusNode: personalEmailNode,
              //   keyboardType: TextInputType.emailAddress,
              // ),
              if (state is TicketErrorState) Text(S.current.weHaveProblem),
              if (state is! TicketAddedState)
                SaveTicketButton(
                  enabled: formValid,
                  onSave: onSave,
                ),
              if (state is! TicketAddedState) const AddTicketEmailInfo(),

              if (state is TicketAddedState && state.ticket.orderId.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    '${S.current.orderNumber}: ${state.ticket.orderId}',
                    textAlign: TextAlign.center,
                  ),
                ),
              if (state is TicketAddedState && state.ticket.ticketId.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    '${S.current.ticketNumber}: ${state.ticket.ticketId}',
                    textAlign: TextAlign.center,
                  ),
                ),

              if (state is TicketAddedState) const ConferenceInfo(),
              if (state is TicketAddedState && state is! TicketValidatedState)
                TextButton(
                  style: TextButton.styleFrom(
                      textStyle: const TextStyle(color: Colors.red)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(S.current.removeTicket),
                      const Icon(LineIcons.trash)
                    ],
                  ),
                  onPressed: () {
                    BlocProvider.of<TicketBloc>(context).add(RemoveTicket());
                  },
                ),
              Container(
                color: Theme.of(context).primaryColor,
                height: 50,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    emailNode.dispose();
    orderController.dispose();
    orderNode.dispose();
    personalEmailController.dispose();
    personalEmailNode.dispose();
    ticketController.dispose();
    ticketNode.dispose();
    super.dispose();
  }

  void onOrderSubmitted(String value) {
    FocusScope.of(context).requestFocus(emailNode);
  }

  void onSave() {
    final ticket = Ticket(
        orderController.value.text.toUpperCase(), ticketController.value.text);
    BlocProvider.of<TicketBloc>(context).add(SaveTicket(ticket));
  }

  void onSubmit(String value) {
    FocusScope.of(context).requestFocus(FocusNode());
    validate(value);
  }

  void validate(String value) {
    final valid = _formKey.currentState!.validate();
    setState(() {
      formValid = valid;
    });
  }
}

class NoQrCode extends StatelessWidget {
  const NoQrCode({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 40.0,
        ),
        child: ScanYourTicketPlaceholder(),
      ),
    );
  }
}

class QrCode extends StatelessWidget {
  const QrCode({
    Key? key,
    required this.ticketData,
    this.validated = false,
  }) : super(key: key);

  final Ticket ticketData;
  final bool validated;

  @override
  Widget build(BuildContext context) {
    final userRepo = RepositoryProvider.of<UserRepository>(context);
    return StreamBuilder<User>(
        stream: userRepo.user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data;
            final orderId =
                ticketData.orderId.isNotEmpty ? ticketData.orderId : '_';
            final ticketId =
                ticketData.ticketId.isNotEmpty ? ticketData.ticketId : '_';
            final qrData = '${user!.userId} $orderId $ticketId';
            return Container(
              height: 260,
              width: 260,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: QrImage(
                  data: qrData,
                  embeddedImage: validated
                      ? const AssetImage('assets/checked.png')
                      : const AssetImage(''),
                  imageSize: const Size(100, 100),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}

class TicketPageWrapper extends StatelessWidget {
  const TicketPageWrapper({Key? key, required this.children}) : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    const imageHeight = 48.0;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: imageHeight,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              iconTheme: Theme.of(context).iconTheme,
              centerTitle: true,
              title: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Theme.of(context).brightness == Brightness.light
                    ? Image.asset(
                        'assets/flutter_europe.png',
                        height: imageHeight,
                        key: const ValueKey('logo_image_1'),
                      )
                    : Image.asset(
                        'assets/flutter_europe_dark.png',
                        height: imageHeight,
                        key: const ValueKey('logo_image_2'),
                      ),
              ),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ClipPath(
                  clipper: TicketClipper(true, true),
                  child: TalkCardDecoration(
                    child: Column(
                      children: children,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
