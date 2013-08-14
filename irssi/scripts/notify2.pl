use strict;
#use warnings; ## debug - $timer is undef when the script is loaded

use Irssi;
use POSIX qw/strftime/;

our $VERSION = '2.10';
our %IRSSI = (
    author      =>  'colR',
    name        =>  'notifyme.pl',
    description =>  'Use /set notify_delay to the number of seconds before'
                .   'you wish to be notified when someone mentions your nick'
                .   'in a public message or sends you a PM.'
                .   'Set it to 0, or use /set -clear, to cancel notifications.'
                .   'Use /set notify_log to the location you want notifiable'
                .   'messages logged to. If the file exists new messages will'
                .   'be appended, otherwise it will be created.'
                .   'Use /set notify_log none to switch off logging.'
                .   'Defaults to ~/.irssi/notify.log',
    depends     =>  'notify-send, from package libnotify-bin',
    license     =>  'None. Use it at your own risk.',
    changelog   =>  '2.01: added sub sanitise_msg, tweaked system calls.'
                .   '2.02: fixed sanitising of messages'
                .   '2.10: added logging of notifications.',
);

my $timer;
my $notify_flag;

Irssi::settings_add_int('misc', 'notify_delay', undef);
Irssi::settings_add_str('misc', 'notify_log', '~/.irssi/notify.log');
Irssi::signal_add('message public', 'sig_message_public');
Irssi::signal_add('message private', 'sig_message_private');
Irssi::signal_add_last('gui key pressed', 'reset_timer');

Irssi::print("--> Logging notifications to '" . 
    Irssi::settings_get_str("notify_log") . "'");

sub sig_message_public {
    my ($server, $msg, $nick, $nick_addr, $target) = @_;
    if ($msg =~ m/$server->{nick}/ && $notify_flag) {
        write_log($server, $msg, $nick, $target);
        $msg = sanitise_msg($msg);
        system("notify-send \"" . $nick . "\" \"" . $msg . "\"");
    }
}

sub sig_message_private {
    my ($server, $msg, $nick, $nick_addr) = @_;
    if ($notify_flag) {
        write_log($server, $msg, $nick);
        $msg = sanitise_msg($msg);
        system("notify-send \"PM: " . $nick . "\" \"" . $msg . "\"");
    }
}

sub write_log {
    my ($server, $msg, $nick, $target) = @_;
    $target ||= '<PM>';
    my ($logfile) = glob Irssi::settings_get_str('notify_log');
    my $logmsg = '[' . strftime("%D %H:%M", localtime()) . 
        "] $server->{'tag'} $target $nick $msg";
    if (open(LF, ">>$logfile")) {
        print LF "$logmsg\n";
        close LF;
    } else {
        Irssi::print($logmsg);
    }
}
    
sub notifier{
    $notify_flag = 1;
}

sub reset_timer{
    my $key=shift;
    if($key == 10){
        $notify_flag = 0;
        Irssi::timeout_remove($timer); 
        my $timeout = Irssi::settings_get_int('notify_delay');
        if ($timeout){
            $timer = Irssi::timeout_add_once($timeout*1000, 'notifier', undef);
        }
    }
}

sub sanitise_msg{
    my ($msg) = @_;
    $msg =~ s/\\/\\\\/g;
    $msg =~ s/'/'\\''/g;
    return $msg;
}
