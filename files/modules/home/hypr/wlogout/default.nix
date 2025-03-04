{ pkgs, ... }:
{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "shutdown";
        action = "poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
          label = "logout";
          action = "loginctl terminate-user $USER";
          text = "Logout";
          keybind = "e";
      }
      {
          label = "reboot";
          action = "reboot";
          text = "Reboot";
          keybind = "r";
      }
      {
          label = "lock";
          action = "loginctl lock-session";
          text = "Lock";
          keybind = "l";
      }
      {
          label = "suspend";
          action = "hyprlock & sleep 3 ; systemctl suspend";
          text = "Suspend";
          keybind = "u";
      }
      {
          label = "hibernate";
          action = "loginctl hibernate";
          text = "Hibernate";
          keybind = "h";
      }
    ];

    style = ''
      @define-color background rgba(30, 31, 41, 230);
      @define-color purple #5f4a7d;
      @define-color comment #6272a4;

      * {
        background-image: none;
      }

      window {
        background-color: rgba(0, 0, 0, 0);
      }

      button {
        margin: 10px;
        padding: 0;
        color: @comment;
        font-size: 2rem;
        background-color: @background;
        outline-style: none;
        border: none;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 15%;
        border-radius: 6%;
        box-shadow: none;
        text-shadow: none;
        animation: gradient_f 20s ease-in infinite;
      }

      button:focus,
      button:active,
      button:hover {
        background-color: @purple;
        outline-style: none;
        background-size: 20%;
        animation: gradient_f 20s ease-in infinite;
        transition: all 0.3s cubic-bezier(0.55, 0, 0.28, 1.682);
      }

      #lock,
      #logout,
      #suspend,
      #hibernate,
      #shutdown,
      #reboot {
        opacity: 0.9;
      }

      #hibernate {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"));
      }

      #lock {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
      }

      #logout {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
      }

      #reboot {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
      }

      #shutdown {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
      }

      #suspend {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"));
      }
    '';
  };
}
