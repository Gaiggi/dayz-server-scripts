# dayz-server-scripts
This is a start and update script for modded DayZ-Server for Linux.
Thers is also a Systemd Service included

Installation: 
Just add the start.sh and update.sh to you DayZ-Server root.
Update the Mods included.

Copy the .service file to /etc/systemd/system

Then just run 
"sudo systemctl enable dayz-server.service"
"sudo systemctl start dayz-server.service"

Dont forget to forward Port 2301-2305 and 27016 UDP 
