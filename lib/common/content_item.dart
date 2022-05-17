import 'package:flutter/material.dart';
import 'package:natie_portfolio/global/styles.dart';
import 'package:natie_portfolio/model/project.dart';

class ProjectItem extends StatelessWidget {
  final Project p;

  const ProjectItem(this.p, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.title, style: Styles.headerStyle.copyWith(color: p.color)),
                Text(p.description),
              ],
            ),
            const Text('test'),
          ],
        ),
      ),
    );
  }

}