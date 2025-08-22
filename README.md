# 🐧 i3 Dracula Config

Este repo lo armé para guardar **mis configs de i3** y algunos programas que uso, todo con estilo **Dracula**.  La idea es tener mis dotfiles a mano. Fue creado para un sistema que usa Pulseaudio y Aritx Linux. Asi que, si clonás este repo, asegurate de adaptar esta configuración a la distro que actualmente estes usando.

Hay algunas cosas que se podrian arreglar y agregar, como agregarle un sistema de bloqueo para que te pida contraseña cuando se ponga en suspensión

---

## 📂 Estructura

```
dotfiles/
├── dunst
├── fastfetch
├── i3        # Config de i3 WM
├── kitty     # Config de Kitty
├── picom     # Config de Picom
├── polybar   # Config de Polybar
├── rofi      # Config de Rofi
└── gtk-3.0         # Configuracion para las ventanas (Asegurate de tener el tema de Dracula instalado, en mi caso uso el de xfce. Lo podés conseguir aca: https://www.xfce-look.org/p/1687249/
```

---

## 🚀 Instalación rápida

1. Cloná el repo:
   ```bash
   git clone https://github.com/Franchi-21/i3-dracula-config.git
   ```

2. Copiá lo que quieras a tu directorio `~/.config/`, asegurate de haber creado las carpetas de configuración necesarias.

3. Reiniciá i3 (`Win+shift+q`) y ya está todo preparado para vos.

---

## Dependencias necesarias
- Kitty
- Polybar
- Picom
- Rofi
- xclip
- xset
- Btop
- Maim, Satty --> Para sacar capturas y para visualizar imágenes
- i3, i3-lock
- nm-applet --> NetworkManager applet
- feh
- ttf-font-awesome
- ttf-jetbrains-mono-nerd
- curl, html --> Herramientas para scrappear datos de las paginas de noticias de Arch y Artix
- gnome-polkit - Para que te pida contraseña cuando querés algo que necesita root

## 📜 Licencia

GPL v2. Usalo, modificalo, compartilo.  
