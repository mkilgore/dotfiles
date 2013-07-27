#!/usr/bin/python2
#
# This script prunes events in the default Google Calendar calendar by printing
# them to output in Remind format and deleting them immediately. This is used
# for syncing from Google Calendar to Remind.
#
# Only Title and Location are supported. No recurring events are supported. This
# is meant to be a simple prune script for quick events added from mobile
# devices. This works best when used in combination with rem2ics, in which case
# ~/.reminders is transformed to an ics file, uploaded to a publicly accessible
# location automatically, and tracked by Google Calendar.
#
# Usage: Create ~/.prune_gcal and in the first line put your email (e.g.
# myem...@gmail.com) and in the second line put your password. Run this script
# as a cron job:
#     */15 * * * * prune_gcal.py >> ~/.reminders 2>/dev/null
# (this prunes the default calendar every 15 minutes)

try:
    from xml.etree import ElementTree # for Python 2.5 users
except ImportError:
    from elementtree import ElementTree
import gdata.calendar.service
import gdata.calendar
import datetime
import codecs
import os

def read_settings():
    config_path = '%s/.prune_gcal' % os.environ['HOME']
    f = codecs.open(config_path, 'r', 'utf8')
    settingsfile = f.read()
    settings = settingsfile.split('\n');
    f.close()

    # Return only the first 2 elements/lines.
    # Some editors (e.g. Vim) always have a terminating empty line.
    return settings[:2]

def prune_default_cal_events(calendar_service):
    feed = calendar_service.GetCalendarEventFeed()
    for event in feed.entry:
        msg_field = event.title.text
        where = event.where[0].value_string
        if where:
            msg_field += ' @ %s' % where
        start_time = event.when[0].start_time[:19]
        if len(start_time) > 10:
            # non full day event
            time = datetime.datetime.strptime(start_time, '%Y-%m-%dT%H:%M:%S')
            end_time = event.when[0].end_time[:19]
            duration = datetime.datetime.strptime(end_time, '%Y-%m-%dT%H:%M:%S') - time
            
            time_field = time.strftime('%b %d %Y AT %H:%M')
            if duration:
                time_field += ' DURATION %02d:%02d' % (duration.seconds / 3600,
                                                       (duration.seconds % 3600) / 60)
        else:
            # full day event
            day = datetime.datetime.strptime(start_time, '%Y-%m-%d')
            time_field = day.strftime('%b %d %Y')
        print 'REM %s MSG %s' % (time_field, msg_field)
        calendar_service.DeleteEvent(event.GetEditLink().href)

if __name__ == '__main__':
    user, password = read_settings()

    calendar_service = gdata.calendar.service.CalendarService()
    calendar_service.email = user
    calendar_service.password = password
    calendar_service.source = 'Prune Script'
    calendar_service.ProgrammaticLogin()

    prune_default_cal_events(calendar_service)
