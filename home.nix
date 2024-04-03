{ config, lib, pkgs, ... }: {
  imports = [
    ./vim.nix
  ];
  nixpkgs = {
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };
  home.username = "sadanand"; # REPLACE ME
  home.homeDirectory = "/Users/sadanand"; # REPLACE ME
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.sl
    pkgs.bat
    pkgs.cargo
    pkgs.comma
    pkgs.clang
    pkgs.clang-tools
    pkgs.cmake
    pkgs.coreutils
    pkgs.fortune
    pkgs.gnused
    pkgs.gron
    pkgs.hackgen-nf-font
    pkgs.htop
    pkgs.jq
    pkgs.libiconv
    pkgs.lsd
    pkgs.openfortivpn
    pkgs.nerdfonts
    pkgs.nixfmt
    pkgs.ripgrep
    pkgs.rustc
    pkgs.shadowenv
    pkgs.tree
    pkgs.watch
    pkgs.wget
  ];

  programs.git = {
    enable = true;
    userName = "Sadanand Singh";
    userEmail = "sadanand4singh@gmail.com";
    ignores = [ "*~" ".DS_Store" ".direnv" ".env" ".rgignore" ];
    extraConfig = {
      init = { defaultBranch = "main"; };
      pull = { ff = "only"; };
    };
    delta = { enable = true; };
    aliases = {
      ci = "commit";
      co = "checkout";
      di = "diff";
      dc = "diff --cached";
      addp = "add -p";
      shoe = "show";
      st = "status";
      unch = "checkout --";
      br = "checkout";
      bra = "branch -a";
      newbr = "checkout -b";
      rmbr = "branch -d";
      mvbr = "branch -m";
      cleanbr =
        "!git remote prune origin && git co master && git branch --merged | grep -v '*' | xargs -n 1 git branch -d && git co -";
      as = "update-index --assume-unchanged";
      nas = "update-index --no-assume-unchanged";
      al = "!git config --get-regexp 'alias.*' | colrm 1 6 | sed 's/[ ]/ = /'";
      pub = "push -u origin HEAD";
    };
    includes = [{ path = "~/.config/home-manager/gitconfig"; }];
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    defaultCommand = "rg --files --hidden --follow";
    defaultOptions = [ "-m --bind ctrl-a:select-all,ctrl-d:deselect-all" ];
  };

}
