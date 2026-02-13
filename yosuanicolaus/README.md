# config

All my configs for setting up Linux Mint laptop

All other heavy folders are copied via harddisk instead of pushing them here

installed apps from new laptop (to be rewritten): Geary, Joplin, RustDesk,
Discord, ONLYOFFICE desktop edition, Whatsdesk (whatsapp desktop) OBS Studio,
Google Chrome, Remmina, VLC, DeepL, XMind

The name and location for each real file from here can be traced from the 
`file_counterpart_locations` in `update.py`

### About Keymapping

There's 2 important softwares that are working together:

- Linux Mint default Shortcut app (from "Keyboard")
- Input Remapper

---

<!-- TODO: what is this? let's remove it later (from startup.md) -->

List of all commands used in Startup Applications

- CapsLock as Escape on short press

```
xcape -e 'Control_L=Escape'
```

- kitty

```
kitty
```

- Microsoft Edge

```
/usr/bin/microsoft-edge-stable %U
```

- xbindkeys

```
xbindkeys_autostart
```

---

### [260213] For config files in home (`~`)

Run these if they already exist (removes them)

```rm ~/.zshrc```

```rm ~/.xbindkeysrc```

```rm ~/.Xmodmap```

```rm ~/.ideavimrc```


