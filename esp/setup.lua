--setup.lua
local module={}
-- wifi led
GPIO_WIFI_LED=5

wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, function(T)
    print("\n\tSTA - CONNECTED".."\n\tSSID: "..T.SSID.."\n\tBSSID: "..
      T.BSSID.."\n\tChannel: "..T.channel)

    tmr.alarm(1, 500, 1, function()
        if gpio.read(GPIO_WIFI_LED)==0 then
          gpio.write(GPIO_WIFI_LED,gpio.HIGH)
          print("IP unavaiable, Waiting...")
        else
          gpio.write(GPIO_WIFI_LED,gpio.LOW)
        end
      end)

  end)

wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED, function(T)
    print("\n\tSTA - DISCONNECTED".."\n\tSSID: "..T.SSID.."\n\tBSSID: "..
      T.BSSID.."\n\treason: "..T.reason)
    gpio.write(GPIO_WIFI_LED,gpio.LOW)
  end)

wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, function(T)
    print("\n\tSTA - GOT IP".."\n\tStation IP: "..T.IP.."\n\tSubnet mask: "..
      T.netmask.."\n\tGateway IP: "..T.gateway)
    tmr.stop(1)
    gpio.write(GPIO_WIFI_LED,gpio.HIGH)
    app.start()
  end)

function module.start()
  wifi.setmode(wifi.STATION)
  wifi.sta.config(config.WIFI_SSID,config.WIFI_PASSPHRASE)
  gpio.mode(GPIO_WIFI_LED,gpio.OUTPUT)
  gpio.write(GPIO_WIFI_LED,gpio.LOW)
  wifi.sta.connect()

end

return module
