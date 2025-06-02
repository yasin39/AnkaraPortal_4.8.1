<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Kayit2.aspx.cs" Inherits="Portal.Personel.Kayit2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../01_css/site.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- ==> ScriptManager eklendi AJAX işlemleri için -->
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>

    <div class="container my-4">
        <!-- Toast Container -->
        <div class="toast-container position-fixed top-0 end-0 p-3" id="toastContainer">
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-10">
                <!-- Header -->
                <div class="card shadow-sm mb-4">
                    <div class="card-body text-center">
                        <h2 class="mb-1"><i class="bi bi-person-plus-fill"></i>Personel Kayıt Formu</h2>
                        <p class="text-muted">Personel bilgilerini ekleyin veya güncelleyin</p>
                    </div>
                </div>

                <!-- ==> UpdatePanel ile AJAX desteği -->
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <!-- Kimlik ve Temel Bilgiler -->
                        <div class="form-section">
                            <h4 class="section-title">
                                <i class="bi bi-person-vcard"></i>
                                Kimlik ve Temel Bilgiler
                            </h4>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="<%= txtTCKimlik.ClientID %>" class="form-label required-field">TC Kimlik No</label>
                                    <div class="input-group">
                                        <!-- ==> HTML input yerine ASP.NET TextBox -->
                                        <asp:TextBox ID="txtTCKimlik" runat="server" CssClass="form-control" MaxLength="11" placeholder="11 haneli TC Kimlik No"></asp:TextBox>
                                        <asp:Button ID="btnTCSorgula" runat="server" CssClass="btn btn-outline-primary" Text="Sorgula" OnClientClick="return tcSorgulaJS(); return false;" />
                                    </div>
                                    <div class="invalid-feedback">Geçerli bir TC Kimlik numarası giriniz.</div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="<%= txtSicilNo.ClientID %>" class="form-label required-field">Sicil No</label>
                                    <div class="input-group">
                                        <!-- ==> HTML input yerine ASP.NET TextBox -->
                                        <asp:TextBox ID="txtSicilNo" runat="server" CssClass="form-control" placeholder="Sicil numarası"></asp:TextBox>
                                        <asp:Button ID="btnSicilSorgula" runat="server" CssClass="btn btn-outline-primary" Text="Sorgula" OnClientClick="return sicilSorgulaJS(); return false;" />
                                    </div>
                                    <div class="invalid-feedback">Sicil numarası zorunludur.</div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-8">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="<%= txtAd.ClientID %>" class="form-label required-field">Ad</label>
                                            <!-- ==> HTML input yerine ASP.NET TextBox -->
                                            <asp:TextBox ID="txtAd" runat="server" CssClass="form-control" placeholder="Ad"></asp:TextBox>
                                            <div class="invalid-feedback">Ad alanı zorunludur.</div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="<%= txtSoyad.ClientID %>" class="form-label required-field">Soyad</label>
                                            <!-- ==> HTML input yerine ASP.NET TextBox -->
                                            <asp:TextBox ID="txtSoyad" runat="server" CssClass="form-control" placeholder="Soyad"></asp:TextBox>
                                            <div class="invalid-feedback">Soyad alanı zorunludur.</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="<%= txtDogumYeri.ClientID %>" class="form-label">Doğum Yeri</label>
                                            <!-- ==> HTML input yerine ASP.NET TextBox -->
                                            <asp:TextBox ID="txtDogumYeri" runat="server" CssClass="form-control" placeholder="Doğum yeri"></asp:TextBox>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="<%= txtDogumTarihi.ClientID %>" class="form-label">Doğum Tarihi</label>
                                            <!-- ==> HTML input yerine ASP.NET TextBox (date type) -->
                                            <asp:TextBox ID="txtDogumTarihi" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="<%= ddlCinsiyet.ClientID %>" class="form-label">Cinsiyet</label>
                                            <!-- ==> HTML select yerine ASP.NET DropDownList -->
                                            <asp:DropDownList ID="ddlCinsiyet" runat="server" CssClass="form-select">
                                                <asp:ListItem Value="" Text="Seçiniz"></asp:ListItem>
                                                <asp:ListItem Value="E" Text="Erkek"></asp:ListItem>
                                                <asp:ListItem Value="K" Text="Kadın"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="<%= ddlKanGrubu.ClientID %>" class="form-label">Kan Grubu</label>
                                            <!-- ==> HTML select yerine ASP.NET DropDownList -->
                                            <asp:DropDownList ID="ddlKanGrubu" runat="server" CssClass="form-select">
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
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Fotoğraf</label>
                                    <div class="photo-upload" id="photoUploadArea">
                                        <div id="photoContent">
                                            <!-- ==> Fotoğraf önizleme için ASP.NET Image -->
                                            <asp:Image ID="imgPreview" runat="server" CssClass="img-fluid" Style="max-height: 200px; display: none;" />
                                            <div id="photoPlaceholder">
                                                <i class="bi bi-camera fs-1 text-muted"></i>
                                                <p class="mt-2 mb-0 text-muted">Fotoğraf Yükle</p>
                                                <small class="text-muted">JPG, PNG (Max: 2MB)</small>
                                            </div>
                                        </div>
                                    </div>
                                    <input type="file" id="fotoUpload" accept=".jpg,.jpeg,.png" style="display: none;" onchange="handlePhotoUpload(this)">
                                    <!-- ==> Fotoğraf yolu için HiddenField -->
                                    <asp:HiddenField ID="hfFotografYolu" runat="server" />
                                    <div class="mt-2">
                                        <button type="button" class="btn btn-sm btn-outline-primary" onclick="document.getElementById('fotoUpload').click();">
                                            <i class="bi bi-upload"></i>Fotoğraf Seç
                                        </button>
                                        <button type="button" class="btn btn-sm btn-outline-danger" id="fotoSil" style="display: none;" onclick="clearPhoto();">
                                            <i class="bi bi-trash"></i>Sil
                                        </button>
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
                                    <label for="<%= ddlCalismaDurumu.ClientID %>" class="form-label">Çalışma Durumu</label>
                                    <!-- ==> HTML select yerine ASP.NET DropDownList -->
                                    <asp:DropDownList ID="ddlCalismaDurumu" runat="server" CssClass="form-select">
                                        <asp:ListItem Value="" Text="Seçiniz"></asp:ListItem>
                                        <asp:ListItem Value="aktif" Text="Aktif"></asp:ListItem>
                                        <asp:ListItem Value="pasif" Text="Pasif"></asp:ListItem>
                                        <asp:ListItem Value="izinli" Text="İzinli"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="<%= ddlDurum.ClientID %>" class="form-label">Durum</label>
                                    <!-- ==> HTML select yerine ASP.NET DropDownList -->
                                    <asp:DropDownList ID="ddlDurum" runat="server" CssClass="form-select">
                                        <asp:ListItem Value="" Text="Seçiniz"></asp:ListItem>
                                        <asp:ListItem Value="gorevde" Text="Görevde"></asp:ListItem>
                                        <asp:ListItem Value="izinli" Text="İzinli"></asp:ListItem>
                                        <asp:ListItem Value="emekli" Text="Emekli"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="<%= txtUnvan.ClientID %>" class="form-label required-field">Unvan</label>
                                    <!-- ==> HTML input yerine ASP.NET TextBox -->
                                    <asp:TextBox ID="txtUnvan" runat="server" CssClass="form-control" placeholder="Unvan"></asp:TextBox>
                                    <div class="invalid-feedback">Unvan zorunludur.</div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="<%= txtMeslekiUnvan.ClientID %>" class="form-label">Mesleki Unvan</label>
                                    <!-- ==> HTML input yerine ASP.NET TextBox -->
                                    <asp:TextBox ID="txtMeslekiUnvan" runat="server" CssClass="form-control" placeholder="Mesleki unvan"></asp:TextBox>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="<%= ddlStatu.ClientID %>" class="form-label">Statü</label>
                                    <!-- ==> HTML select yerine ASP.NET DropDownList -->
                                    <asp:DropDownList ID="ddlStatu" runat="server" CssClass="form-select">
                                        <asp:ListItem Value="" Text="Seçiniz"></asp:ListItem>
                                        <asp:ListItem Value="memur" Text="Memur"></asp:ListItem>
                                        <asp:ListItem Value="sozlesmeli" Text="Sözleşmeli"></asp:ListItem>
                                        <asp:ListItem Value="kadrolu" Text="Kadrolu"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="<%= txtBirim.ClientID %>" class="form-label">Birim</label>
                                    <!-- ==> HTML input yerine ASP.NET TextBox -->
                                    <asp:TextBox ID="txtBirim" runat="server" CssClass="form-control" placeholder="Birim"></asp:TextBox>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="<%= txtKurumaBaslamaTarihi.ClientID %>" class="form-label required-field">Kuruma Başlama Tarihi</label>
                                    <!-- ==> HTML input yerine ASP.NET TextBox (date type) -->
                                    <asp:TextBox ID="txtKurumaBaslamaTarihi" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                    <div class="invalid-feedback">Kuruma başlama tarihi zorunludur.</div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="<%= txtIlkGirisTarihi.ClientID %>" class="form-label">İlk Giriş Tarihi</label>
                                    <!-- ==> HTML input yerine ASP.NET TextBox (date type) -->
                                    <asp:TextBox ID="txtIlkGirisTarihi" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="<%= txtKadroDerecesi.ClientID %>" class="form-label">Kadro Derecesi</label>
                                    <!-- ==> HTML input yerine ASP.NET TextBox (number type) -->
                                    <asp:TextBox ID="txtKadroDerecesi" runat="server" CssClass="form-control" TextMode="Number" placeholder="1-20"></asp:TextBox>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="<%= ddlOgrenimDurumu.ClientID %>" class="form-label">Öğrenim Durumu</label>
                                    <!-- ==> HTML select yerine ASP.NET DropDownList -->
                                    <asp:DropDownList ID="ddlOgrenimDurumu" runat="server" CssClass="form-select">
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
                                    <label for="<%= txtCepTelefonu.ClientID %>" class="form-label required-field">Cep Telefonu</label>
                                    <!-- ==> HTML input yerine ASP.NET TextBox -->
                                    <asp:TextBox ID="txtCepTelefonu" runat="server" CssClass="form-control" placeholder="0555 123 45 67"></asp:TextBox>
                                    <div class="invalid-feedback">Cep telefonu zorunludur ve geçerli formatta olmalıdır.</div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="<%= txtEvTelefonu.ClientID %>" class="form-label">Ev Telefonu</label>
                                    <!-- ==> HTML input yerine ASP.NET TextBox -->
                                    <asp:TextBox ID="txtEvTelefonu" runat="server" CssClass="form-control" placeholder="0312 123 45 67"></asp:TextBox>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="<%= txtDahiliTelefon.ClientID %>" class="form-label">Dahili Telefon</label>
                                    <!-- ==> HTML input yerine ASP.NET TextBox -->
                                    <asp:TextBox ID="txtDahiliTelefon" runat="server" CssClass="form-control" placeholder="1234"></asp:TextBox>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="<%= txtEmail.ClientID %>" class="form-label">E-posta</label>
                                    <!-- ==> HTML input yerine ASP.NET TextBox -->
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="ornek@domain.com"></asp:TextBox>
                                    <div class="invalid-feedback">Geçerli bir e-posta adresi giriniz.</div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="<%= txtAdres.ClientID %>" class="form-label required-field">Adres</label>
                                <!-- ==> HTML textarea yerine ASP.NET TextBox (MultiLine) -->
                                <asp:TextBox ID="txtAdres" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Tam adres bilgisi"></asp:TextBox>
                                <div class="invalid-feedback">Adres bilgisi zorunludur.</div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="<%= txtAcilDurumKisi.ClientID %>" class="form-label">Acil Durumda Aranacak Kişi</label>
                                    <!-- ==> HTML input yerine ASP.NET TextBox -->
                                    <asp:TextBox ID="txtAcilDurumKisi" runat="server" CssClass="form-control" placeholder="Ad Soyad"></asp:TextBox>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="<%= txtAcilDurumTelefonu.ClientID %>" class="form-label">Acil Durum Telefonu</label>
                                    <!-- ==> HTML input yerine ASP.NET TextBox -->
                                    <asp:TextBox ID="txtAcilDurumTelefonu" runat="server" CssClass="form-control" placeholder="0555 123 45 67"></asp:TextBox>
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
                                    <label for="<%= ddlMedeniHal.ClientID %>" class="form-label">Medeni Hal</label>
                                    <!-- ==> HTML select yerine ASP.NET DropDownList -->
                                    <asp:DropDownList ID="ddlMedeniHal" runat="server" CssClass="form-select">
                                        <asp:ListItem Value="" Text="Seçiniz"></asp:ListItem>
                                        <asp:ListItem Value="bekar" Text="Bekar"></asp:ListItem>
                                        <asp:ListItem Value="evli" Text="Evli"></asp:ListItem>
                                        <asp:ListItem Value="bosanmis" Text="Boşanmış"></asp:ListItem>
                                        <asp:ListItem Value="dul" Text="Dul"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="<%= ddlAskerlikDurumu.ClientID %>" class="form-label">Askerlik Durumu</label>
                                    <!-- ==> HTML select yerine ASP.NET DropDownList -->
                                    <asp:DropDownList ID="ddlAskerlikDurumu" runat="server" CssClass="form-select">
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
                                    <label for="<%= ddlEngelDurumu.ClientID %>" class="form-label">Engel Durumu</label>
                                    <!-- ==> HTML select yerine ASP.NET DropDownList -->
                                    <asp:DropDownList ID="ddlEngelDurumu" runat="server" CssClass="form-select">
                                        <asp:ListItem Value="" Text="Seçiniz"></asp:ListItem>
                                        <asp:ListItem Value="yok" Text="Yok"></asp:ListItem>
                                        <asp:ListItem Value="var" Text="Var"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="<%= txtSendika.ClientID %>" class="form-label">Sendika</label>
                                    <!-- ==> HTML input yerine ASP.NET TextBox -->
                                    <asp:TextBox ID="txtSendika" runat="server" CssClass="form-control" placeholder="Sendika bilgisi"></asp:TextBox>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="<%= txtEngelAciklamasi.ClientID %>" class="form-label">Engel Açıklaması</label>
                                <!-- ==> HTML textarea yerine ASP.NET TextBox (MultiLine) -->
                                <asp:TextBox ID="txtEngelAciklamasi" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="Varsa engel durumu hakkında açıklama"></asp:TextBox>
                            </div>

                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label for="<%= ddlEmeklilik.ClientID %>" class="form-label">Emeklilik</label>
                                    <!-- ==> HTML select yerine ASP.NET DropDownList -->
                                    <asp:DropDownList ID="ddlEmeklilik" runat="server" CssClass="form-select">
                                        <asp:ListItem Value="" Text="Seçiniz"></asp:ListItem>
                                        <asp:ListItem Value="var" Text="Var"></asp:ListItem>
                                        <asp:ListItem Value="yok" Text="Yok"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label for="<%= ddlYaslilik.ClientID %>" class="form-label">Yaşlılık</label>
                                    <!-- ==> HTML select yerine ASP.NET DropDownList -->
                                    <asp:DropDownList ID="ddlYaslilik" runat="server" CssClass="form-select">
                                        <asp:ListItem Value="" Text="Seçiniz"></asp:ListItem>
                                        <asp:ListItem Value="var" Text="Var"></asp:ListItem>
                                        <asp:ListItem Value="yok" Text="Yok"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label for="<%= txtEmekliAciklamasi.ClientID %>" class="form-label">Emekli Açıklama</label>
                                    <!-- ==> HTML input yerine ASP.NET TextBox -->
                                    <asp:TextBox ID="txtEmekliAciklamasi" runat="server" CssClass="form-control" placeholder="Emekli açıklaması"></asp:TextBox>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <div class="form-check">
                                        <!-- ==> HTML checkbox yerine ASP.NET CheckBox -->
                                        <asp:CheckBox ID="chkAktif" runat="server" CssClass="form-check-input" Text="Aktif" Checked="true" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Form Butonları -->
                        <div class="btn-group-custom">
                            <div class="d-flex justify-content-center gap-3">
                                <!-- ==> HTML button yerine ASP.NET Button -->
                                <asp:Button ID="btnKaydet" runat="server" CssClass="btn btn-success btn-lg" Text="Kaydet" OnClick="btnKaydet_Click" />
                                <asp:Button ID="btnGuncelle" runat="server" CssClass="btn btn-primary btn-lg" Text="Güncelle" OnClick="btnKaydet_Click" Style="display: none;" />
                                <asp:Button ID="btnYazdir" runat="server" CssClass="btn btn-info btn-lg" Text="Yazdır" OnClientClick="window.print(); return false;" />
                                <asp:Button ID="btnTemizle" runat="server" CssClass="btn btn-secondary btn-lg" Text="Temizle" OnClick="btnTemizle_Click" />
                            </div>
                        </div>

                        <!-- ==> HiddenField kontrolleri eklendi -->
                        <asp:HiddenField ID="hfPersonelID" runat="server" Value="0" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script type="text/javascript">
        // ==> Sayfa yüklendiğinde çalışacak fonksiyonlar
        document.addEventListener('DOMContentLoaded', function() {
            initializeForm();
            setupEventListeners();
        });

        // ==> Form başlangıç ayarları
        function initializeForm() {
            // TC Kimlik ve Sicil No alanlarına numara formatı uygula
            var tcInput = document.getElementById('<%= txtTCKimlik.ClientID %>');
            var sicilInput = document.getElementById('<%= txtSicilNo.ClientID %>');
            
            if (tcInput) {
                tcInput.addEventListener('input', function() {
                    this.value = this.value.replace(/[^0-9]/g, '');
                    if (this.value.length > 11) {
                        this.value = this.value.substring(0, 11);
                    }
                });
            }
            
            // Telefon alanlarına maske uygula
            setupPhoneMasks();
        }

        // ==> Event listener'ları kur
        function setupEventListeners() {
            // TC Kimlik doğrulama
            var tcInput = document.getElementById('<%= txtTCKimlik.ClientID %>');
            if (tcInput) {
                tcInput.addEventListener('blur', validateTCKimlik);
            }

            // Email doğrulama
            var emailInput = document.getElementById('<%= txtEmail.ClientID %>');
            if (emailInput) {
                emailInput.addEventListener('blur', validateEmail);
            }

            // Fotoğraf yükleme alanı
            var photoArea = document.getElementById('photoUploadArea');
            if (photoArea) {
                photoArea.addEventListener('click', function() {
                    document.getElementById('fotoUpload').click();
                });
            }
        }

        // ==> TC Kimlik sorgulama (AJAX)
        function tcSorgulaJS() {
            var tcKimlik = document.getElementById('<%= txtTCKimlik.ClientID %>').value;
            
            if (!tcKimlik || tcKimlik.length !== 11) {
                showAlert('Geçerli bir TC Kimlik No giriniz.', 'alert-warning');
                return false;
            }

            if (!validateTCKimlikNo(tcKimlik)) {
                showAlert('TC Kimlik No algoritması uygun değil.', 'alert-danger');
                return false;
            }

            // AJAX ile sorgu yap
            PageMethods.GetPersonelByTC(tcKimlik, 
                function(result) {
                    if (result.success) {
                        if (result.exists) {
                            // Personel bulundu, formu doldur
                            fillFormWithPersonel(result.data);
                            showAlert('Personel bilgileri yüklendi.', 'alert-success');
                            // Güncelleme moduna geç
                            toggleUpdateMode(true);
                        } else {
                            showAlert('Bu TC Kimlik No ile kayıtlı personel bulunamadı.', 'alert-info');
                            clearFormExceptTC();
                        }
                    } else {
                        showAlert(result.message, 'alert-danger');
                    }
                },
                function(error) {
                    showAlert('Sorgu sırasında hata oluştu.', 'alert-danger');
                    console.error(error);
                }
            );
            
            return false;
        }

        // ==> Sicil No sorgulama (AJAX)
        function sicilSorgulaJS() {
            var sicilNo = document.getElementById('<%= txtSicilNo.ClientID %>').value;
            
            if (!sicilNo.trim()) {
                showAlert('Sicil No giriniz.', 'alert-warning');
                return false;
            }

            // AJAX ile sorgu yap
            PageMethods.GetPersonelBySicil(sicilNo, 
                function(result) {
                    if (result.success) {
                        if (result.exists) {
                            // Personel bilgisi göster
                            var message = `Personel: ${result.data.AdSoyad}<br>Unvan: ${result.data.Unvan}<br>Birim: ${result.data.Birim}`;
                            showAlert(message, 'alert-info');
                            
                            // TC Kimlik alanını doldur
                            document.getElementById('<%= txtTCKimlik.ClientID %>').value = result.data.TCKimlikNo;
                        } else {
                            showAlert('Bu Sicil No ile kayıtlı personel bulunamadı.', 'alert-info');
                        }
                    } else {
                        showAlert(result.message, 'alert-danger');
                    }
                },
                function(error) {
                    showAlert('Sorgu sırasında hata oluştu.', 'alert-danger');
                    console.error(error);
                }
            );
            
            return false;
        }

        // ==> TC Kimlik No algoritma kontrolü
        function validateTCKimlikNo(tcKimlik) {
            if (tcKimlik.length !== 11) return false;
            
            var digits = tcKimlik.split('').map(Number);
            
            // İlk hane 0 olamaz
            if (digits[0] === 0) return false;
            
            // 10. hane kontrolü
            var oddSum = digits[0] + digits[2] + digits[4] + digits[6] + digits[8];
            var evenSum = digits[1] + digits[3] + digits[5] + digits[7];
            var check10 = ((oddSum * 7) - evenSum) % 10;
            
            if (check10 !== digits[9]) return false;
            
            // 11. hane kontrolü
            var totalSum = digits.slice(0, 10).reduce((a, b) => a + b, 0);
            var check11 = totalSum % 10;
            
            return check11 === digits[10];
        }

        // ==> TC Kimlik doğrulama
        function validateTCKimlik() {
            var tcInput = document.getElementById('<%= txtTCKimlik.ClientID %>');
            var tcKimlik = tcInput.value;
            
            if (tcKimlik && tcKimlik.length === 11) {
                if (!validateTCKimlikNo(tcKimlik)) {
                    tcInput.classList.add('is-invalid');
                    showAlert('TC Kimlik No algoritması uygun değil.', 'alert-danger');
                } else {
                    tcInput.classList.remove('is-invalid');
                    tcInput.classList.add('is-valid');
                }
            }
        }

        // ==> Email doğrulama
        function validateEmail() {
            var emailInput = document.getElementById('<%= txtEmail.ClientID %>');
            var email = emailInput.value;
            
            if (email) {
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    emailInput.classList.add('is-invalid');
                } else {
                    emailInput.classList.remove('is-invalid');
                    emailInput.classList.add('is-valid');
                }
            }
        }

        // ==> Telefon maskesi uygula
        function setupPhoneMasks() {
            var phoneInputs = [
                '<%= txtCepTelefonu.ClientID %>',
                '<%= txtEvTelefonu.ClientID %>',
                '<%= txtAcilDurumTelefonu.ClientID %>'
            ];
            
            phoneInputs.forEach(function(inputId) {
                var input = document.getElementById(inputId);
                if (input) {
                    input.addEventListener('input', function() {
                        var value = this.value.replace(/[^0-9]/g, '');
                        if (value.length >= 10) {
                            if (value.startsWith('0')) {
                                // Sabit hat: 0312 123 45 67
                                this.value = value.replace(/(\d{4})(\d{3})(\d{2})(\d{2})/, '$1 $2 $3 $4');
                            } else if (value.length === 10) {
                                // Cep: 555 123 45 67
                                this.value = value.replace(/(\d{3})(\d{3})(\d{2})(\d{2})/, '$1 $2 $3 $4');
                            }
                        }
                    });
                }
            });
        }

        // ==> Fotoğraf yükleme
        function handlePhotoUpload(input) {
            if (input.files && input.files[0]) {
                var file = input.files[0];
                
                // Dosya kontrolü
                if (file.size > 2 * 1024 * 1024) {
                    showAlert('Dosya boyutu 2MB\'dan büyük olamaz.', 'alert-warning');
                    return;
                }
                
                if (!file.type.match(/image\/(jpeg|jpg|png)/)) {
                    showAlert('Sadece JPG, JPEG ve PNG dosyaları kabul edilir.', 'alert-warning');
                    return;
                }
                
                var reader = new FileReader();
                reader.onload = function(e) {
                    var imgPreview = document.getElementById('<%= imgPreview.ClientID %>');
                    var placeholder = document.getElementById('photoPlaceholder');
                    var silButton = document.getElementById('fotoSil');
                    
                    imgPreview.src = e.target.result;
                    imgPreview.style.display = 'block';
                    placeholder.style.display = 'none';
                    silButton.style.display = 'inline-block';
                    
                    // Fotoğraf yolunu hidden field'a kaydet (sunucu tarafında işlenecek)
                    document.getElementById('<%= hfFotografYolu.Value %>').value = file.name;
                };
                reader.readAsDataURL(file);
                
                showAlert('Fotoğraf yüklendi.', 'alert-success');
            }
        }

        // ==> Fotoğraf temizle
        function clearPhoto() {
            var imgPreview = document.getElementById('<%= imgPreview.ClientID %>');
            var placeholder = document.getElementById('photoPlaceholder');
            var silButton = document.getElementById('fotoSil');
            var fileInput = document.getElementById('fotoUpload');
            
            imgPreview.src = '';
            imgPreview.style.display = 'none';
            placeholder.style.display = 'block';
            silButton.style.display = 'none';
            fileInput.value = '';
            
            document.getElementById('<%= hfFotografYolu.ClientID %>').value = '';
            
            showAlert('Fotoğraf kaldırıldı.', 'alert-info');
        }

        // ==> Form doldurma (TC sorgusu sonrası)
        function fillFormWithPersonel(data) {
            document.getElementById('<%= hfPersonelID.ClientID %>').value = data.PersonelID;
            document.getElementById('<%= txtSicilNo.ClientID %>').value = data.SicilNo || '';
            document.getElementById('<%= txtAd.ClientID %>').value = data.Ad || '';
            document.getElementById('<%= txtSoyad.ClientID %>').value = data.Soyad || '';
            document.getElementById('<%= txtDogumYeri.ClientID %>').value = data.DogumYeri || '';
            document.getElementById('<%= txtDogumTarihi.ClientID %>').value = data.DogumTarihi || '';
            
            // DropDown'ları doldur
            setDropDownValue('<%= ddlCinsiyet.ClientID %>', data.Cinsiyet);
            setDropDownValue('<%= ddlKanGrubu.ClientID %>', data.KanGrubu);
            setDropDownValue('<%= ddlCalismaDurumu.ClientID %>', data.CalismaDurumu);
            setDropDownValue('<%= ddlDurum.ClientID %>', data.Durum);
            setDropDownValue('<%= ddlStatu.ClientID %>', data.Statu);
            setDropDownValue('<%= ddlOgrenimDurumu.ClientID %>', data.OgrenimDurumu);
            setDropDownValue('<%= ddlMedeniHal.ClientID %>', data.MedeniHal);
            setDropDownValue('<%= ddlAskerlikDurumu.ClientID %>', data.AskerlikDurumu);
            setDropDownValue('<%= ddlEngelDurumu.ClientID %>', data.EngelDurumu);
            setDropDownValue('<%= ddlEmeklilik.ClientID %>', data.Emeklilik);
            setDropDownValue('<%= ddlYaslilik.ClientID %>', data.Yaslilik);
            
            // Diğer alanlar
            document.getElementById('<%= txtUnvan.ClientID %>').value = data.Unvan || '';
            document.getElementById('<%= txtMeslekiUnvan.ClientID %>').value = data.MeslekiUnvan || '';
            document.getElementById('<%= txtBirim.ClientID %>').value = data.Birim || '';
            document.getElementById('<%= txtKurumaBaslamaTarihi.ClientID %>').value = data.KurumaBaslamaTarihi || '';
            document.getElementById('<%= txtIlkGirisTarihi.ClientID %>').value = data.IlkGirisTarihi || '';
            document.getElementById('<%= txtKadroDerecesi.ClientID %>').value = data.KadroDerecesi || '';
            document.getElementById('<%= txtCepTelefonu.ClientID %>').value = data.CepTelefonu || '';
            document.getElementById('<%= txtEvTelefonu.ClientID %>').value = data.EvTelefonu || '';
            document.getElementById('<%= txtDahiliTelefon.ClientID %>').value = data.DahiliTelefon || '';
            document.getElementById('<%= txtEmail.ClientID %>').value = data.Email || '';
            document.getElementById('<%= txtAdres.ClientID %>').value = data.Adres || '';
            document.getElementById('<%= txtAcilDurumKisi.ClientID %>').value = data.AcilDurumKisi || '';
            document.getElementById('<%= txtAcilDurumTelefonu.ClientID %>').value = data.AcilDurumTelefonu || '';
            document.getElementById('<%= txtEngelAciklamasi.ClientID %>').value = data.EngelAciklamasi || '';
            document.getElementById('<%= txtSendika.ClientID %>').value = data.Sendika || '';
            document.getElementById('<%= txtEmekliAciklamasi.ClientID %>').value = data.EmekliAciklamasi || '';
            
            // Fotoğraf
            if (data.FotografYolu) {
                var imgPreview = document.getElementById('<%= imgPreview.ClientID %>');
                var placeholder = document.getElementById('photoPlaceholder');
                var silButton = document.getElementById('fotoSil');
                
                imgPreview.src = data.FotografYolu;
                imgPreview.style.display = 'block';
                placeholder.style.display = 'none';
                silButton.style.display = 'inline-block';
                
                document.getElementById('<%= hfFotografYolu.ClientID %>').value = data.FotografYolu;
            }
        }

        // ==> DropDown değer ayarlama
        function setDropDownValue(elementId, value) {
            var element = document.getElementById(elementId);
            if (element && value) {
                for (var i = 0; i < element.options.length; i++) {
                    if (element.options[i].value === value) {
                        element.selectedIndex = i;
                        break;
                    }
                }
            }
        }

        // ==> TC hariç formu temizle
        function clearFormExceptTC() {
            var tcValue = document.getElementById('<%= txtTCKimlik.ClientID %>').value;
            // Form temizleme server-side yapılacak
            document.getElementById('<%= hfPersonelID.ClientID %>').value = '0';
        }

        // ==> Güncelleme moduna geçiş
        function toggleUpdateMode(isUpdate) {
            var btnKaydet = document.getElementById('<%= btnKaydet.ClientID %>');
            var btnGuncelle = document.getElementById('<%= btnGuncelle.ClientID %>');
            
            if (isUpdate) {
                btnKaydet.style.display = 'none';
                btnGuncelle.style.display = 'inline-block';
            } else {
                btnKaydet.style.display = 'inline-block';
                btnGuncelle.style.display = 'none';
            }
        }

        // ==> Toast mesajı göster
        function showAlert(message, alertType) {
            var toastContainer = document.getElementById('toastContainer');
            if (!toastContainer) return;

            var toastId = 'toast_' + Date.now();
            var iconClass = 'bi-info-circle';
            var bgClass = 'bg-primary';

            switch(alertType) {
                case 'alert-success':
                    iconClass = 'bi-check-circle';
                    bgClass = 'bg-success';
                    break;
                case 'alert-danger':
                    iconClass = 'bi-exclamation-triangle';
                    bgClass = 'bg-danger';
                    break;
                case 'alert-warning':
                    iconClass = 'bi-exclamation-triangle';
                    bgClass = 'bg-warning';
                    break;
            }

            var toastHtml = `
                <div id="${toastId}" class="toast align-items-center text-white ${bgClass} border-0" role="alert">
                    <div class="d-flex">
                        <div class="toast-body">
                            <i class="bi ${iconClass} me-2"></i>
                            ${message}
                        </div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                    </div>
                </div>
            `;

            toastContainer.insertAdjacentHTML('beforeend', toastHtml);
            
            var toastElement = document.getElementById(toastId);
            var toast = new bootstrap.Toast(toastElement);
            toast.show();

            // Toast kapandıktan sonra DOM'dan kaldır
            toastElement.addEventListener('hidden.bs.toast', function() {
                toastElement.remove();
            });
        }

        // ==> Form gönderilmeden önce doğrulama
        function validateForm() {
            var isValid = true;
            var requiredFields = [
                { id: '<%= txtTCKimlik.ClientID %>', name: 'TC Kimlik No' },
                { id: '<%= txtSicilNo.ClientID %>', name: 'Sicil No' },
                { id: '<%= txtAd.ClientID %>', name: 'Ad' },
                { id: '<%= txtSoyad.ClientID %>', name: 'Soyad' },
                { id: '<%= txtUnvan.ClientID %>', name: 'Unvan' },
                { id: '<%= txtKurumaBaslamaTarihi.ClientID %>', name: 'Kuruma Başlama Tarihi' },
                { id: '<%= txtCepTelefonu.ClientID %>', name: 'Cep Telefonu' },
                { id: '<%= txtAdres.ClientID %>', name: 'Adres' }
            ];

            requiredFields.forEach(function(field) {
                var element = document.getElementById(field.id);
                if (!element.value.trim()) {
                    element.classList.add('is-invalid');
                    isValid = false;
                } else {
                    element.classList.remove('is-invalid');
                    element.classList.add('is-valid');
                }
            });

            if (!isValid) {
                showAlert('Lütfen zorunlu alanları doldurunuz.', 'alert-warning');
            }

            return isValid;
        }
    </script>

</asp:Content>