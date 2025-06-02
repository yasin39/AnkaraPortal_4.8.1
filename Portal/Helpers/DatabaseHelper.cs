using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Portal.Helpers
{
    public class DatabaseHelper
    {
        private static string connectionString = ConfigurationManager.ConnectionStrings["Laptop"].ConnectionString;

        /// <summary>
        /// Yeni bir SQL bağlantısı oluşturur
        /// </summary>
        /// <returns>SqlConnection nesnesi</returns>
        public static SqlConnection GetConnection()
        {
            return new SqlConnection(connectionString);
        }

        /// <summary>
        /// Parametreli SQL sorgusu çalıştırır ve DataTable döndürür
        /// </summary>
        /// <param name="query">SQL sorgusu</param>
        /// <param name="parameters">SQL parametreleri</param>
        /// <returns>DataTable</returns>
        public static DataTable ExecuteQuery(string query, params SqlParameter[] parameters)
        {
            DataTable dataTable = new DataTable();

            try
            {
                using (SqlConnection connection = GetConnection())
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Parametreleri ekle
                        if (parameters != null)
                        {
                            command.Parameters.AddRange(parameters);
                        }

                        using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                        {
                            connection.Open();
                            adapter.Fill(dataTable);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Hata loglanabilir veya üst katmana fırlatılabilir
                throw new Exception("Veritabanı sorgu hatası: " + ex.Message, ex);
            }

            return dataTable;
        }

        /// <summary>
        /// Parametreli SQL komutu çalıştırır (INSERT, UPDATE, DELETE)
        /// </summary>
        /// <param name="query">SQL komutu</param>
        /// <param name="parameters">SQL parametreleri</param>
        /// <returns>Etkilenen satır sayısı</returns>
        public static int ExecuteNonQuery(string query, params SqlParameter[] parameters)
        {
            int rowsAffected = 0;

            try
            {
                using (SqlConnection connection = GetConnection())
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Parametreleri ekle
                        if (parameters != null)
                        {
                            command.Parameters.AddRange(parameters);
                        }

                        connection.Open();
                        rowsAffected = command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Veritabanı komut hatası: " + ex.Message, ex);
            }

            return rowsAffected;
        }

        /// <summary>
        /// Parametreli SQL sorgusu çalıştırır ve tek bir değer döndürür
        /// </summary>
        /// <param name="query">SQL sorgusu</param>
        /// <param name="parameters">SQL parametreleri</param>
        /// <returns>object (null olabilir)</returns>
        public static object ExecuteScalar(string query, params SqlParameter[] parameters)
        {
            object result = null;

            try
            {
                using (SqlConnection connection = GetConnection())
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Parametreleri ekle
                        if (parameters != null)
                        {
                            command.Parameters.AddRange(parameters);
                        }

                        connection.Open();
                        result = command.ExecuteScalar();
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Veritabanı skalar sorgu hatası: " + ex.Message, ex);
            }

            return result;
        }

        /// <summary>
        /// Bağlantı testini yapar
        /// </summary>
        /// <returns>true/false</returns>
        public static bool TestConnection()
        {
            try
            {
                using (SqlConnection connection = GetConnection())
                {
                    connection.Open();
                    return true;
                }
            }
            catch
            {
                return false;
            }
        }
    }
}