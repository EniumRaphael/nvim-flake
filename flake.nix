{
  description = "A very basic flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim = {
      url = "github:pta2002/nixvim";
      #url = "/home/traxys/Documents/nixvim";
      #url = "github:traxys/nixvim?ref=dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-flake = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Misc tools
    sca2d = {
      url = "gitlab:bath_open_instrumentation_group/sca2d";
      flake = false;
    };

    # Automatically handled plugins
    "plugin:clangd_extensions-nvim" = {
      url = "github:p00f/clangd_extensions.nvim";
      flake = false;
    };
    "plugin:netman-nvim" = {
      url = "github:miversen33/netman.nvim";
      flake = false;
    };
    "plugin:cmp-buffer" = {
      url = "github:hrsh7th/cmp-buffer";
      flake = false;
    };
    "plugin:cmp-calc" = {
      url = "github:hrsh7th/cmp-calc";
      flake = false;
    };
    "plugin:cmp-nvim-lsp" = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    "plugin:cmp-path" = {
      url = "github:hrsh7th/cmp-path";
      flake = false;
    };
    "plugin:cmp_luasnip" = {
      url = "github:saadparwaiz1/cmp_luasnip";
      flake = false;
    };
    "plugin:comment-nvim" = {
      url = "github:numtostr/comment.nvim";
      flake = false;
    };
    "plugin:firenvim" = {
      url = "github:glacambre/firenvim";
      flake = false;
    };
    "plugin:git-messenger-vim" = {
      url = "github:rhysd/git-messenger.vim";
      flake = false;
    };
    "plugin:gitsigns-nvim" = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
    "plugin:inc-rename-nvim" = {
      url = "github:smjonas/inc-rename.nvim";
      flake = false;
    };
    "plugin:indent-blankline-nvim" = {
      url = "github:lukas-reineke/indent-blankline.nvim";
      flake = false;
    };
    "plugin:lspkind-nvim" = {
      url = "github:onsails/lspkind.nvim";
      flake = false;
    };
    "plugin:lualine-nvim" = {
      url = "github:nvim-lualine/lualine.nvim";
      flake = false;
    };
    "plugin:noice-nvim" = {
      url = "github:folke/noice.nvim";
      flake = false;
    };
    "plugin:nui-nvim" = {
      url = "github:MunifTanjim/nui.nvim";
      flake = false;
    };
    "plugin:null-ls-nvim" = {
      url = "github:jose-elias-alvarez/null-ls.nvim";
      flake = false;
    };
    "plugin:nvim-cmp" = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };
    "plugin:nvim-lightbulb" = {
      url = "github:kosayoda/nvim-lightbulb";
      flake = false;
    };
    "plugin:nvim-lspconfig" = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    "plugin:nvim-notify" = {
      url = "github:rcarriga/nvim-notify";
      flake = false;
    };
    "plugin:nvim-osc52" = {
      url = "github:ojroques/nvim-osc52";
      flake = false;
    };
    "plugin:nvim-tree-lua" = {
      url = "github:nvim-tree/nvim-tree.lua";
      flake = false;
    };
    "plugin:nvim-treesitter-context" = {
      url = "github:nvim-treesitter/nvim-treesitter-context";
      flake = false;
    };
    "plugin:nvim-treesitter-refactor" = {
      url = "github:nvim-treesitter/nvim-treesitter-refactor";
      flake = false;
    };
    "plugin:plantuml-syntax" = {
      url = "github:aklt/plantuml-syntax";
      flake = false;
    };
    "plugin:plenary-nvim" = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    "plugin:rust-tools-nvim" = {
      url = "github:simrat39/rust-tools.nvim";
      flake = false;
    };
    "plugin:telescope-nvim" = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };
    "plugin:telescope-ui-select-nvim" = {
      url = "github:nvim-telescope/telescope-ui-select.nvim";
      flake = false;
    };
    "plugin:trouble-nvim" = {
      url = "github:folke/trouble.nvim";
      flake = false;
    };
    "plugin:vim-headerguard" = {
      url = "github:drmikehenry/vim-headerguard";
      flake = false;
    };
    "plugin:vim-matchup" = {
      url = "github:andymass/vim-matchup";
      flake = false;
    };
    "plugin:luasnip" = {
      url = "github:L3MON4D3/LuaSnip";
      flake = false;
    };
    "plugin:openscad-nvim" = {
      url = "github:salkin-mada/openscad.nvim";
      flake = false;
    };

    # Manually handled plugins
    "nvim-treesitter" = {
      url = "github:nvim-treesitter/nvim-treesitter";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixvim,
    flake-utils,
    neovim-flake,
    ...
  } @ inputs:
    with builtins;
      flake-utils.lib.eachDefaultSystem (system: let
        module = {
          imports = [
            ./config.nix
            ./plugins/firenvim.nix
            ./plugins/headerguard.nix
            ./plugins/lsp-signature.nix
            ./plugins/fidget.nix
            ./plugins/openscad.nix
            ./modules
          ];
          package = neovim-flake.packages."${system}".neovim.overrideAttrs (_: {
            patches = [];
          });
        };

        plugins = filter (s: (match "plugin:.*" s) != null) (attrNames inputs);
        plugName = input:
          substring
          (stringLength "plugin:")
          (stringLength input)
          input;

        buildPlug = pkgs: name:
          pkgs.vimUtils.buildVimPluginFrom2Nix {
            pname = plugName name;
            version = "master";
            src = getAttr name inputs;
          };

        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (final: prev: let
              buildPlugPkg = buildPlug prev;
            in {
              inherit sca2d;
              vimPlugins =
                prev.vimPlugins
                // (listToAttrs (map (plugin: {
                    name = plugName plugin;
                    value = buildPlugPkg plugin;
                  })
                  plugins));
            })

            (
              final: prev: {
                vimPlugins =
                  prev.vimPlugins
                  // {
                    openscad-nvim = prev.vimPlugins.openscad-nvim.overrideAttrs (old: {
                      pname = "openscad.nvim";
                    });
                    plenary-nvim = prev.vimPlugins.plenary-nvim.overrideAttrs (old: {
                      postPatch = ''
                        sed -Ei lua/plenary/curl.lua \
                            -e 's@(command\s*=\s*")curl(")@\1${final.curl}/bin/curl\2@'
                      '';

                      doInstallCheck = true;
                      nvimRequireCheck = "plenary";
                    });
                    telescope-nvim = prev.vimPlugins.telescope-nvim.overrideAttrs (old: {
                      dependencies = with final; [vimPlugins.plenary-nvim];
                    });
                    gitsigns-nvim = prev.vimPlugins.gitsigns-nvim.overrideAttrs (old: {
                      dependencies = with final; [vimPlugins.plenary-nvim];
                    });
                    noice-nvim = prev.vimPlugins.noice-nvim.overrideAttrs (old: {
                      dependencies = with final; [vimPlugins.nui-nvim vimPlugins.nvim-notify];
                    });
                    null-ls-nvim = prev.vimPlugins.null-ls-nvim.overrideAttrs (old: {
                      dependencies = with final; [vimPlugins.plenary-nvim];
                    });
                    nvim-treesitter = prev.vimUtils.buildVimPluginFrom2Nix {
                      inherit (prev.vimPlugins.nvim-treesitter) pname passthru;
                      version = "master";

                      src = inputs.nvim-treesitter;
                    };
                  };
              }
            )
          ];
        };

        nixvim' = nixvim.legacyPackages."${system}";
        nvim = nixvim'.makeNixvimWithModule {inherit module pkgs;};

        lark-0-10 = pkgs.python3Packages.lark.overrideAttrs (old: rec {
          version = "0.10.0";

          src = pkgs.fetchFromGitHub {
            owner = "lark-parser";
            repo = "lark";
            rev = "refs/tags/${version}";
            sha256 = "sha256-ctdPPKPSD4weidyhyj7RCV89baIhmuxucF3/Ojx1Efo=";
          };

          disabledTestPaths = ["tests/test_nearley/test_nearley.py"];
        });

        sca2d-pkg = {
          python3Packages,
          stdenv,
        }:
          python3Packages.buildPythonApplication {
            pname = "sca2d";
            version = inputs.sca2d.shortRev;

            src = inputs.sca2d;
            nativeBuildInputs = with python3Packages; [poetry-core];
            propagatedBuildInputs = with python3Packages; [lark-0-10 colorama];
          };
        sca2d = pkgs.callPackage sca2d-pkg {};
      in {
        checks.launch = pkgs.stdenv.mkDerivation {
          name = "launch-nvim";

          nativeBuildInputs = [self.packages."${system}".nvim pkgs.docker-client];

          dontUnpack = true;
          # We need to set HOME because neovim will try to create some files
          #
          # Because neovim does not return an exitcode when quitting we need to check if there are
          # errors on stderr
          buildPhase = ''
            output=$(HOME=$(realpath .) nvim -mn --headless "+q" 2>&1 >/dev/null)
            if [[ -n $output ]]; then
            	echo "ERROR: $output"
              exit 1
            fi
          '';

          # If we don't do this nix is not happy
          installPhase = ''
            mkdir $out
          '';
        };
        formatter = pkgs.alejandra;

        devShell = pkgs.mkShell {
          packages = [nvim];
        };
        packages = {
          inherit nvim sca2d;
          default = nvim;
        };
      });
}
