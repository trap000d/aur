## Notes on upgrade for Arch Linux
Assime Seafile is installed in /srv/seafile

TL:DR;
Stop all seafile/seahub processes
Backup /srv/seafile/seafile-server

as `seafile` user
cp -r /usr/share/seafile-server /srv/seafile/seafile-server
Patch
Run 'seafile-server/upgrade/minor_upgrade.sh'


* Server directory must be named 'seafile-server', otherwise Django couldn't find local files (seems it's hardcoded somewhere deep inside)


## More details
For seahub.sh:
They assume there is only one user who can run gunicorn on the computer. So are trying to kill all gunicorn instances (including other users) on exit.
They don't export variables from .env (assume seafile server is running in Docker?).
They don't run notification server

### For patching.

Right after installation:
patch -p3 < 0001_final_touch_new.diff
diff -ru /usr/share/seafile-server/ /srv/seafile/seafile-server/ | grep -v '^Only in' > 0001_final_touch_new.diff

### For systemd stuff

Enable and start:
seafile-notification.service
seafile.service
seahub.service

Optionally enable and start:
seafile-gc-cron.timer - run garbage collector once a week
