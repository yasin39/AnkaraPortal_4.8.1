<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Kayit.aspx.cs" Inherits="Portal.Personel.Kayit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!DOCTYPE html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Personel Kayıt Formu</title>

        <link href="../01_css/site.css" rel="stylesheet">
    </head>

    <body>
        <!-- Toast Container -->
        <div class="toast-container" id="toastContainer">
        </div>

        <div class="container my-4">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <!-- Header -->
                    <div class="card shadow-sm mb-4">
                        <div class="card-body text-center">
                            <h2 class="mb-1"><i class="bi bi-person-plus-fill"></i>Personel Kayıt Formu</h2>
                            <p class="text-muted">Personel bilgilerini ekleyin veya güncelleyin</p>
                        </div>
                    </div>

                    <form id="personelForm" novalidate>
                        <!-- Kimlik ve Temel Bilgiler -->
                        <div class="form-section">
                            <h4 class="section-title">
                                <i class="bi bi-person-vcard"></i>
                                Kimlik ve Temel Bilgiler
                            </h4>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="tcKimlik" class="form-label required-field">TC Kimlik No</label>
                                    <div class="input-group">
                                        <asp:TextBox ID="tcKimlik" runat="server" CssClass="form-control" MaxLength="11" ClientIDMode="Static" required="true"></asp:TextBox>
                                        <button class="btn btn-outline-primary" type="button" id="tcSorgula">
                                            <span class="loading-spinner spinner-border spinner-border-sm me-1" role="status"></span>
                                            <i class="bi bi-search"></i>Sorgula
                                        </button>
                                    </div>
                                    <div class="invalid-feedback">Geçerli bir TC Kimlik numarası giriniz.</div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="sicilNo" class="form-label required-field">Sicil No</label>
                                    <div class="input-group">
                                        <asp:TextBox ID="sicilNo" runat="server" CssClass="form-control" ClientIDMode="Static" required="true"></asp:TextBox>
                                        <button class="btn btn-outline-primary" type="button" id="sicilSorgula">
                                            <span class="loading-spinner spinner-border spinner-border-sm me-1" role="status"></span>
                                            <i class="bi bi-search"></i>Sorgula
                                        </button>
                                    </div>
                                    <div class="invalid-feedback">Sicil numarası zorunludur.</div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-8">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="ad" class="form-label required-field">Ad</label>
                                            <asp:TextBox ID="ad" runat="server" CssClass="form-control" ClientIDMode="Static" required="true"></asp:TextBox>
                                            <div class="invalid-feedback">Ad alanı zorunludur.</div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="soyad" class="form-label required-field">Soyad</label>
                                            <asp:TextBox ID="soyad" runat="server" CssClass="form-control" ClientIDMode="Static" required="true"></asp:TextBox>
                                            <div class="invalid-feedback">Soyad alanı zorunludur.</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="dogumYeri" class="form-label">Doğum Yeri</label>
                                            <asp:TextBox ID="dogumYeri" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="dogumTarihi" class="form-label">Doğum Tarihi</label>
                                            <asp:TextBox ID="dogumTarihi" runat="server" CssClass="form-control" TextMode="Date" ClientIDMode="Static"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="cinsiyet" class="form-label">Cinsiyet</label>
                                            <asp:DropDownList ID="cinsiyet" runat="server" CssClass="form-select" ClientIDMode="Static">
                                                <asp:ListItem Value="" Text="Seçiniz"></asp:ListItem>
                                                <asp:ListItem Value="E" Text="Erkek"></asp:ListItem>
                                                <asp:ListItem Value="K" Text="Kadın"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="kanGrubu" class="form-label">Kan Grubu</label>
                                            <asp:DropDownList ID="kanGrubu" runat="server" CssClass="form-select" ClientIDMode="Static">
                                                <asp:ListItem Value="" Text="Seçiniz"></asp:ListItem>
                                                <asp:ListItem Value="A+" Text="A Rh+"></asp:ListItem>
                                                <asp:ListItem Value="A-" Text="A Rh-"></asp:ListItem>
                                                <asp:ListItem Value="B+" Text="B Rh+"></asp:ListItem>
                                                <asp:ListItem Value="B-" Text="B Rh-"></asp:ListItem>
                                                <asp:ListItem Value="AB+" Text="AB Rh+"></asp:ListItem>
                                                <asp:ListItem Value="AB-" Text="AB Rh-"></asp:ListItem>
                                                <asp:ListItem Value="0+" Text="0 Rh+"></asp:ListItem>
                                                <asp:ListItem Value="0-" Text="0 Rh-"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <!-- İş Bilgileri -->
                        <div class="form-section">
                            <h4 class="section-title">
                                <i class="bi bi-briefcase"></i>
                                İş Bilgileri
                            </h4>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="ddlCalismaDurumu" class="form-label">Çalışma Durumu</label>
                                    <asp:DropDownList ID="ddlCalismaDurumu" runat="server" CssClass="form-select" ClientIDMode="Static">
                                        <asp:ListItem Value="" Text="Seçiniz"></asp:ListItem>
                                        <asp:ListItem Value="aktif" Text="Aktif"></asp:ListItem>
                                        <asp:ListItem Value="pasif" Text="Pasif"></asp:ListItem>
                                        <asp:ListItem Value="izinli" Text="İzinli"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="durum" class="form-label">Durum</label>
                                    <asp:DropDownList ID="durum" runat="server" CssClass="form-select" ClientIDMode="Static">
                                        <asp:ListItem Value="" Text="Seçiniz"></asp:ListItem>
                                        <asp:ListItem Value="gorevde" Text="Görevde"></asp:ListItem>
                                        <asp:ListItem Value="izinli" Text="İzinli"></asp:ListItem>
                                        <asp:ListItem Value="emekli" Text="Emekli"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="unvan" class="form-label required-field">Unvan</label>
                                    <asp:DropDownList ID="unvan" runat="server" CssClass="form-select" ClientIDMode="Static" required="true">
                                        <asp:ListItem Value="" Text="Seçiniz"></asp:ListItem>
                                        <asp:ListItem Value="memur" Text="Memur"></asp:ListItem>
                                        <asp:ListItem Value="uzman" Text="Uzman"></asp:ListItem>
                                        <asp:ListItem Value="mudurassistani" Text="Müdür Yardımcısı"></asp:ListItem>
                                        <asp:ListItem Value="mudur" Text="Müdür"></asp:ListItem>
                                    </asp:DropDownList>
                                    <div class="invalid-feedback">Unvan seçimi zorunludur.</div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="meslekiUnvan" class="form-label">Mesleki Unvan</label>
                                    <asp:TextBox ID="meslekiUnvan" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="statu" class="form-label">Statü</label>
                                    <asp:DropDownList ID="statu" runat="server" CssClass="form-select" ClientIDMode="Static">
                                        <asp:ListItem Value="" Text="Seçiniz"></asp:ListItem>
                                        <asp:ListItem Value="memur" Text="Memur"></asp:ListItem>
                                        <asp:ListItem Value="sozlesmeli" Text="Sözleşmeli"></asp:ListItem>
                                        <asp:ListItem Value="kadrolu" Text="Kadrolu"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="birim" class="form-label">Birim</label>
                                    <asp:DropDownList ID="birim" runat="server" CssClass="form-select" ClientIDMode="Static">
                                        <asp:ListItem Value="" Text="Seçiniz"></asp:ListItem>
                                        <asp:ListItem Value="idari" Text="İdari İşler"></asp:ListItem>
                                        <asp:ListItem Value="mali" Text="Mali İşler"></asp:ListItem>
                                        <asp:ListItem Value="teknik" Text="Teknik İşler"></asp:ListItem>
                                        <asp:ListItem Value="insankaynaklari" Text="İnsan Kaynakları"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="kurumBaslama" class="form-label required-field">Kuruma Başlama Tarihi</label>
                                    <asp:TextBox ID="kurumBaslama" runat="server" CssClass="form-control" TextMode="Date" ClientIDMode="Static" required="true"></asp:TextBox>
                                    <div class="invalid-feedback">Kuruma başlama tarihi zorunludur.</div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="ilkGiris" class="form-label">İlk Giriş Tarihi</label>
                                    <asp:TextBox ID="ilkGiris" runat="server" CssClass="form-control" TextMode="Date" ClientIDMode="Static"></asp:TextBox>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="kadroDerecesi" class="form-label">Kadro Derecesi</label>
                                    <asp:TextBox ID="kadroDerecesi" runat="server" CssClass="form-control" TextMode="Number" ClientIDMode="Static" min="1" max="20"></asp:TextBox>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="ogrenimDurumu" class="form-label">Öğrenim Durumu</label>
                                    <asp:DropDownList ID="ogrenimDurumu" runat="server" CssClass="form-select" ClientIDMode="Static">
                                        <asp:ListItem Value="" Text="Seçiniz"></asp:ListItem>
                                        <asp:ListItem Value="ilkokul" Text="İlkokul"></asp:ListItem>
                                        <asp:ListItem Value="ortaokul" Text="Ortaokul"></asp:ListItem>
                                        <asp:ListItem Value="lise" Text="Lise"></asp:ListItem>
                                        <asp:ListItem Value="onlisans" Text="Ön Lisans"></asp:ListItem>
                                        <asp:ListItem Value="lisans" Text="Lisans"></asp:ListItem>
                                        <asp:ListItem Value="yukseklisans" Text="Yüksek Lisans"></asp:ListItem>
                                        <asp:ListItem Value="doktora" Text="Doktora"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <!-- İletişim Bilgileri -->
                        <div class="form-section">
                            <h4 class="section-title">
                                <i class="bi bi-telephone"></i>
                                İletişim Bilgileri
                            </h4>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="ceptel" class="form-label required-field">Cep Telefonu</label>
                                    <asp:TextBox ID="ceptel" runat="server" CssClass="form-control" TextMode="Phone" ClientIDMode="Static" required="true" placeholder="0555 123 45 67"></asp:TextBox>
                                    <div class="invalid-feedback">Cep telefonu zorunludur ve geçerli formatta olmalıdır.</div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="evTel" class="form-label">Ev Telefonu</label>
                                    <asp:TextBox ID="evTel" runat="server" CssClass="form-control" TextMode="Phone" ClientIDMode="Static" placeholder="0312 123 45 67"></asp:TextBox>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="dahiliTel" class="form-label">Dahili Telefon</label>
                                    <asp:TextBox ID="dahiliTel" runat="server" CssClass="form-control" TextMode="Phone" ClientIDMode="Static" placeholder="1234"></asp:TextBox>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="email" class="form-label">E-posta</label>
                                    <asp:TextBox ID="email" runat="server" CssClass="form-control" TextMode="Email" ClientIDMode="Static" placeholder="ornek@domain.com"></asp:TextBox>
                                    <div class="invalid-feedback">Geçerli bir e-posta adresi giriniz.</div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="adres" class="form-label required-field">Adres</label>
                                <asp:TextBox ID="adres" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" ClientIDMode="Static" required="true" placeholder="Tam adres bilgisi"></asp:TextBox>
                                <div class="invalid-feedback">Adres bilgisi zorunludur.</div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="acilDurumKisi" class="form-label">Acil Durumda Aranacak Kişi</label>
                                    <asp:TextBox ID="acilDurumKisi" runat="server" CssClass="form-control" ClientIDMode="Static" placeholder="Ad Soyad"></asp:TextBox>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="acilDurumTel" class="form-label">Acil Durum Telefonu</label>
                                    <asp:TextBox ID="acilDurumTel" runat="server" CssClass="form-control" TextMode="Phone" ClientIDMode="Static" placeholder="0555 123 45 67"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- Diğer Bilgiler -->
                        <div class="form-section">
                            <h4 class="section-title">
                                <i class="bi bi-info-circle"></i>
                                Diğer Bilgiler
                            </h4>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="medeniHal" class="form-label">Medeni Hal</label>
                                    <asp:DropDownList ID="medeniHal" runat="server" CssClass="form-select" ClientIDMode="Static">
                                        <asp:ListItem Value="" Text="Seçiniz"></asp:ListItem>
                                        <asp:ListItem Value="bekar" Text="Bekar"></asp:ListItem>
                                        <asp:ListItem Value="evli" Text="Evli"></asp:ListItem>
                                        <asp:ListItem Value="bosanmis" Text="Boşanmış"></asp:ListItem>
                                        <asp:ListItem Value="dul" Text="Dul"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="askerlikDurumu" class="form-label">Askerlik Durumu</label>
                                    <asp:DropDownList ID="askerlikDurumu" runat="server" CssClass="form-select" ClientIDMode="Static">
                                        <asp:ListItem Value="" Text="Seçiniz"></asp:ListItem>
                                        <asp:ListItem Value="yapti" Text="Yaptı"></asp:ListItem>
                                        <asp:ListItem Value="muaf" Text="Muaf"></asp:ListItem>
                                        <asp:ListItem Value="tecilli" Text="Tecilli"></asp:ListItem>
                                        <asp:ListItem Value="yapmadi" Text="Yapmadı"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="engelDurumu" class="form-label">Engel Durumu</label>
                                    <asp:DropDownList ID="engelDurumu" runat="server" CssClass="form-select" ClientIDMode="Static">
                                        <asp:ListItem Value="" Text="Seçiniz"></asp:ListItem>
                                        <asp:ListItem Value="yok" Text="Yok"></asp:ListItem>
                                        <asp:ListItem Value="var" Text="Var"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="sendika" class="form-label">Sendika</label>
                                    <asp:DropDownList ID="sendika" runat="server" CssClass="form-select" ClientIDMode="Static">
                                        <asp:ListItem Value="" Text="Seçiniz"></asp:ListItem>
                                        <asp:ListItem Value="uye" Text="Üye"></asp:ListItem>
                                        <asp:ListItem Value="uyedeğil" Text="Üye Değil"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="engelAciklama" class="form-label">Engel Açıklaması</label>
                                <asp:TextBox ID="engelAciklama" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" ClientIDMode="Static" placeholder="Varsa engel durumu hakkında açıklama"></asp:TextBox>
                            </div>

                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label for="emeklilik" class="form-label">Emeklilik</label>
                                    <asp:TextBox ID="emeklilik" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label for="yaslilik" class="form-label">Yaşlılık</label>
                                    <asp:TextBox ID="yaslilik" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label for="emekliAciklama" class="form-label">Emekli Açıklama</label>
                                    <asp:TextBox ID="emekliAciklama" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- Form Butonları -->
                        <div class="btn-group-custom">
                            <div class="d-flex justify-content-center gap-3">
                                <button type="button" class="btn btn-success btn-lg" id="btnKaydet">
                                    <i class="bi bi-check-circle"></i>Kaydet
                                </button>
                                <button type="button" class="btn btn-primary btn-lg" id="btnGuncelle" style="display: none;">
                                    <i class="bi bi-arrow-repeat"></i>Güncelle
                                </button>
                                <button type="button" class="btn btn-info btn-lg" id="btnYazdir">
                                    <i class="bi bi-printer"></i>Yazdır
                                </button>
                                <button type="button" class="btn btn-secondary btn-lg" id="btnVazgec">
                                    <i class="bi bi-x-circle"></i>Vazgeç
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
       
        <!-- ==> SERVER-SIDE KONTROLLLER - HiddenField'lar ve Butonlar -->

        <!-- HiddenField'lar - Form verilerini taşımak için -->
        <asp:HiddenField ID="hdnPersonelData" runat="server" />
        <asp:HiddenField ID="hdnIslemTipi" runat="server" />
        <asp:HiddenField ID="hdnPersonelId" runat="server" />

        <!-- Server-side Butonlar (gizli) -->
        <asp:Button ID="btnHiddenKaydet" runat="server" OnClick="btnHiddenKaydet_Click" Style="display: none;" />
        <asp:Button ID="btnHiddenGuncelle" runat="server" OnClick="btnHiddenGuncelle_Click" Style="display: none;" />
        <asp:Button ID="btnHiddenTCSorgula" runat="server" OnClick="btnHiddenTCSorgula_Click" Style="display: none;" />
        <asp:Button ID="btnHiddenSicilSorgula" runat="server" OnClick="btnHiddenSicilSorgula_Click" Style="display: none;" />

        <!-- Sonuç mesajları için -->
        <asp:HiddenField ID="hdnSonucMesaji" runat="server" />
        <asp:HiddenField ID="hdnSonucTipi" runat="server" />

        <script src="../02_js/site.js"></script>

    </body>

</asp:Content>