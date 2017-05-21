-- file : config.lua
local module = {}

module.WIFI_SSID = "rspot"
module.WIFI_PASSPHRASE = ""

module.MQTT_HOST = "192.168.33.1"
module.MQTT_PORT = 1883
module.MQTT_SELF_ID = node.chipid()
module.MQTT_SELF_NAME = "N01"
module.MQTT_ENDPOINT = "/nodemcu/"
return module
