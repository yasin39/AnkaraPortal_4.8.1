using System;

namespace Portal.Personel
{
    public class PersonelModel
    {
        // Primary Key
        public int PersonelID { get; set; }

        // Kimlik ve Temel Bilgiler
        public string TCKimlikNo { get; set; }
        public string SicilNo { get; set; }
        public string Ad { get; set; }
        public string Soyad { get; set; }
        public string DogumYeri { get; set; }
        public DateTime? DogumTarihi { get; set; }
        public string Cinsiyet { get; set; }
        public string KanGrubu { get; set; }
        public string FotografYolu { get; set; }

        // İş Bilgileri
        public string CalismaDurumu { get; set; }
        public string Durum { get; set; }
        public string Unvan { get; set; }
        public string MeslekiUnvan { get; set; }
        public string Statu { get; set; }
        public string Birim { get; set; }
        public DateTime KurumaBaslamaTarihi { get; set; }
        public DateTime? IlkGirisTarihi { get; set; }
        public int? KadroDerecesi { get; set; }
        public string OgrenimDurumu { get; set; }

        // İletişim Bilgileri
        public string CepTelefonu { get; set; }
        public string EvTelefonu { get; set; }
        public string DahiliTelefon { get; set; }
        public string Email { get; set; }
        public string Adres { get; set; }
        public string AcilDurumKisi { get; set; }
        public string AcilDurumTelefonu { get; set; }

        // Diğer Bilgiler
        public string MedeniHal { get; set; }
        public string AskerlikDurumu { get; set; }
        public string EngelDurumu { get; set; }
        public string EngelAciklamasi { get; set; }
        public string Sendika { get; set; }
        public string Emeklilik { get; set; }
        public string Yaslilik { get; set; }
        public string EmekliAciklamasi { get; set; }

        // Sistem Alanları
        public DateTime KayitTarihi { get; set; }
        public DateTime? GuncellemeTarihi { get; set; }
        public string KaydedenKullanici { get; set; }
        public string GuncelleyenKullanici { get; set; }
        public bool Aktif { get; set; }

        // Constructor
        public PersonelModel()
        {
            KayitTarihi = DateTime.Now;
            Aktif = true;
        }

        /// <summary>
        /// TC Kimlik numarasının geçerliliğini kontrol eder
        /// </summary>
        /// <returns>true/false</returns>
        public bool IsTCKimlikValid()
        {
            if (string.IsNullOrEmpty(TCKimlikNo) || TCKimlikNo.Length != 11)
                return false;

            // Sadece rakam kontrolü
            foreach (char c in TCKimlikNo)
            {
                if (!char.IsDigit(c))
                    return false;
            }

            // İlk rakam 0 olamaz
            if (TCKimlikNo[0] == '0')
                return false;

            // TC Kimlik algoritması kontrolü
            int[] digits = new int[11];
            for (int i = 0; i < 11; i++)
            {
                digits[i] = int.Parse(TCKimlikNo[i].ToString());
            }

            int tekToplam = digits[0] + digits[2] + digits[4] + digits[6] + digits[8];
            int ciftToplam = digits[1] + digits[3] + digits[5] + digits[7];

            int kontrol1 = ((tekToplam * 7) - ciftToplam) % 10;
            int kontrol2 = (tekToplam + ciftToplam + digits[9]) % 10;

            return (kontrol1 == digits[9] && kontrol2 == digits[10]);
        }

        /// <summary>
        /// E-mail formatının geçerliliğini kontrol eder
        /// </summary>
        /// <returns>true/false</returns>
        public bool IsEmailValid()
        {
            if (string.IsNullOrEmpty(Email))
                return true; // E-mail zorunlu değil

            try
            {
                var addr = new System.Net.Mail.MailAddress(Email);
                return addr.Address == Email;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// Telefon numarasının formatını kontrol eder
        /// </summary>
        /// <param name="phoneNumber">Telefon numarası</param>
        /// <returns>true/false</returns>
        public static bool IsPhoneNumberValid(string phoneNumber)
        {
            if (string.IsNullOrEmpty(phoneNumber))
                return false;

            // Sadece rakam, boşluk, tire ve parantez karakterlerine izin ver
            string cleanPhone = phoneNumber.Replace(" ", "").Replace("-", "").Replace("(", "").Replace(")", "");

            if (cleanPhone.Length < 10 || cleanPhone.Length > 11)
                return false;

            foreach (char c in cleanPhone)
            {
                if (!char.IsDigit(c))
                    return false;
            }

            return true;
        }

        /// <summary>
        /// Zorunlu alanların dolu olup olmadığını kontrol eder
        /// </summary>
        /// <returns>Hata mesajları listesi (boşsa geçerli)</returns>
        public string[] ValidateRequiredFields()
        {
            var errors = new System.Collections.Generic.List<string>();

            if (string.IsNullOrEmpty(TCKimlikNo))
                errors.Add("TC Kimlik No zorunludur.");
            else if (!IsTCKimlikValid())
                errors.Add("TC Kimlik No geçersizdir.");

            if (string.IsNullOrEmpty(SicilNo))
                errors.Add("Sicil No zorunludur.");

            if (string.IsNullOrEmpty(Ad))
                errors.Add("Ad zorunludur.");

            if (string.IsNullOrEmpty(Soyad))
                errors.Add("Soyad zorunludur.");

            if (string.IsNullOrEmpty(Unvan))
                errors.Add("Unvan zorunludur.");

            if (KurumaBaslamaTarihi == DateTime.MinValue)
                errors.Add("Kuruma başlama tarihi zorunludur.");

            if (string.IsNullOrEmpty(CepTelefonu))
                errors.Add("Cep telefonu zorunludur.");
            else if (!IsPhoneNumberValid(CepTelefonu))
                errors.Add("Cep telefonu formatı geçersizdir.");

            if (string.IsNullOrEmpty(Adres))
                errors.Add("Adres zorunludur.");

            if (!IsEmailValid())
                errors.Add("E-mail formatı geçersizdir.");

            return errors.ToArray();
        }

        /// <summary>
        /// Ad ve Soyad birleşik olarak döndürür
        /// </summary>
        public string AdSoyad
        {
            get { return $"{Ad} {Soyad}".Trim(); }
        }

        /// <summary>
        /// Personelin aktif olup olmadığını döndürür
        /// </summary>
        public bool IsActive
        {
            get { return Aktif && CalismaDurumu == "aktif"; }
        }
    }
}