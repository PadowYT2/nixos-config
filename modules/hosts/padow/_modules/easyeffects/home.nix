{
  services.easyeffects = {
    enable = true;
    preset = "default";
    extraPresets = {
      default = {
        input = {
          blocklist = [];
          plugins_order = ["deepfilternet#0" "echo_canceller#0"];
          "deepfilternet#0" = {
            attenuation-limit = 30.0;
            bypass = false;
            input-gain = -10.0;
            output-gain = -10.0;
            min-processing-threshold = -15.0;
            max-erb-processing-threshold = 25.0;
            max-df-processing-threshold = 20.0;
            min-processing-buffer = 0;
            post-filter-beta = 0.05;
          };
          "echo_canceller#0" = {
            bypass = false;
            input-gain = 0.0;
            output-gain = 0.0;
            echo-canceller = {
              enable = true;
              mobile-mode = false;
              enforce-high-pass = true;
              automatic-gain-control = false;
            };
            noise-suppression = {
              enable = false;
              level = "Moderate";
            };
            high-pass = {
              enable = true;
              full-band = true;
            };
          };
        };
      };
    };
  };
}
