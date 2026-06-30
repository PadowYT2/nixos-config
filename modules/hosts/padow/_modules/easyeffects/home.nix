{
  services.easyeffects = {
    enable = true;
    preset = "default";
    extraPresets = {
      default = {
        input = {
          blocklist = [];
          plugins_order = ["rnnoise#0" "gate#0" "compressor#0"];
          "rnnoise#0" = {
            bypass = false;
            enable-vad = true;
            input-gain = 0;
            model-name = "\"\"";
            output-gain = 0;
            release = 20;
            use-standard-model = true;
            vad-thres = 70;
            wet = 0;
          };
          "gate#0" = {
            attack = 2;
            bypass = false;
            curve-threshold = -42;
            curve-zone = -6;
            dry = -80.01;
            hpf-frequency = 10;
            hpf-mode = "Off";
            hysteresis = false;
            hysteresis-threshold = -12;
            hysteresis-zone = -6;
            input-gain = 0;
            input-to-link = -80.01;
            input-to-sidechain = -80.01;
            link-to-input = -80.01;
            link-to-sidechain = -80.01;
            lpf-frequency = 20000;
            lpf-mode = "Off";
            makeup = 0;
            output-gain = 0;
            reduction = -18;
            release = 150;
            sidechain = {
              lookahead = 0;
              mode = "Peak";
              preamp = 0;
              reactivity = 10;
              source = "Middle";
              stereo-split-source = "Left/Right";
              type = "Internal";
            };
            sidechain-to-input = -80.01;
            sidechain-to-link = -80.01;
            stereo-split = false;
            wet = 0;
          };
          "compressor#0" = {
            attack = 10;
            boost-amount = 6;
            boost-threshold = -72;
            bypass = false;
            dry = -80.01;
            hpf-frequency = 10;
            hpf-mode = "Off";
            input-gain = 0;
            input-to-link = -80.01;
            input-to-sidechain = -80.01;
            knee = -6;
            link-to-input = -80.01;
            link-to-sidechain = -80.01;
            lpf-frequency = 20000;
            lpf-mode = "Off";
            makeup = 8;
            mode = "Downward";
            output-gain = 0;
            ratio = 3;
            release = 100;
            release-threshold = -80.01;
            sidechain = {
              lookahead = 0;
              mode = "Peak";
              preamp = 0;
              reactivity = 10;
              source = "Middle";
              stereo-split-source = "Left/Right";
              type = "Feed-forward";
            };
            sidechain-to-input = -80.01;
            sidechain-to-link = -80.01;
            stereo-split = true;
            threshold = -24;
            wet = 0;
          };
        };
      };
    };
  };
}
