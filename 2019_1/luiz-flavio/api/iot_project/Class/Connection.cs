using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;

namespace iot_project.Class
{
    public class Connection
    {
        private readonly string _stringConnection = "SERVER=localhost;DATABASE=iot_project;UID=iotprojectutf;PASSWORD=utfIotProject;";
        //private readonly string _stringConnection = "SERVER=mysql7001.site4now.net;DATABASE=db_a43205_tklist;UID=a43205_tklist;PASSWORD=HWF8h334h;";
        public MySqlConnection _connection;

        public Connection()
        {
            OpenConnection();
        }

        public void OpenConnection()
        {
            if(_connection == null || _connection.State != ConnectionState.Open)
            {
                _connection = new MySqlConnection(_stringConnection);
                _connection.Open();
            }
        }

        public void CloseConnection()
        {
            _connection.Close();
        }

    }
}
