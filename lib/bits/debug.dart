import 'package:blosso_mindfulness/bits/telemetry.dart';
import 'package:flutter/material.dart';

Widget debug_wrapPageNumber(
        {required Color bg, required String text}) =>
    Container(
        color: bg,
        child: Center(
          child: Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w800, fontSize: 64)),
        ));

class DebuggingStuffs extends StatefulWidget {
  const DebuggingStuffs({super.key});

  @override
  State<DebuggingStuffs> createState() => _DebuggingStuffsState();
}

class _DebuggingStuffsState extends State<DebuggingStuffs> {
  static Widget _dbgButton(
      {required String text,
      required IconData icon,
      required void Function() onPressed}) {
    return TextButton.icon(
        onPressed: onPressed, icon: Icon(icon), label: Text(text));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // buttons here just for debugging certain data, dont remove the ones already here, might be troublesome
          // although the implementation is kinda tedious with repetitive code practices, but who cares
          _dbgButton(
              text: "NEW_USER",
              icon: Icons.person_add_alt_1_rounded,
              onPressed: () {
                setIsNewUser(!getIsNewUser());
                setState(() {});
              }),
          _dbgButton(
              text: "USER_NAME_EMPTY",
              icon: Icons.compress_rounded,
              onPressed: () {
                setUserName("");
                setState(() {});
              }),
          _dbgButton(
              text: "RESET_LAST_ENTRY_TIME",
              icon: Icons.calendar_month_rounded,
              onPressed: () {
                setLastEntryTime(
                    DateTime.fromMillisecondsSinceEpoch(0));
                setState(() {});
              }),
          _dbgButton(
              text: "RESET_ALL",
              icon: Icons.restore_rounded,
              onPressed: () {
                invalidateEphemeral();
                setState(() {});
              }),
          _dbgButton(
              text: "SET_LAST_ENTRY_TIME_NOW",
              icon: Icons.calendar_today_rounded,
              onPressed: () {
                setLastEntryTimeAsNow();
                setState(() {});
              }),
          _dbgButton(
              text: "REFRESH_PREFS",
              icon: Icons.refresh_rounded,
              onPressed: () => setState(() {})),
          Text.rich(TextSpan(children: [
            const TextSpan(
                text: "isNewUser = ",
                style: TextStyle(fontWeight: FontWeight.w800)),
            TextSpan(
              text: "${getIsNewUser().toString()}\n",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const TextSpan(
                text: "userName = ",
                style: TextStyle(fontWeight: FontWeight.w800)),
            TextSpan(
              text: "${getUserName()}\n",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const TextSpan(
                text: "lastEntryTime = ",
                style: TextStyle(fontWeight: FontWeight.w800)),
            TextSpan(
                text: "${getLastEntryTime()}\n",
                style: const TextStyle(fontWeight: FontWeight.w600))
          ], style: const TextStyle(fontSize: 18))),
        ],
      ),
    );
  }
}
