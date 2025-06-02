using System;
using System.Data;
using System.Data.SqlClient;
using Portal.Helpers;

namespace Portal.Personel
{
    public class PersonelDAL
    {
        /// <summary>
        /// Yeni personel kaydı ekler
        /// </summary>
        /// <param name="personel">PersonelModel nesnesi</param>
        /// <returns>Eklenen personelin ID'si</returns>
        public static int PersonelEkle(PersonelModel personel)
        {
            string query = @"
                INSERT INTO Personeller (
                    TCKimlikNo, SicilNo, Ad, Soyad, DogumYeri, DogumTarihi, Cinsiyet, KanGrubu, FotografYolu,
                    CalismaDurumu, Durum, Unvan, MeslekiUnvan, Statu, Birim, KurumaBaslamaTarihi, IlkGirisTarihi, 
                    KadroDerecesi, OgrenimDurumu, CepTelefonu, EvTelefonu, DahiliTelefon, Email, Adres, 
                    AcilDurumKisi, AcilDurumTelefonu, MedeniHal, AskerlikDurumu, EngelDurumu, EngelAciklamasi, 
                    Sendika, Emeklilik, Yaslilik, EmekliAciklamasi, KaydedenKullanici, Aktif
                ) VALUES (
                    @TCKimlikNo, @SicilNo, @Ad, @Soyad, @DogumYeri, @DogumTarihi, @Cinsiyet, @KanGrubu, @FotografYolu,
                    @CalismaDurumu, @Durum, @Unvan, @MeslekiUnvan, @Statu, @Birim, @KurumaBaslamaTarihi, @IlkGirisTarihi,
                    @KadroDerecesi, @OgrenimDurumu, @CepTelefonu, @EvTelefonu, @DahiliTelefon, @Email, @Adres,
                    @AcilDurumKisi, @AcilDurumTelefonu, @MedeniHal, @AskerlikDurumu, @EngelDurumu, @EngelAciklamasi,
                    @Sendika, @Emeklilik, @Yaslilik, @EmekliAciklamasi, @KaydedenKullanici, @Aktif
                );
                SELECT SCOPE_IDENTITY();";

            SqlParameter[] parameters = CreatePersonelParameters(personel);

            object result = DatabaseHelper.ExecuteScalar(query, parameters);
            return Convert.ToInt32(result);
        }

        /// <summary>
        /// Personel bilgilerini günceller
        /// </summary>
        /// <param name="personel">Güncellenmiş PersonelModel nesnesi</param>
        /// <returns>Güncellenen satır sayısı</returns>
        public static int PersonelGuncelle(PersonelModel personel)
        {
            string query = @"
                UPDATE Personeller SET 
                    TCKimlikNo = @TCKimlikNo, SicilNo = @SicilNo, Ad = @Ad, Soyad = @Soyad, 
                    DogumYeri = @DogumYeri, DogumTarihi = @DogumTarihi, Cinsiyet = @Cinsiyet, 
                    KanGrubu = @KanGrubu, FotografYolu = @FotografYolu, CalismaDurumu = @CalismaDurumu,
                    Durum = @Durum, Unvan = @Unvan, MeslekiUnvan = @MeslekiUnvan, Statu = @Statu,
                    Birim = @Birim, KurumaBaslamaTarihi = @KurumaBaslamaTarihi, IlkGirisTarihi = @IlkGirisTarihi,
                    KadroDerecesi = @KadroDerecesi, OgrenimDurumu = @OgrenimDurumu, CepTelefonu = @CepTelefonu,
                    EvTelefonu = @EvTelefonu, DahiliTelefon = @DahiliTelefon, Email = @Email, Adres = @Adres,
                    AcilDurumKisi = @AcilDurumKisi, AcilDurumTelefonu = @AcilDurumTelefonu, MedeniHal = @MedeniHal,
                    AskerlikDurumu = @AskerlikDurumu, EngelDurumu = @EngelDurumu, EngelAciklamasi = @EngelAciklamasi,
                    Sendika = @Sendika, Emeklilik = @Emeklilik, Yaslilik = @Yaslilik, EmekliAciklamasi = @EmekliAciklamasi,
                    GuncellemeTarihi = GETDATE(), GuncelleyenKullanici = @GuncelleyenKullanici, Aktif = @Aktif
                WHERE PersonelID = @PersonelID";

            SqlParameter[] parameters = CreatePersonelParameters(personel);
            Array.Resize(ref parameters, parameters.Length + 1);
            parameters[parameters.Length - 1] = new SqlParameter("@PersonelID", personel.PersonelID);

            return DatabaseHelper.ExecuteNonQuery(query, parameters);
        }

        /// <summary>
        /// TC Kimlik numarasına göre personel sorgular
        /// </summary>
        /// <param name="tcKimlik">TC Kimlik numarası</param>
        /// <returns>PersonelModel nesnesi (bulunamazsa null)</returns>
        public static PersonelModel GetPersonelByTC(string tcKimlik)
        {
            string query = "SELECT * FROM Personeller WHERE TCKimlikNo = @TCKimlik AND Aktif = 1";
            SqlParameter[] parameters = {
                new SqlParameter("@TCKimlik", tcKimlik)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);

            if (dt.Rows.Count > 0)
                return DataRowToPersonelModel(dt.Rows[0]);

            return null;
        }

        /// <summary>
        /// Sicil numarasına göre personel sorgular
        /// </summary>
        /// <param name="sicilNo">Sicil numarası</param>
        /// <returns>PersonelModel nesnesi (bulunamazsa null)</returns>
        public static PersonelModel GetPersonelBySicil(string sicilNo)
        {
            string query = "SELECT * FROM Personeller WHERE SicilNo = @SicilNo AND Aktif = 1";
            SqlParameter[] parameters = {
                new SqlParameter("@SicilNo", sicilNo)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);

            if (dt.Rows.Count > 0)
                return DataRowToPersonelModel(dt.Rows[0]);

            return null;
        }

        /// <summary>
        /// PersonelID'ye göre personel sorgular
        /// </summary>
        /// <param name="personelId">Personel ID</param>
        /// <returns>PersonelModel nesnesi (bulunamazsa null)</returns>
        public static PersonelModel GetPersonelByID(int personelId)
        {
            string query = "SELECT * FROM Personeller WHERE PersonelID = @PersonelID AND Aktif = 1";
            SqlParameter[] parameters = {
                new SqlParameter("@PersonelID", personelId)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);

            if (dt.Rows.Count > 0)
                return DataRowToPersonelModel(dt.Rows[0]);

            return null;
        }

        /// <summary>
        /// TC Kimlik numarasının sistemde kayıtlı olup olmadığını kontrol eder
        /// </summary>
        /// <param name="tcKimlik">TC Kimlik numarası</param>
        /// <param name="excludePersonelId">Hariç tutulacak PersonelID (güncelleme işlemlerinde)</param>
        /// <returns>true: kayıtlı, false: kayıtlı değil</returns>
        public static bool IsTCKimlikExists(string tcKimlik, int excludePersonelId = 0)
        {
            string query = "SELECT COUNT(*) FROM Personeller WHERE TCKimlikNo = @TCKimlik AND Aktif = 1";

            if (excludePersonelId > 0)
                query += " AND PersonelID != @PersonelID";

            SqlParameter[] parameters = excludePersonelId > 0 ?
                new SqlParameter[] {
                    new SqlParameter("@TCKimlik", tcKimlik),
                    new SqlParameter("@PersonelID", excludePersonelId)
                } :
                new SqlParameter[] {
                    new SqlParameter("@TCKimlik", tcKimlik)
                };

            object result = DatabaseHelper.ExecuteScalar(query, parameters);
            return Convert.ToInt32(result) > 0;
        }

        /// <summary>
        /// Sicil numarasının sistemde kayıtlı olup olmadığını kontrol eder
        /// </summary>
        /// <param name="sicilNo">Sicil numarası</param>
        /// <param name="excludePersonelId">Hariç tutulacak PersonelID (güncelleme işlemlerinde)</param>
        /// <returns>true: kayıtlı, false: kayıtlı değil</returns>
        public static bool IsSicilNoExists(string sicilNo, int excludePersonelId = 0)
        {
            string query = "SELECT COUNT(*) FROM Personeller WHERE SicilNo = @SicilNo AND Aktif = 1";

            if (excludePersonelId > 0)
                query += " AND PersonelID != @PersonelID";

            SqlParameter[] parameters = excludePersonelId > 0 ?
                new SqlParameter[] {
                    new SqlParameter("@SicilNo", sicilNo),
                    new SqlParameter("@PersonelID", excludePersonelId)
                } :
                new SqlParameter[] {
                    new SqlParameter("@SicilNo", sicilNo)
                };

            object result = DatabaseHelper.ExecuteScalar(query, parameters);
            return Convert.ToInt32(result) > 0;
        }

        /// <summary>
        /// PersonelModel nesnesi için SQL parametrelerini oluşturur
        /// </summary>
        /// <param name="personel">PersonelModel nesnesi</param>
        /// <returns>SqlParameter dizisi</returns>
        private static SqlParameter[] CreatePersonelParameters(PersonelModel personel)
        {
            return new SqlParameter[]
            {
                new SqlParameter("@TCKimlikNo", personel.TCKimlikNo ?? (object)DBNull.Value),
                new SqlParameter("@SicilNo", personel.SicilNo ?? (object)DBNull.Value),
                new SqlParameter("@Ad", personel.Ad ?? (object)DBNull.Value),
                new SqlParameter("@Soyad", personel.Soyad ?? (object)DBNull.Value),
                new SqlParameter("@DogumYeri", personel.DogumYeri ?? (object)DBNull.Value),
                new SqlParameter("@DogumTarihi", personel.DogumTarihi ?? (object)DBNull.Value),
                new SqlParameter("@Cinsiyet", personel.Cinsiyet ?? (object)DBNull.Value),
                new SqlParameter("@KanGrubu", personel.KanGrubu ?? (object)DBNull.Value),
                new SqlParameter("@FotografYolu", personel.FotografYolu ?? (object)DBNull.Value),
                new SqlParameter("@CalismaDurumu", personel.CalismaDurumu ?? (object)DBNull.Value),
                new SqlParameter("@Durum", personel.Durum ?? (object)DBNull.Value),
                new SqlParameter("@Unvan", personel.Unvan ?? (object)DBNull.Value),
                new SqlParameter("@MeslekiUnvan", personel.MeslekiUnvan ?? (object)DBNull.Value),
                new SqlParameter("@Statu", personel.Statu ?? (object)DBNull.Value),
                new SqlParameter("@Birim", personel.Birim ?? (object)DBNull.Value),
                new SqlParameter("@KurumaBaslamaTarihi", personel.KurumaBaslamaTarihi),
                new SqlParameter("@IlkGirisTarihi", personel.IlkGirisTarihi ?? (object)DBNull.Value),
                new SqlParameter("@KadroDerecesi", personel.KadroDerecesi ?? (object)DBNull.Value),
                new SqlParameter("@OgrenimDurumu", personel.OgrenimDurumu ?? (object)DBNull.Value),
                new SqlParameter("@CepTelefonu", personel.CepTelefonu ?? (object)DBNull.Value),
                new SqlParameter("@EvTelefonu", personel.EvTelefonu ?? (object)DBNull.Value),
                new SqlParameter("@DahiliTelefon", personel.DahiliTelefon ?? (object)DBNull.Value),
                new SqlParameter("@Email", personel.Email ?? (object)DBNull.Value),
                new SqlParameter("@Adres", personel.Adres ?? (object)DBNull.Value),
                new SqlParameter("@AcilDurumKisi", personel.AcilDurumKisi ?? (object)DBNull.Value),
                new SqlParameter("@AcilDurumTelefonu", personel.AcilDurumTelefonu ?? (object)DBNull.Value),
                new SqlParameter("@MedeniHal", personel.MedeniHal ?? (object)DBNull.Value),
                new SqlParameter("@AskerlikDurumu", personel.AskerlikDurumu ?? (object)DBNull.Value),
                new SqlParameter("@EngelDurumu", personel.EngelDurumu ?? (object)DBNull.Value),
                new SqlParameter("@EngelAciklamasi", personel.EngelAciklamasi ?? (object)DBNull.Value),
                new SqlParameter("@Sendika", personel.Sendika ?? (object)DBNull.Value),
                new SqlParameter("@Emeklilik", personel.Emeklilik ?? (object)DBNull.Value),
                new SqlParameter("@Yaslilik", personel.Yaslilik ?? (object)DBNull.Value),
                new SqlParameter("@EmekliAciklamasi", personel.EmekliAciklamasi ?? (object)DBNull.Value),
                new SqlParameter("@KaydedenKullanici", personel.KaydedenKullanici ?? (object)DBNull.Value),
                new SqlParameter("@GuncelleyenKullanici", personel.GuncelleyenKullanici ?? (object)DBNull.Value),
                new SqlParameter("@Aktif", personel.Aktif)
            };
        }

        /// <summary>
        /// DataRow'u PersonelModel nesnesine dönüştürür
        /// </summary>
        /// <param name="row">DataRow nesnesi</param>
        /// <returns>PersonelModel nesnesi</returns>
        private static PersonelModel DataRowToPersonelModel(DataRow row)
        {
            return new PersonelModel
            {
                PersonelID = Convert.ToInt32(row["PersonelID"]),
                TCKimlikNo = row["TCKimlikNo"].ToString(),
                SicilNo = row["SicilNo"].ToString(),
                Ad = row["Ad"].ToString(),
                Soyad = row["Soyad"].ToString(),
                DogumYeri = row["DogumYeri"] == DBNull.Value ? null : row["DogumYeri"].ToString(),
                DogumTarihi = row["DogumTarihi"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(row["DogumTarihi"]),
                Cinsiyet = row["Cinsiyet"] == DBNull.Value ? null : row["Cinsiyet"].ToString(),
                KanGrubu = row["KanGrubu"] == DBNull.Value ? null : row["KanGrubu"].ToString(),
                FotografYolu = row["FotografYolu"] == DBNull.Value ? null : row["FotografYolu"].ToString(),
                CalismaDurumu = row["CalismaDurumu"] == DBNull.Value ? null : row["CalismaDurumu"].ToString(),
                Durum = row["Durum"] == DBNull.Value ? null : row["Durum"].ToString(),
                Unvan = row["Unvan"].ToString(),
                MeslekiUnvan = row["MeslekiUnvan"] == DBNull.Value ? null : row["MeslekiUnvan"].ToString(),
                Statu = row["Statu"] == DBNull.Value ? null : row["Statu"].ToString(),
                Birim = row["Birim"] == DBNull.Value ? null : row["Birim"].ToString(),
                KurumaBaslamaTarihi = Convert.ToDateTime(row["KurumaBaslamaTarihi"]),
                IlkGirisTarihi = row["IlkGirisTarihi"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(row["IlkGirisTarihi"]),
                KadroDerecesi = row["KadroDerecesi"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["KadroDerecesi"]),
                OgrenimDurumu = row["OgrenimDurumu"] == DBNull.Value ? null : row["OgrenimDurumu"].ToString(),
                CepTelefonu = row["CepTelefonu"].ToString(),
                EvTelefonu = row["EvTelefonu"] == DBNull.Value ? null : row["EvTelefonu"].ToString(),
                DahiliTelefon = row["DahiliTelefon"] == DBNull.Value ? null : row["DahiliTelefon"].ToString(),
                Email = row["Email"] == DBNull.Value ? null : row["Email"].ToString(),
                Adres = row["Adres"].ToString(),
                AcilDurumKisi = row["AcilDurumKisi"] == DBNull.Value ? null : row["AcilDurumKisi"].ToString(),
                AcilDurumTelefonu = row["AcilDurumTelefonu"] == DBNull.Value ? null : row["AcilDurumTelefonu"].ToString(),
                MedeniHal = row["MedeniHal"] == DBNull.Value ? null : row["MedeniHal"].ToString(),
                AskerlikDurumu = row["AskerlikDurumu"] == DBNull.Value ? null : row["AskerlikDurumu"].ToString(),
                EngelDurumu = row["EngelDurumu"] == DBNull.Value ? null : row["EngelDurumu"].ToString(),
                EngelAciklamasi = row["EngelAciklamasi"] == DBNull.Value ? null : row["EngelAciklamasi"].ToString(),
                Sendika = row["Sendika"] == DBNull.Value ? null : row["Sendika"].ToString(),
                Emeklilik = row["Emeklilik"] == DBNull.Value ? null : row["Emeklilik"].ToString(),
                Yaslilik = row["Yaslilik"] == DBNull.Value ? null : row["Yaslilik"].ToString(),
                EmekliAciklamasi = row["EmekliAciklamasi"] == DBNull.Value ? null : row["EmekliAciklamasi"].ToString(),
                KayitTarihi = Convert.ToDateTime(row["KayitTarihi"]),
                GuncellemeTarihi = row["GuncellemeTarihi"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(row["GuncellemeTarihi"]),
                KaydedenKullanici = row["KaydedenKullanici"] == DBNull.Value ? null : row["KaydedenKullanici"].ToString(),
                GuncelleyenKullanici = row["GuncelleyenKullanici"] == DBNull.Value ? null : row["GuncelleyenKullanici"].ToString(),
                Aktif = Convert.ToBoolean(row["Aktif"])
            };
        }
    }
}