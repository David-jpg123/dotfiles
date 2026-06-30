
-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    -- Propaga variables a systemd/D-Bus y arranca la sesión gráfica
    -- (necesario para xdg-desktop-portal -> screen share de Discord)
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE DISPLAY HYPRLAND_INSTANCE_SIGNATURE")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE DISPLAY HYPRLAND_INSTANCE_SIGNATURE")
    hl.exec_cmd("systemctl --user start hyprland-session.target")

    hl.exec_cmd("/usr/lib/polkit-kde-authentification-agent-1")
    hl.exec_cmd("swaync")
    hl.exec_cmd("awww-daemon")
    -- hl.exec_cmd("~/.config/hypr/awww.sh")
    hl.exec_cmd("waybar")
    hl.exec_cmd("pipewire-pulse")
    hl.exec_cmd("sudo mount -t ntfs-3g /dev/nvme0n1p3 /mnt/windows")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
    hl.exec_cmd("/home/david/music-discord-rpc/target/release/music-discord-rpc")
end)


---------------------
---- MY PROGRAMS ----
---------------------

local mainMod     = "SUPER"
local terminal    = "kitty"
local fileManager = "kitty -e yazi"
local menu        = 'rofi -show drun -modes "drun,run,window,ssh"'
local browser     = "brave"


-----------------------
---- LOOK AND FEEL ----
-----------------------

local mi_tema = require("current_theme")

hl.config({
    general = mi_tema.general,
    decoration = mi_tema.decoration,
    animations = {
        enabled = true,
    },
})

-- Animaciones
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })

-- Diseños (Layouts)
hl.config({
    dwindle = {
        preserve_split = true,
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})

-- Miscelánea
hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout = "es",
    },
})


---------------------
---- KEYBINDINGS ----
---------------------

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("brave"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("bash ~/.config/hypr/awww.sh"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("bash ~/.config/hypr/theme_menu.sh"))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("brave --ozone-platform-hint=auto --app=https://music.youtube.com &> /dev/null &"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("pavucontrol"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("discord"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("kitty -e cava"))

-- Capturas de pantalla
hl.bind("Print",                       hl.dsp.exec_cmd([[grim ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png]]))
hl.bind(mainMod .. " + Print",         hl.dsp.exec_cmd([[grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png]]))
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy]]))
hl.bind(mainMod .. " + F9",            hl.dsp.exec_cmd("~/.config/hypr/scripts/grabacion_pantalla.sh"))
hl.bind(mainMod .. " + F10",           hl.dsp.exec_cmd("killall -s SIGINT wf-recorder"))

-- Mover ventana en una dirección
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

-- Mover/redimensionar con el ratón
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Cambiar de workspace y mover ventanas a workspace [1-9]
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/SetScreen.sh"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("systemctl poweroff"))


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    name  = "pavucontrol-float",
    match = { class = "^(org.pulseaudio.pavucontrol)$" },
    float = true,
    size  = "800 600",
    workspace = "focus"
})

hl.window_rule({
    name = "kitty-transparency",
    match = "kitty"
    
})

hl.layer_rule({
    name  = "waybar",
    match = { namespace = "waybar" },
    order = -1,
})
