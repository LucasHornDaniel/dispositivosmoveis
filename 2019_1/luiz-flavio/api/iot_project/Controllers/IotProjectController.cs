using System;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;
using iot_project.Class;
using System.Globalization;

namespace iot_project.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class IotProjectController : ControllerBase
    {
        private DataQuery _dataQuery = new DataQuery();

        [HttpGet]
        public ActionResult<string> Get()
        {
            return "Specify the entry";
        }

        [HttpPost]
        public ActionResult<string> Post([FromBody] string value)
        {
            return "Specify the entry";
        }
        /*##############################################################*/

        [HttpGet("GetAllUsers", Name = "GetAllUsers")]
        public ActionResult<string> GetAllUsers()
        {
            string sql = "SELECT code_user, name, user FROM user";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetUser", Name = "GetUser")]
        public ActionResult<string> GetUser([FromBody] JObject form)
        {
            string idUser = form.GetValue("id").ToString();
            string sql = "SELECT code_user, name, user FROM user WHERE code_user=" + idUser + ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetUserLogin", Name = "GetUserLogin")]
        public ActionResult<string> GetUserLogin([FromBody] JObject form)
        {
            try
            {
                string username = form.GetValue("username").ToString();
                string password = form.GetValue("password").ToString();
                string sql = "SELECT code_user, name, user FROM user WHERE user='" + username + "' AND password=SHA2('" + password + "',512);";
                return _dataQuery.ExecuteQuery(sql);
            }
            catch (Exception exception)
            {
                return exception.Message;
            }
        }

        [HttpPost("UpdateUser", Name = "UpdateUser")]
        public ActionResult<bool> UpdateUser([FromBody] JObject form)
        {
            string idUser = form.GetValue("id").ToString();
            string name = form.GetValue("name").ToString();
            string user = form.GetValue("username").ToString();
            string password = form.GetValue("password").ToString();
            string sql = "UPDATE user SET name'" + name + "'  user='" + user + "', password=SHA2('" + password + "',512) WHERE code_user=" + idUser + ";";
            _dataQuery.ExecuteQuery(sql);
            return true;
        }

        [HttpPost("InsertUser", Name = "InsertUser")]
        public ActionResult<bool> InsertUser([FromBody] JObject form)
        {
            try
            {
                string name = form.GetValue("name").ToString();
                string username = form.GetValue("username").ToString();
                string password = form.GetValue("password").ToString();
                string sql = "INSERT INTO user (name,user,password) VALUES ('" + name + "','" + username + "',SHA2('" + password + "',512))";
                _dataQuery.ExecuteQuery(sql);
                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }

        [HttpPost("DeleteUser", Name = "DeleteUser")]
        public ActionResult<bool> DeleteUser([FromBody] JObject form)
        {
            string idUser = form.GetValue("id").ToString();
            string sql = "DELETE FROM user WHERE code_user=" + idUser + ";";
            _dataQuery.ExecuteQuery(sql);
            return true;
        }

        /*##############################################################*/
        /*##############################################################*/

        [HttpPost("GetFarm", Name = "GetFarm")]
        public ActionResult<string> GetFarm([FromBody] JObject form)
        {
            string idFarm = form.GetValue("id").ToString();

            string sql = "SELECT * FROM farm WHERE farm.code_farm=" + idFarm + ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetAllFarm", Name = "GetAllFarm")]
        public ActionResult<string> GetAllFarm([FromBody] JObject form)
        {
            string idUser = form.GetValue("id").ToString();
            
            string sql = @"SELECT 
	                        v_farmlist.code_farm, 
                            v_farmlist.name, 
                            v_farmlist.activesensor, 
                            v_farmlist.inactivesensor, 
                            v_farmlist.activestation, 
                            v_farmlist.inactivestation 
                        FROM 
	                        v_farmlist,  
	                        user 
                        WHERE 
	                        v_farmlist.code_user = user.code_user 
                            AND user.code_user = " + idUser;
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("InsertFarm", Name = "InsertFarm")]
        public ActionResult<bool> InsertFarm([FromBody] JObject form)
        {
            string idUser = form.GetValue("id").ToString();
            string name = form.GetValue("name").ToString();

            string sql = @"INSERT INTO 
	                            farm (code_user,name) 
                            VALUES 
	                            (" + idUser + ",'" + name + "') ";
            sql += ";";
            _dataQuery.ExecuteQuery(sql);
            return true;
        }

        /*##############################################################*/
        /*##############################################################*/

        [HttpPost("GetStation", Name = "GetStation")]
        public ActionResult<string> GetStation([FromBody] JObject form)
        {
            string idStation = form.GetValue("id").ToString();

            string sql = "SELECT * FROM weatherstation WHERE weatherstation.code_weatherstation=" + idStation + ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetAllStation", Name = "GetAllStation")]
        public ActionResult<string> GetAllStation([FromBody] JObject form)
        {
            string idFarm = form.GetValue("id").ToString();

            string sql = @"SELECT 
	                            weatherstation.code_farm, 
	                            weatherstation.code_weatherstation AS code_station, 
	                            weatherstation.name AS name, 
	                            weatherstation.stationidentifier AS identifier, 
	                            weatherstation.active AS active 
                            FROM 
	                            weatherstation 
                            WHERE 
	                            weatherstation.code_farm = " + idFarm;
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetAllStationU", Name = "GetAllStationU")]
        public ActionResult<string> GetAllStationU([FromBody] JObject form)
        {
            string idUser = form.GetValue("id").ToString();

            string sql = @"SELECT 
	                        weatherstation.code_weatherstation AS code_weatherstation, 
                            weatherstation.code_user AS code_user, 
                            weatherstation.name AS name, 
                            weatherstation.stationidentifier AS stationidentifier, 
                            weatherstation.active AS active 
                        FROM 
	                        dataweatherstation, 
                            weatherstation, 
                            user 
                        WHERE 
	                        weatherstation.code_user = user.code_user 
                            AND weatherstation.code_weatherstation = dataweatherstation.code_weatherstation 
                            AND user.code_user = " + idUser;
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("InsertStation", Name = "InsertStation")]
        public ActionResult<bool> InsertStation([FromBody] JObject form)
        {
            string idFarm = form.GetValue("id").ToString();
            string name = form.GetValue("name").ToString();
            string identifier = form.GetValue("identifier").ToString();
            string active = form.GetValue("active").ToString();

            string sql = @"INSERT INTO 
	                            weatherstation (code_farm,name,stationidentifier,active) 
                            VALUES 
	                            (" + idFarm + ",'"+name+"','"+identifier+"','"+active+"') ";
            sql += ";";
            _dataQuery.ExecuteQuery(sql);
            return true;
        }

        [HttpPost("UpdateStation", Name = "UpdateStation")]
        public ActionResult<bool> UpdateStation([FromBody] JObject form)
        {
            string idStation = form.GetValue("id").ToString();
            string name = form.GetValue("name").ToString();
            string identifier = form.GetValue("identifier").ToString();
            string active = form.GetValue("active").ToString();

            string sql = @"UPDATE 
	                            weatherstation 
                            SET 
	                            name='"+name+"', stationidentifier='"+identifier+"',active='"+active+@"' 
                            WHERE 
	                            weatherstation.code_weatherstation ="+idStation;
            sql += ";";
            _dataQuery.ExecuteQuery(sql);
            return true;
        }

        [HttpPost("UpdateStationState", Name = "UpdateStationState")]
        public ActionResult<bool> UpdateStationState([FromBody] JObject form)
        {
            string idStation = form.GetValue("id").ToString();
            string active = form.GetValue("active").ToString();

            string sql = @"UPDATE 
	                            weatherstation 
                            SET 
	                            active='" + active + @"' 
                            WHERE 
	                            weatherstation.code_weatherstation =" + idStation;
            sql += ";";
            _dataQuery.ExecuteQuery(sql);
            return true;
        }

        [HttpPost("DeleteStation", Name = "DeleteStation")]
        public ActionResult<bool> DeleteStation([FromBody] JObject form)
        {
            string idStation = form.GetValue("id").ToString();

            string sql = @"DELETE FROM 
	                            dataweatherstation 
                            WHERE 
	                            dataweatherstation.code_weatherstation ="+idStation;
            sql += ";";
            _dataQuery.ExecuteQuery(sql);

            sql = @"DELETE FROM 
                                weatherstation
                            WHERE
                                weatherstation.code_weatherstation ="+idStation;
            sql += ";";
            _dataQuery.ExecuteQuery(sql);
            return true;
        }

        [HttpPost("DeleteAllStation", Name = "DeleteAllStation")]
        public ActionResult<bool> DeleteAllStation([FromBody] JObject form)
        {
            string idUser = form.GetValue("id").ToString();

            string sql = @"DELETE FROM 
	                            dataweatherstation 
                            WHERE 
	                            dataweatherstation.code_weatherstation IN (
												                            SELECT 
													                            weatherstation.code_weatherstation 
												                            FROM 
													                            weatherstation 
												                            WHERE 
													                            weatherstation.code_user = " + idUser + ")";
            sql += ";";

            sql = @"DELETE FROM 
                                weatherstation 
                            WHERE 
                                weatherstation.code_user =" + idUser;
            sql += ";";
            _dataQuery.ExecuteQuery(sql);
            return true;
        }

        [HttpPost("SearchStation", Name = "SearchStation")]
        public ActionResult<string> SearchStation([FromBody] JObject form)
        {
            string idUser = form.GetValue("id").ToString();
            string term = form.GetValue("term").ToString();

            string sql = @"SELECT 
                                * 
                            FROM 
                                weatherstation 
                            WHERE 
                                weatherstation.code_user ="+idUser+@" 
                                AND(CONCAT(weatherstation.name, weatherstation.stationidentifier) LIKE '%"+term+"%' OR weatherstation.active = '"+term+"') ";
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetAllStationData", Name = "GetAllStationData")]
        public ActionResult<string> GetAllStationData([FromBody] JObject form)
        {
            string idStation = form.GetValue("id").ToString();

            string sql = @"SELECT 
	                            * 
                            FROM 
	                            dataweatherstation 
                            WHERE 
	                            dataweatherstation.code_weatherstation ="+idStation;
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }
        
        [HttpPost("GetSpecificStationData", Name = "GetSpecificStationData")]
        public ActionResult<string> GetSpecificStationData([FromBody] JObject form)
        {
            string idStation = form.GetValue("id").ToString();
            JObject information = JObject.Parse(form.GetValue("information").ToString());
            string sql = @"SELECT ";
            foreach (var info in information)
            {
                sql += info.Value;
                if (info.Key == information.Count.ToString())
                    sql += ',';

            }
            sql += ' ';
            sql += @"       FROM 
	                            dataweatherstation 
                            WHERE 
	                            dataweatherstation.code_weatherstation =" + idStation;
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetSpecificStationInformation", Name = "GetSpecificStationInformation")]
        public ActionResult<string> GetSpecificStationInformation([FromBody] JObject form)
        {
            string idStation = form.GetValue("id").ToString();
            JObject information = JObject.Parse(form.GetValue("information").ToString());
            string sql = @"SELECT ";
            foreach (var info in information)
            {
                sql += info.Value;
                if (info.Key == information.Count.ToString())
                    sql += ',';

            }
            sql += ' ';
            sql += @"       FROM 
	                            weatherstation 
                            WHERE 
	                            weatherstation.code_weatherstation =" + idStation;
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetStationDataSinceNow", Name = "GetStationDataSinceNow")]
        public ActionResult<string> GetStationDataSinceNow([FromBody] JObject form)
        {
            string idStation = form.GetValue("id").ToString();
            string date = form.GetValue("date").ToString();
            DateTime dateFormat = DateTime.ParseExact(date, "YYYY-MM-dd HH:mm:ss", new CultureInfo("de-DE"));
            string formattedDate = dateFormat.ToString("YYYY-MM-dd HH:mm:ss");

            string sql = @"SELECT 
	                            * 
                            FROM 
	                            dataweatherstation 
                            WHERE 
	                            dataweatherstation.code_weatherstation =" + idStation;
            sql += @"           AND DATE_FORMAT('" + formattedDate + "','%Y-%m-%d %H:%i:%s') >= dataweatherstation.datereceive AND DATE_FORMAT('" + formattedDate + "','%Y-%m-%d %H:%i:%s') < NOW() ";
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetSpecificStationDataSinceNow", Name = "GetSpecificStationDataSinceNow")]
        public ActionResult<string> GetSpecificStationDataSinceNow([FromBody] JObject form)
        {
            string idStation = form.GetValue("id").ToString();
            string date = form.GetValue("date").ToString();
            DateTime dateFormat = DateTime.ParseExact(date, "YYYY-MM-dd HH:mm:ss", new CultureInfo("de-DE"));
            string formattedDate = dateFormat.ToString("YYYY-MM-dd HH:mm:ss");
            JObject information = JObject.Parse(form.GetValue("information").ToString());

            string sql = @"SELECT ";
            foreach (var info in information)
            {
                sql += info.Value;
                if (info.Key == information.Count.ToString())
                    sql += ',';

            }
            sql += @"       FROM 
	                            dataweatherstation 
                            WHERE 
	                            dataweatherstation.code_weatherstation =" + idStation;
            sql += @"           AND DATE_FORMAT('" + formattedDate + "','%Y-%m-%d %H:%i:%s') >= dataweatherstation.datereceive AND DATE_FORMAT('" + formattedDate + "','%Y-%m-%d %H:%i:%s') < NOW() ";
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }
        
        [HttpPost("GetAverageStationSpecificData", Name = "GetAverageStationSpecificData")]
        public ActionResult<string> GetAverageStationSpecificData([FromBody] JObject form)
        {
            string idStation = form.GetValue("id").ToString();
            string period = form.GetValue("period").ToString();
            JObject information = JObject.Parse(form.GetValue("information").ToString());

            string sql = @"SELECT ";
            foreach (var info in information)
            {
                sql += " AVG("+ info.Value + ") AS "+info.Value+"_average ";
                if (info.Key != information.Count.ToString())
                    sql += ", ";

            }
            sql += @"       FROM 
	                            dataweatherstation 
                            WHERE 
                                dataweatherstation.datereceive >= DATE_SUB(NOW(),INTERVAL 1 "+ period.ToUpper() + @") 
                                AND dataweatherstation.code_weatherstation =" + idStation;
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetAverageStationSpecificDataBetween", Name = "GetAverageStationSpecificDataBetween")]
        public ActionResult<string> GetAverageStationSpecificDataBetween([FromBody] JObject form)
        {
            string idStation = form.GetValue("id").ToString();

            string startDateTime = form.GetValue("startdatetime").ToString();
            DateTime startDateFormat = DateTime.ParseExact(startDateTime, "YYYY-MM-dd HH:mm:ss", new CultureInfo("de-DE"));
            string startFormattedDate = startDateFormat.ToString("YYYY-MM-dd HH:mm:ss");

            string endDateTime = form.GetValue("enddatetime").ToString();
            DateTime endDateFormat = DateTime.ParseExact(endDateTime, "YYYY-MM-dd HH:mm:ss", new CultureInfo("de-DE"));
            string endFormattedDate = endDateFormat.ToString("YYYY-MM-dd HH:mm:ss");

            JObject information = JObject.Parse(form.GetValue("information").ToString());

            string sql = @"SELECT ";
            foreach (var info in information)
            {
                sql += " AVG(" + info.Value + ") AS " + info.Value + "_average ";
                if (info.Key == information.Count.ToString())
                    sql += ", ";

            }
            sql += @"       FROM 
	                            dataweatherstation 
                            WHERE 
	                            dataweatherstation.code_weatherstation =" + idStation;
            sql += @"           AND dataweatherstation.datereceive BETWEEN DATE_FORMAT('" + startFormattedDate + "','%Y-%m-%d %H:%i:%s') AND DATE_FORMAT('" + endFormattedDate + "','%Y-%m-%d %H:%i:%s') ";
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetStationLastData", Name = "GetStationLastData")]
        public ActionResult<string> GetStationLastData([FromBody] JObject form)
        {
            string idStation = form.GetValue("id").ToString();

            string sql = @"SELECT 
                                * 
                            FROM 
                                dataweatherstation 
                            WHERE 
                                dataweatherstation.code_weatherstation ="+ idStation + @" 
                            ORDER BY 
                                dataweatherstation.datereceive DESC 
                            LIMIT 1 ";
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetStationLastPeriodDateData", Name = "GetStationLastPeriodDateData")]
        public ActionResult<string> GetStationLastPeriodDateData([FromBody] JObject form)
        {
            string idStation = form.GetValue("id").ToString();

            string sql = @"SELECT 
	                            code_weatherstation, 
	                            datereceive, 
	                            stationidentifier, 
	                            winddirection DIV 1 AS winddirection, 
	                            windspeed DIV 1 AS windspeed, 
	                            atmosphericpressure DIV 1 AS atmosphericpressure, 
	                            waterevaporation DIV 1 AS waterevaporation, 
	                            insolation, 
	                            airhumidity DIV 1 AS airhumidity, 
	                            solarradiation DIV 1 AS solarradiation, 
	                            fluvialprecipitation DIV 1 AS fluvialprecipitation, 
	                            temperature DIV 1 AS temperature, 
	                            soiltemperature DIV 1 AS soiltemperature 
                            FROM 
	                            dataweatherstation 
                            WHERE 
	                            dataweatherstation.code_weatherstation =" + idStation + @" 
                            ORDER BY 
	                            dataweatherstation.datereceive DESC 
                            LIMIT 15 ";
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetStationSpecificLastData", Name = "GetStationSpecificLastData")]
        public ActionResult<string> GetStationSpecificLastData([FromBody] JObject form)
        {
            string idStation = form.GetValue("id").ToString();
            JObject information = JObject.Parse(form.GetValue("information").ToString());

            string sql = @"SELECT ";
            foreach (var info in information)
            {
                sql += info.Value;
                if (info.Key == information.Count.ToString())
                    sql += ", ";

            }
            sql += @"       FROM
                                dataweatherstation 
                            WHERE 
                                dataweatherstation.code_weatherstation =" + idStation + @" 
                            ORDER BY 
                                dataweatherstation.datereceive DESC 
                            LIMIT 1 ";
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        /*##############################################################*/
        /*##############################################################*/

        [HttpPost("GetSensor", Name = "GetSensor")]
        public ActionResult<string> GetSensor([FromBody] JObject form)
        {
            string idSensor = form.GetValue("id").ToString();

            string sql = "SELECT * FROM soilsensor WHERE soilsensor.code_soilsensor=" + idSensor + ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetAllSensor", Name = "GetAllSensor")]
        public ActionResult<string> GetAllSensor([FromBody] JObject form)
        {
            string idFarm = form.GetValue("id").ToString();

            string sql = @"SELECT 
	                            soilsensor.code_farm, 
                                soilsensor.code_soilsensor AS code_sensor, 
                                soilsensor.name, 
                                soilsensor.sensoridentifier AS identifier, 
                                soilsensor.active 
                            FROM 
	                            soilsensor 
                            WHERE 
	                            soilsensor.code_farm = " + idFarm;
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("InsertSensor", Name = "InsertSensor")]
        public ActionResult<bool> InsertSensor([FromBody] JObject form)
        {
            string idFarm = form.GetValue("id").ToString();
            string name = form.GetValue("name").ToString();
            string identifier = form.GetValue("identifier").ToString();
            string active = form.GetValue("active").ToString();

            string sql = @"INSERT INTO 
	                            soilsensor (code_farm,name,sensoridentifier,active) 
                            VALUES 
	                            (" + idFarm + ",'" + name + "','" + identifier + "','" + active + "') ";
            sql += ";";
            _dataQuery.ExecuteQuery(sql);
            return true;
        }

        [HttpPost("UpdateSensor", Name = "UpdateSensor")]
        public ActionResult<bool> UpdateSensor([FromBody] JObject form)
        {
            string idSensor = form.GetValue("id").ToString();
            string name = form.GetValue("name").ToString();
            string identifier = form.GetValue("identifier").ToString();
            string active = form.GetValue("active").ToString();

            string sql = @"UPDATE 
	                            soilsensor 
                            SET 
	                            name='" + name + "', stationidentifier='" + identifier + "',active='" + active + @"' 
                            WHERE 
	                            soilsensor.code_soilsensor =" + idSensor;
            sql += ";";
            _dataQuery.ExecuteQuery(sql);
            return true;
        }

        [HttpPost("UpdateSensorState", Name = "UpdateSensorState")]
        public ActionResult<bool> UpdateSensorState([FromBody] JObject form)
        {
            string idSensor = form.GetValue("id").ToString();
            string active = form.GetValue("active").ToString();

            string sql = @"UPDATE 
	                            soilsensor 
                            SET 
	                            active='" + active + @"' 
                            WHERE 
	                            soilsensor.code_soilsensor =" + idSensor;
            sql += ";";
            _dataQuery.ExecuteQuery(sql);
            return true;
        }

        [HttpPost("DeleteSensor", Name = "DeleteSensor")]
        public ActionResult<bool> DeleteSensor([FromBody] JObject form)
        {
            string idSensor = form.GetValue("id").ToString();

            string sql = @"DELETE FROM 
	                            datasoilsensor 
                            WHERE 
	                            datasoilsensor.code_soilsensor =" + idSensor;
            sql += ";";
            _dataQuery.ExecuteQuery(sql);

            sql = @"DELETE FROM 
                                soilsensor
                            WHERE
                                soilsensor.code_soilsensor =" + idSensor;
            sql += ";";
            _dataQuery.ExecuteQuery(sql);
            return true;
        }

        [HttpPost("DeleteAllSensor", Name = "DeleteAllSensor")]
        public ActionResult<bool> DeleteAllSensor([FromBody] JObject form)
        {
            string idUser = form.GetValue("id").ToString();

            string sql = @"DELETE FROM 
	                            datasoilsensor 
                            WHERE 
	                            datasoilsensor.code_soilsensor IN (
												                            SELECT 
													                            soilsensor.code_soilsensor 
												                            FROM 
													                            soilsensor 
												                            WHERE 
													                            soilsensor.code_user = " + idUser + ")";
            sql += ";";

            sql = @"DELETE FROM 
                                soilsensor 
                            WHERE 
                                soilsensor.code_user =" + idUser;
            sql += ";";
            _dataQuery.ExecuteQuery(sql);
            return true;
        }

        [HttpPost("SearchSensor", Name = "SearchSensor")]
        public ActionResult<string> SearchSensor([FromBody] JObject form)
        {
            string idUser = form.GetValue("id").ToString();
            string term = form.GetValue("term").ToString();

            string sql = @"SELECT 
                                * 
                            FROM 
                                soilsensor 
                            WHERE 
                                soilsensor.code_user =" + idUser + @" 
                                AND(CONCAT(soilsensor.name, soilsensor.sensoridentifier) LIKE '%" + term + "%' OR soilsensor.active = '" + term + "') ";
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetAllSensorData", Name = "GetAllSensorData")]
        public ActionResult<string> GetAllSensorData([FromBody] JObject form)
        {
            string idSensor = form.GetValue("id").ToString();

            string sql = @"SELECT 
	                            * 
                            FROM 
	                            datasoilsensor 
                            WHERE 
	                            datasoilsensor.code_soilsensor =" + idSensor;
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetSpecificSensorData", Name = "GetSpecificSensorData")]
        public ActionResult<string> GetSpecificSensorData([FromBody] JObject form)
        {
            string idSensor = form.GetValue("id").ToString();
            JObject information = JObject.Parse(form.GetValue("information").ToString());
            string sql = @"SELECT ";
            foreach (var info in information)
            {
                sql += info.Value;
                if (info.Key == information.Count.ToString())
                    sql += ',';

            }
            sql += ' ';
            sql += @"       FROM 
	                            datasoilsensor 
                            WHERE 
	                            datasoilsensor.code_soilsensor =" + idSensor;
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetSpecificSensorInformation", Name = "GetSpecificSensorInformation")]
        public ActionResult<string> GetSpecificSensorInformation([FromBody] JObject form)
        {
            string idSensor = form.GetValue("id").ToString();
            JObject information = JObject.Parse(form.GetValue("information").ToString());
            string sql = @"SELECT ";
            foreach (var info in information)
            {
                sql += info.Value;
                if (info.Key == information.Count.ToString())
                    sql += ',';

            }
            sql += ' ';
            sql += @"       FROM 
	                            soilsensor 
                            WHERE 
	                            soilsensor.code_soilsensor =" + idSensor;
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetSensorDataSinceNow", Name = "GetSensorDataSinceNow")]
        public ActionResult<string> GetSensorDataSinceNow([FromBody] JObject form)
        {
            string idSensor = form.GetValue("id").ToString();
            string date = form.GetValue("date").ToString();
            DateTime dateFormat = DateTime.ParseExact(date, "YYYY-MM-dd HH:mm:ss", new CultureInfo("de-DE"));
            string formattedDate = dateFormat.ToString("YYYY-MM-dd HH:mm:ss");

            string sql = @"SELECT 
	                            * 
                            FROM 
	                            datasoilsensor 
                            WHERE 
	                            datasoilsensor.code_soilsensor =" + idSensor;
            sql += @"           AND DATE_FORMAT('" + formattedDate + "','%Y-%m-%d %H:%i:%s') >= datasoilsensor.datereceive AND DATE_FORMAT('" + formattedDate + "','%Y-%m-%d %H:%i:%s') < NOW() ";
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetSpecificSensorDataSinceNow", Name = "GetSpecificSensorDataSinceNow")]
        public ActionResult<string> GetSpecificSensorDataSinceNow([FromBody] JObject form)
        {
            string idSensor = form.GetValue("id").ToString();
            string date = form.GetValue("date").ToString();
            DateTime dateFormat = DateTime.ParseExact(date, "YYYY-MM-dd HH:mm:ss", new CultureInfo("de-DE"));
            string formattedDate = dateFormat.ToString("YYYY-MM-dd HH:mm:ss");
            JObject information = JObject.Parse(form.GetValue("information").ToString());

            string sql = @"SELECT ";
            foreach (var info in information)
            {
                sql += info.Value;
                if (info.Key == information.Count.ToString())
                    sql += ',';

            }
            sql += @"       FROM 
	                            datasoilsensor 
                            WHERE 
	                            datasoilsensor.code_soilsensor =" + idSensor;
            sql += @"           AND DATE_FORMAT('" + formattedDate + "','%Y-%m-%d %H:%i:%s') >= datasoilsensor.datereceive AND DATE_FORMAT('" + formattedDate + "','%Y-%m-%d %H:%i:%s') < NOW() ";
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetAverageSensorSpecificData", Name = "GetAverageSensorSpecificData")]
        public ActionResult<string> GetAverageSensorSpecificData([FromBody] JObject form)
        {
            string idSensor = form.GetValue("id").ToString();
            string period = form.GetValue("period").ToString();
            JObject information = JObject.Parse(form.GetValue("information").ToString());

            string sql = @"SELECT ";
            foreach (var info in information)
            {
                sql += " AVG(" + info.Value + ") AS " + info.Value + "_average ";
                if (info.Key != information.Count.ToString())
                    sql += ", ";

            }
            sql += @"       FROM 
	                            datasoilsensor 
                            WHERE 
                                datasoilsensor.datereceive >= DATE_SUB(NOW(),INTERVAL 1 " + period.ToUpper() + @") 
	                            AND datasoilsensor.code_soilsensor =" + idSensor;
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetAverageSensorSpecificDataBetween", Name = "GetAverageSensorSpecificDataBetween")]
        public ActionResult<string> GetAverageSensorSpecificDataBetween([FromBody] JObject form)
        {
            string idSensor = form.GetValue("id").ToString();

            string startDateTime = form.GetValue("startdatetime").ToString();
            DateTime startDateFormat = DateTime.ParseExact(startDateTime, "YYYY-MM-dd HH:mm:ss", new CultureInfo("de-DE"));
            string startFormattedDate = startDateFormat.ToString("YYYY-MM-dd HH:mm:ss");

            string endDateTime = form.GetValue("enddatetime").ToString();
            DateTime endDateFormat = DateTime.ParseExact(endDateTime, "YYYY-MM-dd HH:mm:ss", new CultureInfo("de-DE"));
            string endFormattedDate = endDateFormat.ToString("YYYY-MM-dd HH:mm:ss");

            JObject information = JObject.Parse(form.GetValue("information").ToString());

            string sql = @"SELECT ";
            foreach (var info in information)
            {
                sql += " AVG(" + info.Value + ") AS " + info.Value + "_average ";
                if (info.Key == information.Count.ToString())
                    sql += ", ";

            }
            sql += @"       FROM 
	                            datasoilsensor 
                            WHERE 
	                            datasoilsensor.code_soilsensor =" + idSensor;
            sql += @"           AND datasoilsensor.datereceive BETWEEN DATE_FORMAT('" + startFormattedDate + "','%Y-%m-%d %H:%i:%s') AND DATE_FORMAT('" + endFormattedDate + "','%Y-%m-%d %H:%i:%s') ";
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetSensorLastData", Name = "GetSensorLastData")]
        public ActionResult<string> GetSensorLastData([FromBody] JObject form)
        {
            string idSensor = form.GetValue("id").ToString();

            string sql = @"SELECT 
                                * 
                            FROM 
                                datasoilsensor 
                            WHERE 
                                datasoilsensor.code_soilsensor =" + idSensor + @" 
                            ORDER BY 
                                datasoilsensor.datereceive DESC 
                            LIMIT 1 ";
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        /*
        [HttpPost("GetLastPeriodSensorData", Name = "GetLastPeriodSensorData")]
        public ActionResult<string> GetLastPeriodSensorData([FromBody] JObject form)
        {
            string idSensor = form.GetValue("id").ToString();

            string sql = @"SELECT 
	                            * 
                            FROM 
	                            (
                                SELECT 
		                            @rownum:=@rownum + 1 AS 'index', 
                                    datasoilsensor.humidity AS value 
	                            FROM 
		                            datasoilsensor, 
                                    (SELECT @rownum:=0) r 
	                            WHERE 
		                            datasoilsensor.code_soilsensor =" + idSensor + @"  
	                            ORDER BY 
		                            datasoilsensor.datereceive DESC 
                                LIMIT 10
                                ) datasensor  ";
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }*/

        [HttpPost("GetLastPeriodSensorData", Name = "GetLastPeriodSensorData")]
        public ActionResult<string> GetLastPeriodSensorData([FromBody] JObject form)
        {
            string idSensor = form.GetValue("id").ToString();

            string sql = @"SELECT 
	                            datasoilsensor.humidity DIV 1 AS value 
                            FROM 
	                            datasoilsensor 
                            WHERE 
	                            datasoilsensor.code_soilsensor =" + idSensor + @" 
                            ORDER BY 
	                            datasoilsensor.datereceive DESC 
                            LIMIT 10 ";
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetLastPeriodSensorDateData", Name = "GetLastPeriodSensorDateData")]
        public ActionResult<string> GetLastPeriodSensorDateData([FromBody] JObject form)
        {
            string idSensor = form.GetValue("id").ToString();

            string sql = @"SELECT 
								datasoilsensor.datereceive AS 'date', 
	                            datasoilsensor.humidity DIV 1 AS value 
                            FROM 
	                            datasoilsensor 
                            WHERE 
	                            datasoilsensor.code_soilsensor =" + idSensor + @" 
                            ORDER BY 
	                            datasoilsensor.datereceive DESC 
                            LIMIT 15 ";
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        }

        [HttpPost("GetSensorSpecificLastData", Name = "GetSensorSpecificLastData")]
        public ActionResult<string> GetSensorSpecificLastData([FromBody] JObject form)
        {
            string idSensor = form.GetValue("id").ToString();
            JObject information = JObject.Parse(form.GetValue("information").ToString());

            string sql = @"SELECT ";
            foreach (var info in information)
            {
                sql += info.Value;
                if (info.Key == information.Count.ToString())
                    sql += ", ";

            }
            sql += @"       FROM
                                datasoilsensor 
                            WHERE 
                                datasoilsensor.code_soilsensor =" + idSensor + @" 
                            ORDER BY 
                                datasoilsensor.datereceive DESC 
                            LIMIT 1 ";
            sql += ";";
            return _dataQuery.ExecuteQuery(sql);
        } 

    }
}
