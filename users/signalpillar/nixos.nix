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
    hashedPassword = "$6$.aC5ISqifnS05uCU$RHM18.xGqsmqaGm.bCLGcgHPKPgF7TduNba/zwT6ZmiQ74LenlPoDe8TE7C5I7OnL5aq77EgTJDAgZr4zcwbm1";
    openssh.authorizedKeys.keys = [];
  };

  nixpkgs.overlays = import ../../lib/overlays.nix ++ [
    (import ./vim.nix { inherit inputs; })
  ];
}
