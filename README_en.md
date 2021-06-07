# nof
Personal script to create backup

___

[🇪🇸 Cambiar a Español](README.md)

**Have you ever made a mistake with the data inside a disk and got "F" from your friends?** Well, I have, and that's why I decided to create this script. Now I can scream "NO MORE F" in their face. Or so I hope.

For the moment this script satisfies only my personal demands. With time I may improve it, but I make no promises.

The `setup.sh` script allows to install or uninstall `nof`, with its respective options (see help with `setup.sh --help`). Also, it configures a service and a timer with systemd to run automagically once a week.

**What does it do (at least for the moment)?** Well, it simply consists of a timer that will fire once a week. When this happens, it triggers a service that takes care of running the `nof` script. This script creates a backup (type 0) with the `tar` tool and stores it in a hidden directory, inside the user's home. If the option is enabled, you can also send it via SSH (using `scp`) to a remote directory. In my case, I use it to have a copy of the backups on a disk connected to my Raspberry Pi. Logically, SSH must be configured properly so that the script does not have to fill in the login fields. Finally, it also takes care of rotating the backups so that our machine does not fill up with old backups. It can be configured within the script, but by default it always keeps the 5 newest backups.

Future plans? I want to make it even more generic and add a few options, such as cloud storage and the option to generate incremental backups, but that demands a lot of time that I don't have at the moment. However, any ideas, suggestions or revisions are more than welcome.
