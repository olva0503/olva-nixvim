{pkgs, ...}: {
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
        # java.enable = true;
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
