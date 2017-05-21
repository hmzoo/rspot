-- file : application.lua
local module = {}
m = nil
SELF_POINT=config.MQTT_ENDPOINT .. config.MQTT_SELF_NAME
SETD_POINT=SELF_POINT .. "/SD"
SETLED_POINT=SELF_POINT .. "/LED"

-- interrupteur
GPIO_INT=1
-- photoresitance
ADC_PHO=0
-- led
GPIO_LED=2


-- Sends gpio state
local function send_gpio_state(n)
  m:publish(SELF_POINT,"DS:" .. n .. ":" .. gpio.read(n),0,0)
end

-- Sends adc value
local function send_adc_value(n)
  m:publish(SELF_POINT,"VA:" .. n .. ":" .. adc.read(n),0,0)
end
-- trig function
local function trigint(level)
  send_gpio_state(GPIO_INT)
end
-- periodic function
local function tic()
  send_adc_value(ADC_PHO)
end

-- led function
local function setled(s)
  if(s=="1") then
    gpio.write(GPIO_LED,gpio.HIGH)
  else
    gpio.write(GPIO_LED,gpio.LOW)
  end
  send_gpio_state(GPIO_LED)
end

-- command function
local function cmd_sd(data)
  cmds=tools.split(data,":")
  print ("CMD SD:" .. cmds[0] .. ":" .. cmds[1])

  i= tonumber(cmds[0])
  gpio.mode(i,gpio.OUTPUT)
  if(cmds[1]=="1") then
    gpio.write(i,gpio.HIGH)
  else
    gpio.write(i,gpio.LOW)
  end

  send_gpio_state(i)
end

-- Sends my id to the broker for registration
local function register_myself()
  m:subscribe(SETD_POINT,0,function(conn)
      print("Successfully subscribed to SETD endpoint")
    end)

  m:subscribe(SETLED_POINT,0,function(conn)
      print("Successfully subscribed to SETLED endpoint")
    end)
end

local function mqtt_start()
  m = mqtt.Client(config.MQTT_SELF_ID, 120)
  -- register message callback beforehand
  m:on("message", function(conn, topic, data)

      if topic == SETD_POINT then
        cmd_sd(data)
      end

      if topic == SETLED_POINT then
        setled(data)
      end

      if data ~= nil then
        print(topic .. ": " .. data)
        -- do something, we have received a message
      end
    end)
  -- Connect to broker
  m:connect(config.MQTT_HOST, config.MQTT_PORT, 0, 1, function(con)
      print("connected to broker " .. config.MQTT_HOST .. ":" .. config.MQTT_PORT )
      print("self id: " .. config.MQTT_SELF_ID )
      print("self name: " .. config.MQTT_SELF_NAME )
      print("mqtt endpoint: " .. config.MQTT_ENDPOINT )
      register_myself()

      -- init gpio
      gpio.mode(GPIO_LED,gpio.OUTPUT)
      gpio.mode(GPIO_INT,gpio.INT)
      -- listen to switch
      gpio.trig(GPIO_INT, "both",trigint)

      -- And then pings each 1000 milliseconds
      tmr.stop(6)
      -- tmr.alarm(6, 1000, 1, send_ping)
      tmr.alarm(6, 1000, 1,tic)
      end,function(con,reason)
        tmr.stop(6)
        print(" can't connect to broker " .. config.MQTT_HOST .. ":" .. config.MQTT_PORT )
        print("reason :" .. reason )
      end)

  end

  function module.start()
    mqtt_start()
  end

  return module
