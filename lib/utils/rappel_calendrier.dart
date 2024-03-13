import 'package:device_calendar/device_calendar.dart';
import 'package:timezone/timezone.dart' as tz;

class CalendarService {
  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();

  Future<bool> requestPermissions() async {
    final result = await _deviceCalendarPlugin.requestPermissions();
    return result.isSuccess && result.data == true;
  }

  Future<bool> addReminder({
    required String title,
    required DateTime start,
    Duration duration = const Duration(hours: 1),
  }) async {
    final permissionsGranted = await requestPermissions();
    if (!permissionsGranted) {
      return false;
    }

    final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
    final calendars = calendarsResult.data;
    if (calendars == null || calendars.isEmpty) {
      return false;
    }

    Calendar? targetCalendar;
    for (var calendar in calendars) {
      if (calendar.isReadOnly == false) {
        targetCalendar = calendar;
        break;
      }
    }

    if (targetCalendar == null) {
      return false;
    }

    final Event event = Event(
      targetCalendar.id,
      title: title,
      start: tz.TZDateTime.from(start, tz.local),
      end: tz.TZDateTime.from(start.add(duration), tz.local),
    );

    final createEventResult = await _deviceCalendarPlugin.createOrUpdateEvent(event);
    return createEventResult!.isSuccess;
  }
}
