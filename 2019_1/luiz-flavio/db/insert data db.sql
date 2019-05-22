#insert sensor data
SET @@global.time_zone = '+3:00';
insert into iot_project.datasoilsensor (code_soilsensor,datereceive,sensoridentifier,humidity) values 
(1, date_add(now(), interval 10 second), '3837CB32CC42', (rand()*10)+30);


SET @@global.time_zone = '+3:00';
insert into dataweatherstation (code_weatherstation,datereceive,stationidentifier,winddirection,windspeed,atmosphericpressure,waterevaporation,insolation,airhumidity,solarradiation,fluvialprecipitation,temperature,soiltemperature) 
values 
(1,date_add(now(), interval 10 second),'00E04C132BCE',RAND()*360,rand()*50,(rand()*100)+1000,rand()*100,'050000',rand()*100,(rand()*100)+1300,rand()*100,rand()*40,(rand()*10)+20);
