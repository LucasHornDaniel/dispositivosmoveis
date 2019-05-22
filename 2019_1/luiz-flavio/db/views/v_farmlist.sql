CREATE VIEW `v_farmlist` AS 
SELECT 
	farm.code_user, 
	farm.code_farm, 
	farm.name, 
	COALESCE(MAX(station.activestation),0) AS activestation, 
	COALESCE(MAX(station.inactivestation),0) AS inactivestation, 
    COALESCE(MAX(sensor.activesensor),0) AS activesensor, 
	COALESCE(MAX(sensor.inactivesensor),0) AS inactivesensor 
FROM 
	farm 
    LEFT OUTER JOIN 
	(SELECT 
		weatherstation.code_farm, 
        weatherstation.code_weatherstation, 
		COALESCE((CASE weatherstation.active WHEN 'Y' THEN COUNT(*) END), 0) AS activestation, 
		COALESCE((CASE weatherstation.active WHEN 'N' THEN COUNT(*) END), 0) AS inactivestation 
	FROM 
		weatherstation 
	GROUP BY weatherstation.code_farm, weatherstation.active
    ) station ON farm.code_farm <=> station.code_farm 
    LEFT OUTER JOIN 
    (SELECT 
		soilsensor.code_farm, 
        soilsensor.code_soilsensor, 
		COALESCE((CASE soilsensor.active WHEN 'Y' THEN COUNT(*) END), 0) AS activesensor, 
		COALESCE((CASE soilsensor.active WHEN 'N' THEN COUNT(*) END), 0) AS inactivesensor 
	FROM 
		soilsensor 
	GROUP BY soilsensor.code_farm, soilsensor.active
    ) sensor ON farm.code_farm <=> sensor.code_farm
GROUP BY farm.code_farm 