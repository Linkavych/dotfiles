#------------------# 
#	 xinitrc	   #
#------------------# 

# Start xautolock
xautolock -time 10 -locker slock &

# Start slstatus
slstatus &

# restore background
~/.fehbg &

# Start dwm last
exec ssh-agent dbus-launch dwm
