{ pkgs, ... }:

{
  programs.librewolf = {
    enable = true;
    policies = {
      "3rdparty".Extensions = {
        "uBlock0@raymondhill.net".adminSettings = {
          userSettings = {
            advancedUserEnabled = true;
          };
          netFilteringSwitch = true;
          dynamicFilteringString =
            let
              domains = [
                "ajax.googleapis.com"
                "ajax.aspnetcdn.com"
                "ajax.microsoft.com"
                "cdnjs.cloudflare.com"
                "code.jquery.com"
                "cdn.jsdelivr.net"
                "fonts.googleapis.com"
                "yastatic.net"
                "yandex.st"
                "apps.bdimg.com"
                "libs.baidu.com"
                "cdn.staticfile.org"
                "cdn.bootcss.com"
                "mat1.gtimg.com"
                "lib.sinaapp.com"
                "upcdn.b0.upaiyun.com"
                "stackpath.bootstrapcdn.com"
                "maxcdn.bootstrapcdn.com"
                "netdna.bootstrapcdn.com"
                "use.fontawesome.com"
                "ajax.cloudflare.com"
                "akamai-webcdn.kgstatic.net"
                "gitcdn.github.io"
                "vjs.zencdn.net"
                "cdn.plyr.io"
                "cdn.materialdesignicons.com"
                "cdn.ravenjs.com"
                "js.appboycdn.com"
                "cdn.embed.ly"
                "cdn.datatables.net"
                "mathjax.rstudio.com"
                "cdn.mathjax.org"
                "code.createjs.com"
                "sdn.geekzu.org"
                "ajax.proxy.ustclug.org"
                "unpkg.com"
                "pagecdn.io"
                "cdnjs.loli.net"
                "ajax.loli.net"
                "fonts.loli.net"
                "lib.baomitu.com"
                "cdn.bootcdn.net"
                "fonts.gstatic.com"
                "ajax.loli.net.cdn.cloudflare.net"
                "akamai-webcdn.kgstatic.net.edgesuite.net"
                "apps.bdimg.jomodns.com"
                "cdn.bootcdn.net.maoyundns.com"
                "cdn.bootcss.com.maoyundns.com"
                "cdn.embed.ly.cdn.cloudflare.net"
                "cdn.jsdelivr.net.cdn.cloudflare.net"
                "cdnjs.loli.net.cdn.cloudflare.net"
                "cds.s5x3j6q5.hwcdn.net"
                "developer.n.shifen.com"
                "dualstack.osff.map.fastly.net"
                "fonts.loli.net.cdn.cloudflare.net"
                "gateway.cname.ustclug.org"
                "gstaticadssl.l.google.com"
                "iduwdjf.qiniudns.com"
                "jsdelivr.map.fastly.net"
                "lb.sae.sina.com.cn"
                "lib.baomitu.com.qh-cdn.com"
                "mat1.gtimg.com.tegsea.tc.qq.com"
                "materialdesignicons.b-cdn.net"
                "mscomajax.vo.msecnd.net"
                "sdn.inbond.gslb.geekzu.org"
                "use.fontawesome.com.cdn.cloudflare.net"
                "vo.aicdn.com"
              ];
            in
            builtins.concatStringsSep "\n" (
              [
                "no-scripting: * true"
                "no-large-media: * true"
              ]
              ++ map (domain: "${domain} * 3p-script noop") domains
              ++ map (domain: "${domain} * 3p-frame noop") domains
            );
        };
      };
    };

    profiles = {
      default = {
        id = 0;
        isDefault = true;

        settings = {
          # IDIOMA Y LOCALIZACIÓN (Español Argentina)
          "intl.accept_languages" = "es-AR, es, en-US, en";

          # ACTUALIZACIÓN AUTOMÁTICA DE ADD-ONS
          "extensions.update.enabled" = true;
          "extensions.update.autoUpdateDefault" = true;

          # COMPORTAMIENTO Y COMODIDAD DIARIA
          "general.autoScroll" = true;
          "middlemouse.paste" = false;
          "browser.startup.page" = 3;
          "browser.download.useDownloadDir" = true;
          "browser.download.alwaysOpenPanel" = false;

          # HISTORIAL Y FORMULARIOS (PERSISTENTE PARA USO DIARIO)
          "places.history.enabled" = true;
          "browser.formfill.enable" = true;
          "privacy.sanitize.sanitizeOnShutdown" = false;
          "privacy.clearOnShutdown.history" = false;
          "privacy.clearOnShutdown.downloads" = false;
          "privacy.clearOnShutdown.formdata" = false;

          # FIREFOX SYNC (HABILITADO)
          "identity.fxaccounts.enabled" = true;

          # PRIVACIDAD Y REFERRERS (LIMITAR A SAME-ORIGIN)
          "network.http.referer.XOriginPolicy" = 2;
          "network.http.referer.XOriginTrimmingPolicy" = 2;
          "privacy.trackingprotection.enabled" = true;
          "dom.security.https_only_mode" = true;

          # DNS SECURE (MODO 2: CUSTOM CON FALLBACK AUTOMÁTICO PARA NO ROMPER NAVEGACIÓN)
          "network.trr.mode" = 2;
          "network.trr.uri" = "https://dns.quad9.net/dns-query";
          "network.trr.custom_uri" = "https://dns.quad9.net/dns-query";

          # PRIVACIDAD EQUILIBRADA (Sin romper sitios)
          "privacy.resistFingerprinting" = false;
          "privacy.resistFingerprinting.letterboxing" = false;

          # MULTIMEDIA, DRM Y RENDIMIENTO
          "javascript.options.jit.trusted" = true;
          "javascript.options.wasm" = true;
          "webgl.disabled" = false;
          "media.peerconnection.enabled" = true;
          "browser.display.use_document_fonts" = 1;

          # CONTROL DE REPRODUCCIÓN (Desactivar Picture-in-Picture)
          "media.videocontrols.picture-in-picture.enabled" = false;

          # SOPORTE MULTIMEDIA Y STREAMING (DRM y OpenH264 habilitados)
          "media.eme.enabled" = true;
          "media.gmp-provider.enabled" = true;
        };

        extensions = {
          force = true;
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            # adaptive-tab-bar-colour
            ambient-light-for-youtube
            bitwarden
            # bypass-paywalls-clean
            consent-o-matic
            darkreader
            localcdn
            proton-vpn
            search-by-image
            # surfingkeys
            sponsorblock
            tablissng
            ublock-origin
            # violentmonkey
          ];
        };
      };

      private = {
        id = 1;
        isDefault = false;

        settings = {
          # COMPORTAMIENTO DEL RATÓN (AUTOSCROLL Y MIDDLE-CLICK PASTE)
          "general.autoScroll" = true;
          "middlemouse.paste" = false;

          # ACTUALIZACIÓN AUTOMÁTICA DE ADD-ONS
          "extensions.update.enabled" = true;
          "extensions.update.autoUpdateDefault" = true;

          # HISTORIAL Y DESCARGAS (DESACTIVAR RECORDAR HISTORIAL)
          "places.history.enabled" = false;
          "privacy.history.custom" = true;
          "privacy.sanitize.sanitizeOnShutdown" = true;
          "privacy.clearOnShutdown.history" = true;
          "privacy.clearOnShutdown.downloads" = true;
          "privacy.clearOnShutdown.formdata" = true;
          "browser.formfill.enable" = false;

          # FINGERPRINTING PROTECTION & HARDENING
          "privacy.resistFingerprinting" = true;
          "privacy.resistFingerprinting.letterboxing" = true;
          "privacy.resistFingerprinting.block_mozAddonManager" = true;
          "privacy.fingerprintingProtection" = true;
          "privacy.trackingprotection.cryptomining.enabled" = true;
          "privacy.globalprivacycontrol.enabled" = true;
          "privacy.globalprivacycontrol.pbmode.enabled" = true;

          # AISLAMIENTO DE FUENTES Y MEDIDAS DE TIEMPO
          "browser.display.use_document_fonts" = 0;
          "dom.enable_performance" = false;
          "privacy.reduceTimerPrecision" = true;
          "privacy.resistFingerprinting.reduceTimerPrecision.microseconds" = 100000;

          # TRACKING PROTECTION
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.pbmode.enabled" = true;
          "privacy.trackingprotection.fingerprinting.enabled" = true;

          # REFERRER PRIVACY (Limitar a Same-Origin)
          "network.http.referer.XOriginPolicy" = 2;
          "network.http.referer.XOriginTrimmingPolicy" = 2;
          "network.http.referer.hideOnTargetXRef" = true;

          # JAVASCRIPT HARDENING (Deshabilitar JIT)
          "javascript.options.jit.trusted" = false;
          "javascript.options.wasm" = false;

          # SECURE DNS (DNS-over-HTTPS - Quad9 Strict)
          "network.trr.mode" = 3;
          "network.trr.uri" = "https://dns.quad9.net/dns-query";
          "network.trr.custom_uri" = "https://dns.quad9.net/dns-query";

          # COOKIES, STORAGE & ISOLATION
          "network.cookie.cookieBehavior" = 5;
          "privacy.partition.network_state" = true;
          "privacy.partition.serviceWorkers" = true;
          "privacy.partition.always_partition_third_party_non_cookie_storage" = true;
          "network.auth.subresource-http-auth-allow" = 1;

          # HTTPS, TLS & OCSP
          "dom.security.https_only_mode" = true;
          "dom.security.https_only_mode_pbm" = true;
          "security.ssl.require_safe_negotiation" = true;
          "security.tls.version.min" = 3;
          "security.OCSP.enabled" = 1;
          "security.OCSP.require" = true;

          # WEBRTC AND NETWORK LEAKS
          "media.peerconnection.ice.default_address_only" = true;
          "media.peerconnection.ice.no_host" = true;
          "media.peerconnection.enabled" = false;

          # SPECULATIVE CONNECTIONS & NETWORK
          "network.prefetch-next" = false;
          "network.predictor.enabled" = false;
          "network.http.speculative-parallel-limit" = 0;
          "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.places.speculativeConnect.enabled" = false;

          # PERMISSIONS & HARDWARE API DISABLE
          "permissions.default.geo" = 2;
          "permissions.default.camera" = 2;
          "permissions.default.microphone" = 2;
          "permissions.default.desktop-notification" = 2;
          "permissions.default.xr" = 2;
          "device.sensors.enabled" = false;
          "dom.gamepad.enabled" = false;
          "dom.vr.enabled" = false;

          # ACTIVE CONTENT & WEBGL POPUP DISABLE
          "media.autoplay.default" = 5;
          "webgl.disabled" = true;
          "webgl.enable-webgl2" = false;
          "webgl.out-of-process" = false;
          "dom.webgpu.enabled" = false;
          "dom.battery.enabled" = false;

          # TELEMETRY AND DATA COLLECTION
          "toolkit.telemetry.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "app.shield.optoutstudies.enabled" = false;
          "browser.discovery.enabled" = false;

          # DOWNLOADS
          "browser.download.useDownloadDir" = false;
          "browser.download.alwaysOpenPanel" = false;
          "browser.download.start_downloads_in_tmp_dir" = true;

          # PRIVATE PROFILE BEHAVIOR
          "browser.privatebrowsing.autostart" = false;
          "browser.sessionstore.privacy_level" = 2;

          # CONTROL DE REPRODUCCIÓN (Desactivar Picture-in-Picture)
          "media.videocontrols.picture-in-picture.enabled" = false;
        };

        extensions = {
          force = true;
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            consent-o-matic
            darkreader
            localcdn
            proton-vpn
            ublock-origin
          ];
        };
      };
    };
  };

  stylix.targets.librewolf = {
    enable = true;
    colorTheme.enable = true;
    profileNames = [ "default" "private" ];
  };
}
