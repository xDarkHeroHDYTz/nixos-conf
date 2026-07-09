{ config, pkgs, ... }:

let
  audientUsbFix = pkgs.writeShellScriptBin "audient-usb" ''
    VENDOR_ID="2708"
    PRODUCT_ID=""

    clog() {
        ${pkgs.util-linux}/bin/logger -t audient-usb "[audient-usb] $1"
        echo "[audient-usb] $1"
    }

    get_audient_port() {
        target_vid="$1"
        target_pid="$2"
        for dev_path in /sys/bus/usb/devices/*; do
            if [ -d "$dev_path" ]; then
                case "''${dev_path##*/}" in
                    *:*) continue ;;
                esac
                if [ -f "$dev_path/idVendor" ]; then
                    current_vid=$(cat "$dev_path/idVendor" 2>/dev/null)
                    if [ "$current_vid" = "$target_vid" ]; then
                        echo "''${dev_path##*/}"
                        return 0
                    fi
                fi
            fi
        done
        return 1
    }

    case "$1" in
        pre)
            PORT=$(get_audient_port "$VENDOR_ID" "$PRODUCT_ID")
            if [ -n "$PORT" ]; then
                clog "Preparing Audient on port $PORT for suspend..."
                if [ -f "/sys/bus/usb/devices/$PORT/power/control" ]; then
                    echo "on" > "/sys/bus/usb/devices/$PORT/power/control" 2>/dev/null
                fi
                if [ -f "/sys/bus/usb/drivers/usb/unbind" ]; then
                    echo "$PORT" > "/sys/bus/usb/drivers/usb/unbind" 2>/dev/null
                    clog "Audient successfully isolated before suspend."
                fi
            else
                clog "Audient device not found, suspending normally."
            fi
            ;;

        post)
            clog "System resumed. Waiting for USB bus initialization..."
            PORT=""
            i=1
            while [ "$i" -le 20 ]; do
                PORT=$(get_audient_port "$VENDOR_ID" "$PRODUCT_ID")
                if [ -n "$PORT" ]; then
                    break
                fi
                sleep 0.5
                i=$((i + 1))
            done

            if [ -n "$PORT" ]; then
                driver_link="/sys/bus/usb/devices/$PORT/driver"
                if [ ! -L "$driver_link" ]; then
                    if [ -f "/sys/bus/usb/drivers/usb/bind" ]; then
                        echo "$PORT" > "/sys/bus/usb/drivers/usb/bind" 2>/dev/null
                        clog "Manually bound device to USB driver."
                    fi
                else
                    clog "Device already bound by kernel."
                fi

                j=1
                while [ "$j" -le 10 ]; do
                    if [ -f "/sys/bus/usb/devices/$PORT/power/control" ]; then
                        echo "on" > "/sys/bus/usb/devices/$PORT/power/control" 2>/dev/null
                        clog "USB autosuspend permanently disabled for port $PORT."
                        break
                    fi
                    sleep 0.1
                    j=$((j + 1))
                done
                clog "Audient on port $PORT successfully resumed."
            else
                clog "CRITICAL ERROR: Audient failed to reappear on the USB bus after resume!"
            fi
            ;;
    esac
  '';
in
{
  # Opciones correctas a nivel de sistema de NixOS
  environment.systemPackages = [ audientUsbFix ];

  powerManagement = {
    powerDownCommands = ''
      ${audientUsbFix}/bin/audient-usb pre
    '';
    resumeCommands = ''
      ${audientUsbFix}/bin/audient-usb post
    '';
  };
}
