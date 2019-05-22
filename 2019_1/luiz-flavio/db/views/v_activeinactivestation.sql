CREATE VIEW `v_activeinactivestation` AS 
SELECT 
	* 
FROM 
	(SELECT 
		farm.code_user, 
		farm.code_farm, 
        farm.farmname, 
		MAX(activestation) AS activestation, 
		MAX(inactivestation) AS inactivestation 
	FROM 
	(SELECT 
		farm.code_user, 
		farm.code_farm, 
        farm.name AS farmname, 
		COALESCE((CASE weatherstation.active WHEN 'Y' THEN COUNT(*) END), 0) AS activestation, 
		COALESCE((CASE weatherstation.active WHEN 'N' THEN COUNT(*) END), 0) AS inactivestation 
	FROM 
		farm, 
		weatherstation 
	WHERE 
		farm.code_farm = weatherstation.code_farm 
	GROUP BY farm.code_farm, weatherstation.active) farm
	GROUP BY farm.code_farm
    ) weatherstation 