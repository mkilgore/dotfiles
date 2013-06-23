#!/usr/bin/env python2
from __future__ import print_function
import sys

import dbus


verbose = False

#bjjus = dbus.SystemBus()
#networkManager = bus.get_object('org.freedesktop.NetworkManager', '/org/freedesktop/NetworkManager/Devices/eth0')

bus = dbus.SessionBus()

target = None
dbusObj = bus.get_object('org.freedesktop.DBus', '/')
for name in dbusObj.ListNames(dbus_interface='org.freedesktop.DBus'):
    if name.startswith('org.mpris.MediaPlayer2.'):
        target = name
        break

if target is None:
    print("Couldn't find MPRIS2-compatible media player!")
    sys.exit(1)

targetObject = bus.get_object(target, '/org/mpris/MediaPlayer2')
mpris = dbus.Interface(targetObject, dbus_interface='org.mpris.MediaPlayer2.Player')
properties = dbus.Interface(targetObject, dbus_interface='org.freedesktop.DBus.Properties')

#playerName = properties.Get('org.mpris.MediaPlayer2', 'Identity')
#print("pymprisr controlling:", playerName)

cmd = None
if len(sys.argv) > 1:
    cmd = sys.argv[1]

if cmd == 'play':
    mpris.Play()

elif cmd == 'pause':
    mpris.Pause()

elif cmd == "playpause":
    mpris.PlayPause()

elif cmd == 'stop':
    mpris.Stop()

elif cmd == 'next':
    mpris.Next()

elif cmd == 'previous':
    mpris.Previous()

props = properties.GetAll('org.mpris.MediaPlayer2.Player')

if 'xesam:tile' in props['Metadata']:
    props['Metadata']['xesam:title'] = props['Metadata']['xesam:tile']

props = dict(**props)
Metadata = props['Metadata']

# XXX: HACK to work around inconsistency between deadbeef and MPD!
try:
    Metadata = Metadata[0]
except:
    pass

props['Metadata'] = dict(
        (k
            .replace('xesam:tile', 'xesam:title')  # XXX: HACK to work around typo in deadbeef's MPRIS plugin!
            .replace(':', '.'),
            v)
        for k, v in Metadata.iteritems())

if verbose:
    for key, val in props.iteritems():
        print(key, '=', val)

#FIXME: Doing artist[0] gets the first letter of the artist on deadbeef, but is necessary to pull the artist out of the
# list of artists when using MPD. Isn't there a spec for MPRIS2 that they should both be following?
statusFormats = [
        '''
{PlaybackStatus}: {Metadata[xesam.title]}
by {Metadata[xesam.artist][0]}, from {Metadata[xesam.album]}
Loop: {LoopStatus}; Shuffle: {Shuffle}
''',
        '''
{PlaybackStatus}: {Metadata[xesam.title]}
by {Metadata[xesam.artist]}, from {Metadata[xesam.album]}
Loop: {LoopStatus}; Shuffle: {Shuffle}
''',
        '''
{PlaybackStatus}: {Metadata[xesam.title]}
by {Metadata[xesam.artist][0]}
Loop: {LoopStatus}; Shuffle: {Shuffle}
''',
        '''
{PlaybackStatus}: {Metadata[xesam.title]}
by {Metadata[xesam.artist]}
Loop: {LoopStatus}; Shuffle: {Shuffle}
''',
        '''
{PlaybackStatus}: {Metadata[xesam.title]}
from {Metadata[xesam.album]}
Loop: {LoopStatus}; Shuffle: {Shuffle}
''',
        '''
{PlaybackStatus}: {Metadata[xesam.title]}
Loop: {LoopStatus}; Shuffle: {Shuffle}
''',
        '''
{PlaybackStatus}.
Loop: {LoopStatus}; Shuffle: {Shuffle}
'''
        ]

for fmt in statusFormats:
    try:
        print(fmt.strip().format(**props))
        break
    except (KeyError, TypeError, ValueError):
        pass
#<property type="s" name="PlaybackStatus" access="read">
#<property type="s" name="LoopStatus" access="readwrite">
#<property type="d" name="Rate" access="readwrite">
#<property type="b" name="Shuffle" access="readwrite">
#<property type="a{sv}" name="Metadata" access="read">
#<property type="d" name="Volume" access="readwrite">
#<property type="x" name="Position" access="read">
#<property type="d" name="MinimumRate" access="read">
#<property type="d" name="MaximumRate" access="read">
#<property type="b" name="CanGoNext" access="read">
#<property type="b" name="CanGoPrevious" access="read">
#<property type="b" name="CanPlay" access="read">
#<property type="b" name="CanPause" access="read">
#<property type="b" name="CanSeek" access="read">
#<property type="b" name="CanControl" access="read">
