import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/logic/bloc/pass/pass_bloc.dart';

Future<bool> showConfirmationDailog({
  required BuildContext context,
  required String title,
  required String content,
  required Function() yesAction,
}) async {
  return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: yesAction,
              child: const Text('Yes'),
            ),
          ],
        ),
      ) ??
      false; //if showDialouge had returned null, then return false
}

exitAppConfirmation(BuildContext context) {
  return showConfirmationDailog(
    context: context,
    title: 'Exit App',
    content: 'Do you want to exit the App?',
    yesAction: () => SystemNavigator.pop(),
  );
}

void deleteTitleConfirmation({
  required BuildContext context,
  required String title,
}) {
  showConfirmationDailog(
    context: context,
    title: 'Delete $title',
    content: 'It will delete all the passwords saved under this title.',
    yesAction: () {
      Navigator.pop(context);
      context.read<PassBloc>().add(SuperPassDeleteEvent(
            title: title,
          ));
      Navigator.pop(context);
    },
  );
}

void deleteUsernameConfirmation({
  required BuildContext context,
  required String title,
  required String username,
}) {
  showConfirmationDailog(
    context: context,
    title: 'Delete $username',
    content: 'It will $username from $title.',
    yesAction: () {
      Navigator.pop(context);
      context.read<PassBloc>().add(PassDeleteEvent(
            title: title,
            username: username,
          ));
      Navigator.pop(context);
    },
  );
}
