CREATE VIEW `v_activeinactivesensor` AS 
SELECT 
	* 
FROM 
	(SELECT 
		farm.code_user, 
		farm.code_farm, 
        farm.farmname, 
		MAX(farm.activesensor) AS activesensor, 
		MAX(farm.inactivesensor) AS inactivesensor 
	FROM 
		(SELECT 
			farm.code_user, 
			farm.code_farm, 
			farm.name AS farmname, 
			COALESCE((CASE soilsensor.active WHEN 'Y' THEN COUNT(*) END), 0) AS activesensor, 
			COALESCE((CASE soilsensor.active WHEN 'N' THEN COUNT(*) END), 0) AS inactivesensor 
		FROM 
			farm, 
			soilsensor 
		WHERE 
			farm.code_farm = soilsensor.code_farm 
		GROUP BY farm.code_farm, soilsensor.active
        ) farm
	GROUP BY farm.code_farm
    ) soilsensor