CREATE VIEW `v_farmlistinfo` AS 
SELECT 
	* 
FROM 
	(SELECT 
		COALESCE(v_activeinactivestation.code_user, v_activeinactivesensor.code_user) AS code_user,
        COALESCE(v_activeinactivestation.code_farm, v_activeinactivesensor.code_farm) AS code_farm,
        COALESCE(v_activeinactivestation.farmname, v_activeinactivesensor.farmname) AS farmname,
        COALESCE(v_activeinactivesensor.activesensor, 0) AS activesensor,
        COALESCE(v_activeinactivesensor.inactivesensor, 0) AS inactivesensor,
        COALESCE(v_activeinactivestation.activestation, 0) AS activestation,
        COALESCE(v_activeinactivestation.inactivestation, 0) AS inactivestation 
	FROM 
		v_activeinactivesensor RIGHT JOIN v_activeinactivestation 
        ON 
		v_activeinactivesensor.code_farm=v_activeinactivestation.code_farm
	) sensorstation