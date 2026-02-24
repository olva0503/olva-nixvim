{pkgs, ...}: let
  # Define the specific JAR version you need
  junit-jar = pkgs.fetchurl {
    url = "https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.10.1/junit-platform-console-standalone-1.10.1.jar";
    sha256 = "sha256-tC6qU9E1dtF9tfuLKAcipq6eNtr5X0JivG6W1Msgcl8="; # Replace with the correct hash if it fails
  };
in {
  plugins = {
    neotest = {
      enable = true;
      adapters = {
        golang = {
          enable = true;
          settings = {
            dap_go_enabled = true;
          };
        };
        java = {
          enable = true;
          settings = {
            # Point the plugin to the JAR provided by Nix
            junit_jar = "${junit-jar}";
          };
        };
        rust = {
          enable = true;
          settings = {
            dap_adapter = "lldb";
            args = ["--no-capture"];
          };
        };
        scala.enable = true;
        zig.enable = true;
      };
      settings = {
        log_level = "debug";
        diagnostic.severity = "info";
        output = {
          enabled = true;
        };
        output_panel = {
          enabled = true;
          open = "botright split | resize 15";
        };
        quickfix = {
          enabled = false;
        };
      };
    };
  };
}
