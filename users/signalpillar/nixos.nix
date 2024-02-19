{ pkgs, inputs, ... }:

{
  # https://github.com/nix-community/home-manager/pull/2408
  environment.pathsToLink = [ "/share/fish" ];

  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  # Since we're using fish as our shell
  programs.fish.enable = true;

  users.users.signalpillar = {
    isNormalUser = true;
    home = "/home/signalpillar";
    extraGroups = [ "docker" "wheel"
                    # plugdev is required to access USB devices
                    "plugdev"];
    shell = pkgs.fish;
    initialPassword = "demo";
  };

  nixpkgs.overlays = import ../../lib/overlays.nix ++ [
    (import ./vim.nix { inherit inputs; })
  ];
}
