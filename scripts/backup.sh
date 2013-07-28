#!/bin/bash
START=$(date +%s)
echo "Backing up system to /mnt/backup/..."
echo "/boot"
rsync --progress -aAXv /boot/* /mnt/backup/boot/
echo "/"
rsync --progress -aAXv /* /mnt/backup/arch/ --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found,/home/*/.gvfs}
echo "/mnt/data"
rsync --progress -aAXv /mnt/data/* /mnt/backup/data/
SH=$(date +%s)
echo "total time: $(( ($FINISH-$START) / 60 )) minutes, $(( ($FINISH-$START) % 60 )) seconds"

touch /mnt/backup/data/"Backup from $(date '+%A, %d %B %Y, %T')"
