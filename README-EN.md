# 🐧 i3 Dracula Config

This repo was made to store **my i3 configs** and some programs I use, all with a **Dracula theme**. The idea is to have my dotfiles at hand. It was created for a system running Pulseaudio and Artix Linux. So, if you clone this repo, make sure to adapt the configuration to the distro you’re currently using.

There are some things that could be improved or added, like setting up a lock system to require a password when the system goes into suspend.

---

## 📂 Structure

```
exact_dot_config/
├── exact_i3        # i3 WM Config
├── exact_kitty     # Kitty Config
├── exact_picom     # Picom Config
├── exact_polybar   # Polybar Config
└── exact_rofi      # Rofi Config
```

---

## 🚀 Quick Installation

1. Clone the repo:
   ```bash
   git clone https://github.com/Franchi-21/i3-dracula-config.git
   ```

2. Copy whatever you want into your `~/.config/` directory, and make sure the necessary config folders exist.

3. Restart i3 (`Win+shift+q`) and you’re all set.

---

## Required dependencies
- Kitty  
- Polybar  
- Picom  
- Rofi  
- i3, i3-lock  
- nm-applet → NetworkManager applet  
- feh  
- ttf-font-awesome  
- ttf-jetbrains-mono-nerd  
- curl, html → Tools to scrape data from Arch and Artix news pages  
- gnome-polkit → For password prompts when something requires root  

---

## 📜 License

GPL v2. Use it, modify it, share it.  
