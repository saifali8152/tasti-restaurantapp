import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/config/routes/route_name.dart';
import 'package:tasti_restaurant_app/core/services/launcher_services.dart';
import 'package:tasti_restaurant_app/core/utils/general_extentions.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_button.dart';
import 'package:tasti_restaurant_app/core/widgets/image_widget.dart';
import 'package:tasti_restaurant_app/features/admin/events/domain/entities/event.dart';
import 'package:tasti_restaurant_app/features/admin/events/presentation/widgets/delete_event_dialog.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: ImageWidget(
              imageUrl: event.eventImage,
              boxFit: BoxFit.cover,
              heightPercent: 0.25,
            ),
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
                    onTap: () {
                      UrlLauncherService().openWebsite(event.eventLink,
                          launchMode: LaunchMode.inAppBrowserView);
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
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.updateEvent,
                            arguments: event);
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: const Icon(Icons.edit, size: 18),
                      label: const Text("Update"),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          context.showCustomDialog(
                            DeleteEventDialog(
                              id: event.eventId.toString(),
                            ),
                          );
                        },
                        text: "Delete",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
