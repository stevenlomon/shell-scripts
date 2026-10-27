After a grueling 4-hour marathon debugging the mt7921e Wi-Fi module on my ASUS Zenbook running Pop!\_OS, I packaged my recovery routines into standalone tools. Can be run directly as scripts or sourced in `~/.bashrc` through (using `syshealth.sh` for this example):
1. Open and edit the bash scripts config file in editor of choice: `stevenlomon@steven-pop-os:~$ vim ~/.bashrc`
2. Insert a clean wrapper function pointing to the absolute path:
    ```bash
    syshealth() {
        /home/stevenlomon/fullstack/shell-scripts/syshealth.sh "$@"
    }
    ```
    `"$@"` makes it possible for us to append flags like `--verbose` (a future upgrade is to make `syshealth.sh` parameter aware and act dynamically!)
3. Save it and source it: `stevenlomon@steven-pop-os:~$ source ~/.bashrc`

Unexpected behavior like this after a sudo apt upgrade is _by far_ the worst thing about running Linux on a Windows laptop haha :') But when you're back in control of a machine free of Windows bloat, the feeling truly is priceless. And this gives me newfound appreciation and makes me excited to experiment more with shell scripts! 🌱
