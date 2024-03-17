import 'package:device_calendar/device_calendar.dart';
import 'package:timezone/timezone.dart' as tz;

class CalendarService {
  static final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();

  static Future<bool> requestPermissions() async {
    final resultat = await _deviceCalendarPlugin.requestPermissions();
    return resultat.isSuccess && resultat.data == true;
  }

  static Future<String?> addReminder({
    required String title,
    required DateTime start,
    Duration duration = const Duration(hours: 1),
  }) async {
    final permissionsGranted = await requestPermissions();
    if (!permissionsGranted) {
      return "Accès au calendrier refusé.";
    }

    final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
    final calendars = calendarsResult.data;
    if (calendars == null || calendars.isEmpty) {
      return "Calendrier non trouvé.";
    }

    Calendar? targetCalendar;
    for (var calendar in calendars) {
      if (calendar.isReadOnly == false) {
        targetCalendar = calendar;
        break;
      }
    }

    if (targetCalendar == null) {
      return "Calendrier non trouvé.";
    }

    final Event event = Event(
      targetCalendar.id,
      title: title,
      start: tz.TZDateTime.from(start, tz.local),
      end: tz.TZDateTime.from(start.add(duration), tz.local),
    );

    final createEventResult = await _deviceCalendarPlugin.createOrUpdateEvent(event);
    if (createEventResult?.isSuccess == true) {
      return "Rappel ajouté avec succès.";
    } else {
      return "Erreur lors de l'ajout du rappel.";
    }
  }
}
