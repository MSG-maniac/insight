#!/bin/sh

#wait 20 sec for mysql ready
sleep 20

#start 
supervisord -c srcpm/supervisor.conf 
supervisorctl -c srcpm/supervisor.conf start all 
tail -f srcpm/log/gunicorn.err 
tail -f srcpm/log/mail_sender.err 