{
  services = {
    # udev.extraRules = ''
    #   SUBSYSTEM=="sound", ATTRS{idVendor}=="1235", ATTRS{idProduct}=="820b", ENV{PULSE_PROFILE_SET}="pro-audio"
    # '';

    pipewire = {
      wireplumber.extraConfig = {
        "clarettPro" = {
          "monitor.alsa.rules" = [
            {
              matches = [
                {"device.name" = "alsa_card.usb-Focusrite_Clarett__4Pre_00009991-00";}
              ];
              actions = {
                update-props = {
                  "device.profile" = "pro-audio";
                };
              };
            }
          ];
          # "wireplumber.components" = [
          #   {
          #     name = "clarett-virtual-sink";
          #     type = "module";
          #     provides = "virtual-clarett-sink";
          #     requires = [ "device.alsa_card.usb-Focusrite_Clarett__4Pre_00009991-00" ];
          #     "module.name" = "libpipewire-module-loopback";
          #     "module.arguments" = {
          #       "node.description" = "Clarett stereo pair 1";
          #       "capture.props" = {
          #         "node.name" = "clarett_stereo_pair_1";
          #         "media.class" = "Audio/Sink";
          #         "audio.position" = "[ FL FR ]";
          #       };
          #       "playback.props" = {
          #         "node.name" = "playback.clarett_stereo_pair_1";
          #         "audio.position" = "[ AUX0 AUX1 ]";
          #         "target.object" = "alsa_output.usb-Focusrite_Clarett__4Pre_00009991-00.pro-output-0";
          #         "stream.dont-remix" = "true";
          #         "monitor" = "false";
          #         "priority.session" = "1750";
          #         "node.passive" = "true";
          #       };
          #     };
          #   }
          # ];
        };
      };

      # extraConfig.pipewire."clarett" = {
      #   "context.objects" = [
      #     {
      #       factory = "adapter";
      #       args = {
      #         "factory.name" = "support.null-audio-sink";
      #         "node.name" = "clarett_stereo_pair_1";
      #         "node.description" = "Clarett stereo pair 1";
      #         "media.class" = "Audio/Sink";
      #         "audio.position" = "[ FL FR ]";
      #       };
      #       condition = [
      #         {
      #           "node.name" = "alsa_output.usb-Focusrite_Clarett__4Pre_00009991-00.pro-output-0";
      #         }
      #       ];
      #     }
      #     {
      #       factory = "adapter";
      #       args = {
      #         "factory.name" = "api.alsa.pcm.sink";
      #         "node.name" = "playback.clarett_stereo_pair_1";
      #         "node.target" = "alsa_output.usb-Focusrite_Clarett__4Pre_00009991-00.pro-output-0";
      #         "audio.position" = "[ AUX0 AUX1 ]";
      #         "stream.dont-remix" = "true";
      #         "monitor" = "false";
      #         "priority.session" = "1750";
      #         "node.passive" = "true";
      #       };
      #       condition = [
      #         {
      #           "node.name" = "alsa_output.usb-Focusrite_Clarett__4Pre_00009991-00.pro-output-0";
      #         }
      #       ];
      #     }
      #   ];
      # };

      # extraConfig.pipewire."clarett" = {
      #   "context.modules" = [
      #     {
      #       name = "libpipewire-module-loopback";
      #       args = {
      #         "node.description" = "Clarett stereo pair 1";
      #         "capture.props" = {
      #           "node.name" = "clarett_stereo_pair_1";
      #           "media.class" = "Audio/Sink";
      #           "audio.position" = "[ FL FR ]";
      #         };
      #         "playback.props" = {
      #           "node.name" = "playback.clarett_stereo_pair_1";
      #           "audio.position" = "[ AUX0 AUX1 ]";
      #           "target.object" = "~alsa_output.usb-Focusrite_Clarett__4Pre.*";
      #           "stream.dont-remix" = "true";
      #           "monitor" = "false";
      #           "priority.session" = "1750";
      #           "node.passive" = "true";
      #         };
      #       };
      #       condition = [
      #         { "device.name" = "alsa_card.usb-Focusrite_Clarett__4Pre_00009991-00"; }
      #       ];
      #     }
      #   ];
      # };
    };
  };
}
