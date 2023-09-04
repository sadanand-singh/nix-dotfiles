{ config, system, pkgs, lib, ... }:

  let
  extensions = [
    "astro-build.astro-vscode"
    "bbenoist.Nix"
    "Continue.continue"
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
    "editor.rulers" = [100];
    "editor.scrollBeyondLastLine" = true;
    "editor.tabSize" = 4;
    "editor.fontFamily" = "Hack Nerd Font Mono";
    "editor.fontLigatures" = true;
    "files.trimTrailingWhitespace" = true;
    "editor.wordWrap" = "on";
    "editor.multiCursorModifier" = "ctrlCmd";
    "editor.snippetSuggestions" = "top";
    "python.formatting.blackArgs" = ["--line-length" "99" "-S"];
    "python.linting.flake8Args" = [
        "--max-line-length=99"
        "--ignore=E203;W503"
        "--exclude=.git;__pycache__;.direnv;node_modules"
    ];
    "python.linting.pylintEnabled" = false;
    "python.linting.flake8Enabled" = true;
    "python.formatting.provider" = "black";
    "cSpell.allowCompoundWords" = true;
    "cSpell.userWords" = [
        "zotero"
    ];
    "autoDocstring.docstringFormat" = "google";
    "prettier.printWidth" = 99;
    "prettier.singleQuote" = true;
    "terminal.integrated.fontSize" = 14;
    "terminal.integrated.macOptionIsMeta" = true;
    "terminal.external.osxExec" = "Warp.app";
    "markdownlint.run" = "onSave";
    "markdownlint.config" = {
        "default" = true;
        "no-inline-html" = false;
        "no-alt-text" = false;
        "no-trailing-punctuation" = false;
        "no-emphasis-as-header" = false;
    };
    "editor.minimap.enabled" = true;
    "python.linting.enabled" = true;
    "python.testing.pytestEnabled" = true;
    "breadcrumbs.enabled" = true;
    "files.hotExit" = "off";
    "workbench.editor.restoreViewState" = false;
    "explorer.confirmDelete" = false;
    "workbench.iconTheme" = "Monokai Pro Icons";
    "cSpell.enabledLanguageIds" = [
        "asciidoc"
        "c"
        "cpp"
        "csharp"
        "css"
        "git-commit"
        "go"
        "handlebars"
        "haskell"
        "html"
        "jade"
        "java"
        "javascript"
        "javascriptreact"
        "json"
        "jsonc"
        "latex"
        "less"
        "markdown"
        "mdx"
        "php"
        "plaintext"
        "pug"
        "python"
        "restructuredtext"
        "rust"
        "scala"
        "scss"
        "text"
        "typescript"
        "typescriptreact"
        "yaml"
        "yml"
    ];
    "git.ignoreLegacyWarning" = true;
    "yaml.schemas" = {
        "file =///toc.schema.json" = "/toc\\.yml/i";
    };
    "terminal.integrated.inheritEnv" = false;
    "todo-tree.highlights.enabled" = true;
    "auto-close-tag.activationOnLanguage" = [
        "xml"
        "php"
        "blade"
        "ejs"
        "jinja"
        "javascript"
        "javascriptreact"
        "typescript"
        "typescriptreact"
        "plaintext"
        "markdown"
        "mdx"
        "vue"
        "liquid"
        "erb"
        "lang-cfml"
        "cfml"
        "HTML (Eex)"
    ];
    "typescript.updateImportsOnFileMove.enabled" = "always";
    "gitlens.advanced.messages" = {
        "suppressGitVersionWarning" = true;
    };
    "remote.SSH.remotePlatform" = {
        "keymaker" = "linux";
        "10.27.119.121" = "linux";
        "10.225.94.55" = "linux";
        "aryabhatta.local" = "linux";
        "qbna_dev2" = "linux";
    };
    "prettier.jsxSingleQuote" = true;
    "editor.suggestSelection" = "first";
    "vsintellicode.modify.editor.suggestSelection" = "automaticallyOverrodeDefaultValue";
    "vsintellicode.features.python.deepLearning" = "enabled";
    "editor.fontSize" = 16;
    "python.languageServer" = "Pylance";
    "[jsonc]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "jupyter.allowUnauthorizedRemoteConnection" = true;
    "workbench.editorAssociations" = {
        "*.ipynb" = "jupyter-notebook";
    };
    "python.terminal.activateEnvironment" = false;
    "workbench.startupEditor" = "none";
    "git.autofetch" = true;
    "workbench.editor.untitled.hint" = "hidden";
    "workbench.productIconTheme" = "fluent-icons";
    "notebook.cellToolbarLocation" = {
        "default" = "right";
        "jupyter-notebook" = "left";
    };
    "security.workspace.trust.untrustedFiles" = "open";
    "redhat.telemetry.enabled" = true;
    "todo-tree.general.tags" = ["BUG" "HACK" "FIXME" "TODO" "XXX" "[ ]" "[x]"];
    "todo-tree.regex.regex" = "(//|#|<!--|;|/\\*|^|^\\s*(-|\\d+.))\\s*($TAGS)";
    "security.workspace.trust.startupPrompt" = "never";
    "terminal.integrated.fontFamily" = "Hack Nerd Font Mono";
    "[markdown]" = {
        "editor.defaultFormatter" = "yzhang.markdown-all-in-one";
    };
    "git.timeline.showUncommitted" = true;
    "[typescript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "[typescriptreact]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "[json]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "yaml.maxItemsComputed" = 500000;
    "editor.foldingMaximumRegions" = 65000;
    "json.maxItemsComputed" = 65000;
    "notebook.lineNumbers" = "on";
    "notebook.output.textLineLimit" = 30000;
    "[python]" = {
        "editor.formatOnType" = true;
        "editor.defaultFormatter" = "ms-python.black-formatter";
    };
    "jupyter.interactiveWindow.textEditor.executeSelection" = false;
    "C_Cpp.intelliSenseEngine" = "Tag Parser";
    "git.openRepositoryInParentFolders" = "always";
    "workbench.colorTheme" = "Monokai Pro";
    "files.associations" = {
        "*.astro" = "astro";
    };
    "[astro]" = {
        "editor.defaultFormatter" = "astro-build.astro-vscode";
    };
    "C_Cpp.formatting" = "clangFormat";
    "[cpp]" = {
        "editor.wordBasedSuggestions" = false;
        "editor.suggest.insertMode" = "replace";
        "editor.semanticHighlighting.enabled" = true;
    };
    "flake8.args" = [
        "--max-line-length=99"
        "--ignore=E203;W503"
        "--exclude=.git;__pycache__;.direnv;node_modules"
    ];
    "clang-format.language.apex.enable" = false;
    "clang-format.language.cuda.enable" = false;
    "clang-format.language.glsl.enable" = false;
    "clang-format.language.java.enable" = false;
    "clang-format.language.javascript.enable" = false;
    "clang-format.language.objective-c.enable" = false;
    "clang-format.language.proto.enable" = false;
    "clang-format.language.typescript.enable" = false;
    "editor.formatOnSave" = true;
    "clang-format.language.javascript.fallbackStyle" = "file";
    "remote.SSH.showLoginTerminal" = true;
    "black-formatter.args" = ["-S" "-l 99"];
    "C_Cpp.clang_format_fallbackStyle" = "LLVM";
    "python.defaultInterpreterPath" = "/Users/sadanand/.anaconda3/envs/dev/bin/python";
    "update.mode"= "none";
    };
  };

  home.activation.installExtensions =
    lib.hm.dag.entryAfter [ "writeBoundary" ]
      (lib.optionalString true (builtins.concatStringsSep "\n" (map (e: "${config.programs.vscode.package}/bin/code --install-extension ${e} --force") extensions)));
}
