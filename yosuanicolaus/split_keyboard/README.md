# Step by step on how to reconfigure the keybindings

- Go to https://config.qmk.fm/#/crkbd/
- Upload the latest keymap file (in `.json`) in this folder
- Configure the keybindings there
- Rename the date in the name
- Download the new keymap file
- Download the new hex file (click "Compile", then "Firmware" button)
- (optional) Print the keymap as pdf and save it here for reference
- In terminal, navigate to this folder, then run:

(replace "251231" with the new date)

```bash
qmk flash -kb crkbd/r2g -km mb_via ./crkbd_r2g_yosuanicolaus_keymap_251231.hex
```

- when prompted to "reset to bootloader", look for a pencil or something,
    and click (& hold for a few seconds) the tiny black button by the display on the left keyboard.

---

# Changelog

- [251231] add `_` & `+` for zoom out/in in excalidraw.
