using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;

namespace Portal.Personel
{
    public partial class Liste : System.Web.UI.Page
    {
        // ==> Connection string - kendi veritabanı bağlantınızı kullanın
        private string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PersonelListesiniYukle();
            }
        }

        #region Ana Metodlar

        private void PersonelListesiniYukle()
        {
            try
            {
                DataTable dt = PersonelVerileriniGetir();

                gvPersonel.DataSource = dt;
                gvPersonel.DataBind();

                // ==> Toplam kayıt sayısını güncelle
                lblToplamKayit.Text = $"Toplam: {dt.Rows.Count} kayıt";

                // ==> Sayfalama bilgisini güncelle
                GuncelleSayfaBilgisi();
            }
            catch (Exception ex)
            {
                ShowToast($"Hata: {ex.Message}", "error");
            }
        }

        private DataTable PersonelVerileriniGetir()
        {
            DataTable dt = new DataTable();

            // ==> SQL sorgusu - kendi tablo yapınıza göre güncelleyin
            string sql = @"
                SELECT 
                    ID,
                    SicilNo,
                    TCKimlik,
                    Ad,
                    Soyad,
                    Unvan,
                    Birim,
                    CepTel,
                    Email,
                    CalismaDurumu,
                    Fotograf,
                    KayitTarihi
                FROM Personel 
                WHERE 1=1";

            // ==> Filtreleme koşulları ekle
            List<SqlParameter> parameters = new List<SqlParameter>();

            if (!string.IsNullOrEmpty(txtArama.Text.Trim()))
            {
                sql += " AND (Ad LIKE @Arama OR Soyad LIKE @Arama OR TCKimlik LIKE @Arama OR SicilNo LIKE @Arama)";
                parameters.Add(new SqlParameter("@Arama", $"%{txtArama.Text.Trim()}%"));
            }

            if (!string.IsNullOrEmpty(ddlBirim.SelectedValue))
            {
                sql += " AND Birim = @Birim";
                parameters.Add(new SqlParameter("@Birim", ddlBirim.SelectedValue));
            }

            if (!string.IsNullOrEmpty(ddlUnvan.SelectedValue))
            {
                sql += " AND Unvan = @Unvan";
                parameters.Add(new SqlParameter("@Unvan", ddlUnvan.SelectedValue));
            }

            if (!string.IsNullOrEmpty(ddlDurum.SelectedValue))
            {
                sql += " AND CalismaDurumu = @Durum";
                parameters.Add(new SqlParameter("@Durum", ddlDurum.SelectedValue));
            }

            sql += " ORDER BY Ad, Soyad";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddRange(parameters.ToArray());
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }

            return dt;
        }

        #endregion

        #region Event Handler'lar

        protected void btnAra_Click(object sender, EventArgs e)
        {
            gvPersonel.PageIndex = 0; // ==> İlk sayfaya dön
            PersonelListesiniYukle();
        }

        protected void Filtrele(object sender, EventArgs e)
        {
            gvPersonel.PageIndex = 0; // ==> İlk sayfaya dön
            PersonelListesiniYukle();
        }

        protected void btnTemizle_Click(object sender, EventArgs e)
        {
            // ==> Tüm filtreleri temizle
            txtArama.Text = "";
            ddlBirim.SelectedIndex = 0;
            ddlUnvan.SelectedIndex = 0;
            ddlDurum.SelectedIndex = 0;

            gvPersonel.PageIndex = 0;
            PersonelListesiniYukle();
        }

        protected void btnExcel_Click(object sender, EventArgs e)
        {
            try
            {
                // ==> Excel'e aktarma işlemi
                ExcelAktar();
            }
            catch (Exception ex)
            {
                ShowToast($"Excel aktarımında hata: {ex.Message}", "error");
            }
        }

        protected void SayfaBoyutuDegisti(object sender, EventArgs e)
        {
            // ==> Sayfa boyutunu güncelle
            gvPersonel.PageSize = Convert.ToInt32(ddlSayfaBoyutu.SelectedValue);
            gvPersonel.PageIndex = 0;
            PersonelListesiniYukle();
        }

        #endregion

        #region GridView Event'leri

        protected void gvPersonel_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvPersonel.PageIndex = e.NewPageIndex;
            PersonelListesiniYukle();
        }

        protected void gvPersonel_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string personelId = e.CommandArgument.ToString();

            switch (e.CommandName)
            {
                case "Goruntule":
                    Response.Redirect($"Detay.aspx?id={personelId}");
                    break;

                case "Duzenle":
                    Response.Redirect($"Kayit.aspx?id={personelId}");
                    break;

                case "Sil":
                    PersonelSil(personelId);
                    break;
            }
        }

        protected void gvPersonel_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // ==> Burada ek row işlemleri yapabilirsiniz
            }

            if (e.Row.RowType == DataControlRowType.Pager)
            {
                // ==> Sayfalama bilgisini güncelle
                Label lblSayfaBilgi = e.Row.FindControl("lblSayfaBilgi") as Label;
                if (lblSayfaBilgi != null)
                {
                    int baslangic = (gvPersonel.PageIndex * gvPersonel.PageSize) + 1;
                    int bitis = Math.Min((gvPersonel.PageIndex + 1) * gvPersonel.PageSize, GetToplamKayitSayisi());
                    int toplam = GetToplamKayitSayisi();

                    lblSayfaBilgi.Text = $"{baslangic}-{bitis} / {toplam} kayıt";
                }
            }
        }

        #endregion

        #region Yardımcı Metodlar

        protected string GetPhotoUrl(object fotograf)
        {
            if (fotograf == null || fotograf == DBNull.Value || string.IsNullOrEmpty(fotograf.ToString()))
            {
                return "~/Images/default-avatar.png"; // ==> Varsayılan avatar
            }
            return $"~/Uploads/Photos/{fotograf}";
        }

        protected string GetStatusBadgeClass(string durum)
        {
            switch (durum?.ToLower())
            {
                case "aktif":
                    return "badge bg-success status-badge";
                case "pasif":
                    return "badge bg-secondary status-badge";
                case "izinli":
                    return "badge bg-warning status-badge";
                default:
                    return "badge bg-light text-dark status-badge";
            }
        }

        protected string GetStatusText(string durum)
        {
            switch (durum?.ToLower())
            {
                case "aktif":
                    return "Aktif";
                case "pasif":
                    return "Pasif";
                case "izinli":
                    return "İzinli";
                default:
                    return durum ?? "Belirsiz";
            }
        }

        protected string GetPageNumbers()
        {
            StringBuilder sb = new StringBuilder();
            int currentPage = gvPersonel.PageIndex + 1;
            int totalPages = gvPersonel.PageCount;

            // ==> Sayfa numaralarını oluştur (basit versiyon)
            int startPage = Math.Max(1, currentPage - 2);
            int endPage = Math.Min(totalPages, currentPage + 2);

            for (int i = startPage; i <= endPage; i++)
            {
                string activeClass = i == currentPage ? "active" : "";
                sb.AppendFormat(@"
                    <li class='page-item {0}'>
                        <a class='page-link' href='javascript:__doPostBack(""gvPersonel"",""Page${1}"")'>{2}</a>
                    </li>",
                    activeClass, i, i);
            }

            return sb.ToString();
        }

        private void PersonelSil(string personelId)
        {
            try
            {
                string sql = "DELETE FROM Personel WHERE ID = @ID";

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@ID", personelId);
                        conn.Open();

                        int etkilenenSatir = cmd.ExecuteNonQuery();

                        if (etkilenenSatir > 0)
                        {
                            ShowToast("Personel başarıyla silindi.", "success");
                            PersonelListesiniYukle(); // ==> Listeyi yenile
                        }
                        else
                        {
                            ShowToast("Personel silinemedi.", "error");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowToast($"Silme işleminde hata: {ex.Message}", "error");
            }
        }

        private void ExcelAktar()
        {
            DataTable dt = PersonelVerileriniGetir();

            // ==> Basit CSV formatında export (Excel için)
            StringBuilder csv = new StringBuilder();

            // ==> Header
            csv.AppendLine("Sicil No,TC Kimlik,Ad,Soyad,Unvan,Birim,Cep Tel,Email,Durum");

            // ==> Data rows
            foreach (DataRow row in dt.Rows)
            {
                csv.AppendLine($"{row["SicilNo"]},{row["TCKimlik"]},{row["Ad"]},{row["Soyad"]},{row["Unvan"]},{row["Birim"]},{row["CepTel"]},{row["Email"]},{row["CalismaDurumu"]}");
            }

            // ==> Download
            Response.Clear();
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("Content-Disposition", $"attachment;filename=PersonelListesi_{DateTime.Now:yyyyMMdd}.csv");
            Response.Write(csv.ToString());
            Response.End();
        }

        private int GetToplamKayitSayisi()
        {
            // ==> Bu metod GridView'daki toplam kayıt sayısını döndürür
            if (ViewState["ToplamKayit"] != null)
                return (int)ViewState["ToplamKayit"];

            return PersonelVerileriniGetir().Rows.Count;
        }

        private void GuncelleSayfaBilgisi()
        {
            int toplamKayit = GetToplamKayitSayisi();
            ViewState["ToplamKayit"] = toplamKayit;
        }

        private void ShowToast(string message, string type = "info")
        {
            // ==> JavaScript ile toast göstermek için
            string script = $@"
                document.getElementById('toastMessage').innerText = '{message}';
                document.getElementById('liveToast').className = 'toast bg-{(type == "error" ? "danger" : type)}';
                new bootstrap.Toast(document.getElementById('liveToast')).show();
            ";

            ClientScript.RegisterStartupScript(this.GetType(), "ShowToast", script, true);
        }

        #endregion
    }
}