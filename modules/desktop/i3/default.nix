{
  config,
  pkgs,
  callPackage,
  ...
}: {
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;

    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        tapping = false;
      };
    };

    desktopManager = {
      xterm.enable = false;
    };
  };

  environment.systemPackages = with pkgs; [
    i3-gaps
    i3ipc-glib
    polybarFull
    rofi
    betterlockscreen
    lightdm #change for ly when it works

    # Niceties
    picom
    feh
    pa_applet
    networkmanagerapplet

    # Sound & Image utils
    autorandr
    pavucontrol
  ];

  services.xserver = {
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      configFile = pkgs.writeText "i3.cfg" ''
        ################################################
        #                                              #
        #   Arch Linux GUI i3 WM Configuration File.   #
        #   Make a habit to read this file. You will   #
        #   find keybindings and various other         #
        #   settings here. Please see                  #
        #                                              #
        #       https://i3wm.org/docs/userguide.html   #
        #                                              #
        #   for a complete reference on moving forward #
        #   from what I have provided here.            #
        #                                              #
        ################################################



        ##################################
        #
        #	       i3 BASE
        #
        ##################################
        # This is our mod Key. Currently it is set to the Windows Key.
        # You can uncomment the line below to set 'Alt' key as the mod key.
        set $mod Mod1
        #set $mod Mod4

        # kill focused window
        bindsym $mod+Shift+q kill

        # Suspend the system to RAM (needs swap space)
        #bindsym $mod+s exec systemctl suspend

        # Use Mouse+$mod to drag floating windows to their wanted position
        floating_modifier $mod

        # The keybindings starting from here till the end of the document are
        # used for navigation in the window manager

        # 1A] change focus
        bindsym $mod+j focus left
        bindsym $mod+k focus down
        bindsym $mod+l focus up
        bindsym $mod+semicolon focus right

        # 1B] alternatively, you can use the cursor keys:
        bindsym $mod+Left focus left
        bindsym $mod+Down focus down
        bindsym $mod+Up focus up
        bindsym $mod+Right focus right

        # 2A] move focused window
        bindsym $mod+Shift+j move left
        bindsym $mod+Shift+k move down
        bindsym $mod+Shift+l move up
        bindsym $mod+Shift+semicolon move right

        # 2B] alternatively, you can use the cursor keys:
        bindsym $mod+Shift+Left move left
        bindsym $mod+Shift+Down move down
        bindsym $mod+Shift+Up move up
        bindsym $mod+Shift+Right move right

        # 3] split in horizontal orientation
        bindsym $mod+h split h

        # 4] split in vertical orientation
        bindsym $mod+v split v

        # 5] enter fullscreen mode for the focused container
        bindsym $mod+f fullscreen toggle

        # 6] change container layout (stacked, tabbed, toggle split)
        bindsym $mod+s layout stacking
        bindsym $mod+w layout tabbed
        bindsym $mod+e layout toggle split

        # 7] toggle tiling / floating
        bindsym $mod+Shift+f floating toggle

        # 8] change focus between tiling / floating windows
        bindsym $mod+space focus mode_toggle

        # 9A] focus the parent container
        bindsym $mod+a focus parent

        # 9B] focus the child container
        #bindsym $your_keybinding focus child

        # Define names for default workspaces for which we configure key bindings later on.
        # We use variables to avoid repeating the names in multiple places.
        set $ws1 "1"
        set $ws2 "2"
        set $ws3 "3"
        set $ws4 "4"
        set $ws5 "5"
        set $ws6 "6"
        set $ws7 "7"
        set $ws8 "8"
        set $ws9 "9"
        set $ws10 "10"

        # 10] switch to workspace
        bindsym $mod+1 workspace number $ws1
        bindsym $mod+2 workspace number $ws2
        bindsym $mod+3 workspace number $ws3
        bindsym $mod+4 workspace number $ws4
        bindsym $mod+5 workspace number $ws5
        bindsym $mod+6 workspace number $ws6
        bindsym $mod+7 workspace number $ws7
        bindsym $mod+8 workspace number $ws8
        bindsym $mod+9 workspace number $ws9
        bindsym $mod+0 workspace number $ws10

        # 11] move focused container to workspace
        bindsym $mod+Shift+1 move container to workspace number $ws1
        bindsym $mod+Shift+2 move container to workspace number $ws2
        bindsym $mod+Shift+3 move container to workspace number $ws3
        bindsym $mod+Shift+4 move container to workspace number $ws4
        bindsym $mod+Shift+5 move container to workspace number $ws5
        bindsym $mod+Shift+6 move container to workspace number $ws6
        bindsym $mod+Shift+7 move container to workspace number $ws7
        bindsym $mod+Shift+8 move container to workspace number $ws8
        bindsym $mod+Shift+9 move container to workspace number $ws9
        bindsym $mod+Shift+0 move container to workspace number $ws10

        # 12A] reload the configuration file
        bindsym $mod+Shift+c reload
        # 12B] restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
        bindsym $mod+Shift+r restart
        # 12C] exit i3 (logs you out of your X session)
        bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"

        # 13A] resize window (you can also use the mouse for that)
        mode "resize" {
                # These bindings trigger as soon as you enter the resize mode

                # Pressing left will shrink the window’s width.
                # Pressing right will grow the window’s width.
                # Pressing up will shrink the window’s height.
                # Pressing down will grow the window’s height.
                bindsym j resize shrink width 10 px or 10 ppt
                bindsym k resize grow height 10 px or 10 ppt
                bindsym l resize shrink height 10 px or 10 ppt
                bindsym semicolon resize grow width 10 px or 10 ppt

                # same bindings, but for the arrow keys
                bindsym Left resize shrink width 10 px or 10 ppt
                bindsym Down resize grow height 10 px or 10 ppt
                bindsym Up resize shrink height 10 px or 10 ppt
                bindsym Right resize grow width 10 px or 10 ppt

                # back to normal: Enter or Escape or $mod+r
                bindsym Return mode "default"
                bindsym Escape mode "default"
                bindsym $mod+r mode "default"
        }


        # 13B] Enter Resize Mode
        bindsym $mod+r mode "resize"


        ##################################
        #
        #	       WORKSPACE SPECIFIC
        #
        ##################################
        # Launch a program on a certain workspace, from rofi (which may or may not have a keybinding)
        # for_window [class="nameofapp"] move to workspace $wsno.
        # WS No. 5 has been used as example.
        # Note: You will have to launch the program from a program launcher (rofi).
        #for_window [class="firefox"] move to workspace $ws5

        # The following way allows programs to be launched with a
        # defined keybinding, on a certain workspace, without
        # touching program launcher. Assign Programs to respective
        # workspaces.
        #bindsym $mod+b workspace 5; exec firefox


        ##################################
        #
        #	       MEDIA KEYS
        #
        ##################################
        #PulseAudio
        bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume 0 +5% #increase sound volume
        bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume 0 -5% #decrease sound volume
        bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute 0 toggle # mute sound
        exec --no-startup-id pa-applet
        ##################################
        #
        #	       BACKLIGHT
        #
        ##################################
        # Sreen brightness controls
        bindsym XF86MonBrightnessUp exec xbacklight -inc 20 # increase screen brightness
        bindsym XF86MonBrightnessDown exec xbacklight -dec 20 # decrease screen brightness


        ##################################
        #
        #	       LOOK AND FEEL
        #
        ##################################
        # Provide Gaps to Windows. Increase/Decrease as you like.
        gaps inner 10
        # Font for window titles. Will also be used by the bar.
        #font pango:monospace 15
        #font terminess:monospace 15
        #font ter-powerline:monospace 15

        # This font is widely installed, provides lots of unicode glyphs, right-to-left
        # text rendering and scalability on retina/hidpi displays (thanks to pango).
        font pango:DejaVu Sans Mono 8

        default_border pixel 1
        default_floating_border pixel 1



        ##################################
        #
        #	       PROGRAM BINDS
        #
        ##################################
        # start a terminal. We use kitty.
        bindsym $mod+Return exec alacritty
        # start dmenu (a program launcher).
        # bindsym $mod+d exec --no-startup-id dmenu_run
        # A more modern dmenu replacement is rofi:
        # You have 2 options to launch rofi:
        # This mode search for .desktop files in /usr/share/applications.
        # This is the recommended mode. It searches for the programs as
        # defined in .desktop file, with their description, and corresponding
        # icons
        bindsym $mod+d exec --no-startup-id rofi -show drun -theme Monokai -icon-theme "Tela-circle" -show-icons

        # The other mode search for applications in /usr/bin or /usr/sbin.
        # This should only be used if a program lacks a .desktop file.
        bindsym $mod+Shift+d exec --no-startup-id rofi -show run -theme Monokai


        # Lock Screen This will yield a black lock screen, which
        # can be customized to your liking.
        bindsym Mod4+l exec betterlockscreen -l


        ##################################
        #
        #	       SETTINGS & STARTUP
        #
        ##################################
        #Multi Monitor (Dual Monitor, extended monitor)
        #Replace HDMI2 with DVI-2, VGA-2, DP-2, DVI-2 etc. Get value by typing xrandr in the terminal.
        #If X is a natural number, then;
        #eDP-X is the display used in Laptops.
        #HDMI-X is display used in Desktop connected to monitor with HDMI Cable.
        #VGA-X is display used in Desktop connected to monitor with VGA Cable.
        exec --no-startup-id xrandr --output HDMI-2 --right-of HDMI-1 --auto

        # Set keyboard speed
        exec_always xset r rate 250 60
        # Launch Polybar. Take a look at ~/.confi/polybar/config to
        # configure the bar.
        exec_always --no-startup-id ${
          pkgs.writeShellScriptBin "launch-polybar.sh" ''
            # note: all polybar configs have to have IPC enabled in order for
            # this to work!
            killall -q polybar

            ${pkgs.polybar}/bin/polybar --config=${./config.ini} alg-example 2>&1 | tee -a /tmp/polybar-top.log & disown

          ''
        }/bin/launch-polybar.sh

        # Display Wallpaper, always.
        exec_always feh --bg-fill ${./wall.png}


        #Compositor. This helps in transparency and fading.
        exec_always picom -f

        # The combination of xss-lock, nm-applet and pactl is a popular choice, so
        # they are included here as an example. Modify as you see fit.

        # xss-lock grabs a logind suspend inhibit lock and will use i3lock to lock the
        # screen before suspend. Use loginctl lock-session to lock your screen.

        # The 4 lines of text above come from i3 documentation. Waking up from a suspended
        # system will launch betterlockscreen
        exec --no-startup-id xss-lock --transfer-sleep-lock -- betterlockscreen -l

        # NetworkManager is the most popular way to manage wireless networks on Linux,
        # and nm-applet is a desktop environment-independent system tray GUI for it.
        # We use this. System dark theme is applied to it.
        exec --no-startup-id nm-applet
        #exec --no-startup-id opensnitch-ui
        bindsym Mod4+e exec --no-startup-id thunar
      '';
    };
  };
}