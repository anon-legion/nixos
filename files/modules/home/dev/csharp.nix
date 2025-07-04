{ pkgs, ... }:
{
  home = {
    sessionPath = [
      "$HOME/.dotnet/tools"
    ];
    sessionVariables = {
      DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_8_0}/share/dotnet";
    };
    packages = with pkgs; [
      # dotnet-sdk_8
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
