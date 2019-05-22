using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using MySql.Data;
using MySql.Data.MySqlClient;
using Newtonsoft.Json.Linq;
using System.Web;
using Newtonsoft.Json;

namespace iot_project.Class
{

    public class DataQuery
    {
        private MySqlCommand _command;
        private List<JObject> _oResult;
        private String _oFinalResult;
        private JObject _oRow;
        private MySqlDataReader _dataReader;
        private string _sqlQuery;
        private Connection _connection;

        public string ExecuteQuery(string SqlQuery)
        {
            //inicialize variables
            _oResult = new List<JObject>();
            _sqlQuery = SqlQuery;

            //inicialize connection
            _connection = new Connection();
            _connection.OpenConnection();

            //create mysql command
            InicializeCommand();
            
            //execute query
            ExecuteQuery();

            //put return in data reader to _oResult
            PrepareResultToReturn();

            //return results
            return _oFinalResult;
        }

        private void PrepareResultToReturn()
        {
            //se não tiver linhas de resultado, retorna
            if (_dataReader == null || !_dataReader.HasRows)
            {
                _oFinalResult = "OK";
                return;
            }

            while (_dataReader.Read())
            {
                _oRow = new JObject();
                for (int i = 0; i < _dataReader.FieldCount; i++)
                {
                    _oRow.Add(_dataReader.GetName(i), _dataReader.GetValue(i).ToString());
                }
                _oResult.Add(_oRow);
            }

            _oFinalResult = JsonConvert.SerializeObject(_oResult, Formatting.None);
        }

        private void ExecuteQuery()
        {
            try
            {
                _dataReader = _command.ExecuteReader();
            }
            catch (Exception exception)
            {
                Console.WriteLine(exception.Message);
            }
        }

        private void InicializeCommand()
        {
            _command = new MySqlCommand();
            _command.Connection = _connection._connection;
            _command.CommandText = _sqlQuery;
        }
    }
}
