{ config, system, pkgs, lib, ... }:

  let
  extensions = [
    "astro-build.astro-vscode"
    "bbenoist.Nix"
    "DavidAnson.vscode-markdownlint"
    "eamodio.gitlens"
    "esbenp.prettier-vscode"
    "formulahendry.auto-close-tag"
    "GitHub.github-vscode-theme"
    "GrapeCity.gc-excelviewer"
    "Gruntfuggly.todo-tree"
    "idleberg.applescript"
    "James-Yu.latex-workshop"
    "mechatroner.rainbow-csv"
    "miguelsolorio.fluent-icons"
    "monokai.theme-monokai-pro-vscode"
    "moshfeu.compare-folders"
    "ms-azuretools.vscode-docker"
    "ms-python.black-formatter"
    "ms-python.flake8"
    "ms-python.isort"
    "ms-python.python"
    "ms-toolsai.jupyter"
    "ms-toolsai.jupyter-keymap"
    "ms-toolsai.jupyter-renderers"
    "ms-toolsai.vscode-jupyter-cell-tags"
    "ms-toolsai.vscode-jupyter-slideshow"
    "ms-vscode-remote.remote-containers"
    "ms-vscode-remote.remote-ssh"
    "ms-vscode-remote.remote-ssh-edit"
    "ms-vscode.cmake-tools"
    "ms-vscode.cpptools"
    "ms-vscode.cpptools-extension-pack"
    "ms-vscode.cpptools-themes"
    "ms-vscode.remote-explorer"
    "njpwerner.autodocstring"
    "redhat.vscode-commons"
    "redhat.vscode-yaml"
    "rioj7.command-variable"
    "ronnidc.nunjucks"
    "rust-lang.rust-analyzer"
    "sleistner.vscode-fileutils"
    "streetsidesoftware.code-spell-checker"
    "tonka3000.raycast"
    "twxs.cmake"
    "unifiedjs.vscode-mdx"
    "VisualStudioExptTeam.intellicode-api-usage-examples"
    "VisualStudioExptTeam.vscodeintellicode"
    "xaver.clang-format"
    "yzhang.markdown-all-in-one"
  ];
  in
{
  home.packages = [ pkgs.nixfmt pkgs.curl pkgs.jq ];

  programs.vscode = {
    enable = true;
    userSettings = {
      "editor.renderWhitespace" = "all";
      "files.autoSave" = "onFocusChange";
      "editor.rulers" = [ 100 ];
    };
  };

  home.activation.installExtensions =
    lib.hm.dag.entryAfter [ "writeBoundary" ]
      (lib.optionalString config.isDarwin (builtins.concatStringsSep "\n" (map (e: "${config.programs.vscode.package}/bin/code --install-extension ${e} --force") extensions)));
}