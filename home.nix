{ pkgs, ... }: {
  home.username = "sadanand"; # REPLACE ME
  home.homeDirectory = "/Users/sadanand"; # REPLACE ME
  home.stateVersion = "23.05";
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.sl
    pkgs.bat
    pkgs.comma
    pkgs.coreutils
    pkgs.fortune
    pkgs.gnused
    pkgs.htop
    pkgs.jq
    pkgs.libiconv
    pkgs.nixfmt
    pkgs.ripgrep
    pkgs.shadowenv
    pkgs.tree
    pkgs.watch
    pkgs.wget
    pkgs.neovim
  ];

  programs.zsh = {
    enable = true;
    initExtra = builtins.readFile ./zshrc;
    envExtra = builtins.readFile ./zshenv;
  };

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

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.vscode = {
  enable = true;
  extensions = with pkgs.vscode-extensions; [
    astro-build.astro-vscode
    bbenoist.Nix
    DavidAnson.vscode-markdownlint
    eamodio.gitlens
    esbenp.prettier-vscode
    formulahendry.auto-close-tag
    GitHub.github-vscode-theme
    GrapeCity.gc-excelviewer
    Gruntfuggly.todo-tree
    idleberg.applescript
    James-Yu.latex-workshop
    mechatroner.rainbow-csv
    miguelsolorio.fluent-icons
    monokai.theme-monokai-pro-vscode
    moshfeu.compare-folders
    ms-azuretools.vscode-docker
    ms-python.black-formatter
    ms-python.flake8
    ms-python.isort
    ms-python.python
    ms-toolsai.jupyter
    ms-toolsai.jupyter-keymap
    ms-toolsai.jupyter-renderers
    ms-toolsai.vscode-jupyter-cell-tags
    ms-toolsai.vscode-jupyter-slideshow
    ms-vscode-remote.remote-containers
    ms-vscode-remote.remote-ssh
    ms-vscode-remote.remote-ssh-edit
    ms-vscode.cmake-tools
    ms-vscode.cpptools
    ms-vscode.cpptools-extension-pack
    ms-vscode.cpptools-themes
    ms-vscode.remote-explorer
    njpwerner.autodocstring
    redhat.vscode-commons
    redhat.vscode-yaml
    rioj7.command-variable
    ronnidc.nunjucks
    rust-lang.rust-analyzer
    sleistner.vscode-fileutils
    streetsidesoftware.code-spell-checker
    tonka3000.raycast
    twxs.cmake
    unifiedjs.vscode-mdx
    VisualStudioExptTeam.intellicode-api-usage-examples
    VisualStudioExptTeam.vscodeintellicode
    xaver.clang-format
    yzhang.markdown-all-in-one
  ];
};

}

