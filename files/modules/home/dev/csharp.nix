{ pkgs, ... }:
{
  home = {
    sessionPath = [
      "$HOME/.dotnet/tools"
      "$HOME/.splashkit"
    ];
    sessionVariables = {
      DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_8_0}/share/dotnet";
    };
    packages = with pkgs; [
      (
        with dotnetCorePackages;
        combinePackages [
          sdk_8_0
          sdk_9_0
        ]
      )
      jetbrains.rider
    ];
  };
}
