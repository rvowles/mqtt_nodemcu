
ledPin = 7

gpio.mode(7, gpio.OUTPUT)

ledMessage = function(message) 
    print("LED request "..message.."\n")
    if message == "on" then
      gpio.write(ledPin, gpio.HIGH)
    else
      gpio.write(7, gpio.LOW)
    end
end

ledRequest = function(client, topic, message)
  print("LED request ")
  print(message)
  print("\n")
  if message ~= nil then
    ledMessage(message)
  end
end

mqttClient = mqtt.Client("sausage", 120);
mqttClient:lwt("/led", "offline", 0, 0);

mqttConnected = function() 
  print("MQTT Connected\n")
  
  mqttClient:subscribe("/led", 0, function()
    print("mqtt subscribed\n");
  end)
end


mqttClient:on("message", ledRequest);


wifiConnected = function()
  print("Got ip"..wifi.sta.getip().."\n")
  mqttClient:connect("192.168.2.138", 1883, 0, mqttConnected);
end


wifiConnected = function()
  print("Got ip"..wifi.sta.getip())
end

print("connecting to wifi\n")

wifi.setmode(wifi.STATION);
wifi.sta.disconnect();
wifi.sta.config("KestevenKorner", "");
wifi.sta.eventMonReg(wifi.STA_GOTIP, wifiConnected);
wifi.sta.eventMonStart(100);
wifi.sta.connect();


