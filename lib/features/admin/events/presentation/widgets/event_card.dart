import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/core/services/launcher_services.dart';
import 'package:tasti_restaurant_app/core/widgets/image_widget.dart';
import 'package:tasti_restaurant_app/features/admin/events/domain/entities/event.dart';
import 'package:url_launcher/url_launcher.dart';

class EventCard extends StatelessWidget {
  final EventItem event;

  const EventCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageWidget(
              imageUrl: event.eventImage,
              boxFit: BoxFit.cover,
              heightPercent: .2,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.eventTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  if (event.eventLink.isNotEmpty)
                    GestureDetector(
                      onTap: (){
                        UrlLauncherService().openWebsite(event.eventLink, launchMode: LaunchMode.inAppBrowserView);
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.link,
                              size: 16, color: Colors.blueGrey),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              event.eventLink,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
