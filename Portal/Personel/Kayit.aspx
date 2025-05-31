<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Kayit.aspx.cs" Inherits="Portal.Personel.Kayit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Personel Kayıt Formu</title>
    
    <link href="../01_css/site.css" rel="stylesheet">
</head>

<body class="bg-light">
    <!-- Toast Container -->
    <div class="toast-container" id="toastContainer">
    </div>

    <div class="container my-4">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <!-- Header -->
                <div class="card shadow-sm mb-4">
                    <div class="card-body text-center">
                        <h2 class="mb-1"><i class="bi bi-person-plus-fill"></i> Personel Kayıt Formu</h2>
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
                                    <input type="text" class="form-control" id="tcKimlik" maxlength="11" required>
                                    <button class="btn btn-outline-primary" type="button" id="tcSorgula">
                                        <span class="loading-spinner spinner-border spinner-border-sm me-1" role="status"></span>
                                        <i class="bi bi-search"></i> Sorgula
                                    </button>
                                </div>
                                <div class="invalid-feedback">Geçerli bir TC Kimlik numarası giriniz.</div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="sicilNo" class="form-label required-field">Sicil No</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="sicilNo" required>
                                    <button class="btn btn-outline-primary" type="button" id="sicilSorgula">
                                        <span class="loading-spinner spinner-border spinner-border-sm me-1" role="status"></span>
                                        <i class="bi bi-search"></i> Sorgula
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
                                        <input type="text" class="form-control" id="ad" required>
                                        <div class="invalid-feedback">Ad alanı zorunludur.</div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="soyad" class="form-label required-field">Soyad</label>
                                        <input type="text" class="form-control" id="soyad" required>
                                        <div class="invalid-feedback">Soyad alanı zorunludur.</div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="dogumYeri" class="form-label">Doğum Yeri</label>
                                        <input type="text" class="form-control" id="dogumYeri">
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="dogumTarihi" class="form-label">Doğum Tarihi</label>
                                        <input type="date" class="form-control" id="dogumTarihi">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="cinsiyet" class="form-label">Cinsiyet</label>
                                        <select class="form-select" id="cinsiyet">
                                            <option value="">Seçiniz</option>
                                            <option value="E">Erkek</option>
                                            <option value="K">Kadın</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="kanGrubu" class="form-label">Kan Grubu</label>
                                        <select class="form-select" id="kanGrubu">
                                            <option value="">Seçiniz</option>
                                            <option value="A+">A Rh+</option>
                                            <option value="A-">A Rh-</option>
                                            <option value="B+">B Rh+</option>
                                            <option value="B-">B Rh-</option>
                                            <option value="AB+">AB Rh+</option>
                                            <option value="AB-">AB Rh-</option>
                                            <option value="0+">0 Rh+</option>
                                            <option value="0-">0 Rh-</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Fotoğraf</label>
                                <div class="photo-upload" id="photoUploadArea">
                                    <div id="photoContent">
                                        <i class="bi bi-camera fs-1 text-muted"></i>
                                        <p class="mt-2 mb-0 text-muted">Fotoğraf Yükle</p>
                                        <small class="text-muted">JPG, PNG (Max: 2MB)</small>
                                    </div>
                                </div>
                                <input type="file" id="fotoUpload" accept=".jpg,.jpeg,.png" style="display: none;">
                                <div class="mt-2">
                                    <button type="button" class="btn btn-sm btn-outline-danger" id="fotoSil" style="display: none;">
                                        <i class="bi bi-trash"></i> Fotoğrafı Sil
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
                                <label for="calismaDurumu" class="form-label">Çalışma Durumu</label>
                                <select class="form-select" id="calismaDurumu">
                                    <option value="">Seçiniz</option>
                                    <option value="aktif">Aktif</option>
                                    <option value="pasif">Pasif</option>
                                    <option value="izinli">İzinli</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="durum" class="form-label">Durum</label>
                                <select class="form-select" id="durum">
                                    <option value="">Seçiniz</option>
                                    <option value="gorevde">Görevde</option>
                                    <option value="izinli">İzinli</option>
                                    <option value="emekli">Emekli</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="unvan" class="form-label required-field">Unvan</label>
                                <select class="form-select" id="unvan" required>
                                    <option value="">Seçiniz</option>
                                    <option value="memur">Memur</option>
                                    <option value="uzman">Uzman</option>
                                    <option value="mudurassistani">Müdür Yardımcısı</option>
                                    <option value="mudur">Müdür</option>
                                </select>
                                <div class="invalid-feedback">Unvan seçimi zorunludur.</div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="meslekiUnvan" class="form-label">Mesleki Unvan</label>
                                <input type="text" class="form-control" id="meslekiUnvan">
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="statu" class="form-label">Statü</label>
                                <select class="form-select" id="statu">
                                    <option value="">Seçiniz</option>
                                    <option value="memur">Memur</option>
                                    <option value="sozlesmeli">Sözleşmeli</option>
                                    <option value="kadrolu">Kadrolu</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="birim" class="form-label">Birim</label>
                                <select class="form-select" id="birim">
                                    <option value="">Seçiniz</option>
                                    <option value="idari">İdari İşler</option>
                                    <option value="mali">Mali İşler</option>
                                    <option value="teknik">Teknik İşler</option>
                                    <option value="insankaynaklari">İnsan Kaynakları</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="kurumBaslama" class="form-label required-field">Kuruma Başlama Tarihi</label>
                                <input type="date" class="form-control" id="kurumBaslama" required>
                                <div class="invalid-feedback">Kuruma başlama tarihi zorunludur.</div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="ilkGiris" class="form-label">İlk Giriş Tarihi</label>
                                <input type="date" class="form-control" id="ilkGiris">
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="kadroDerecesi" class="form-label">Kadro Derecesi</label>
                                <input type="number" class="form-control" id="kadroDerecesi" min="1" max="20">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="ogrenimDurumu" class="form-label">Öğrenim Durumu</label>
                                <select class="form-select" id="ogrenimDurumu">
                                    <option value="">Seçiniz</option>
                                    <option value="ilkokul">İlkokul</option>
                                    <option value="ortaokul">Ortaokul</option>
                                    <option value="lise">Lise</option>
                                    <option value="onlisans">Ön Lisans</option>
                                    <option value="lisans">Lisans</option>
                                    <option value="yukseklisans">Yüksek Lisans</option>
                                    <option value="doktora">Doktora</option>
                                </select>
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
                                <input type="tel" class="form-control" id="ceptel" required placeholder="0555 123 45 67">
                                <div class="invalid-feedback">Cep telefonu zorunludur ve geçerli formatta olmalıdır.</div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="evTel" class="form-label">Ev Telefonu</label>
                                <input type="tel" class="form-control" id="evTel" placeholder="0312 123 45 67">
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="dahiliTel" class="form-label">Dahili Telefon</label>
                                <input type="tel" class="form-control" id="dahiliTel" placeholder="1234">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label">E-posta</label>
                                <input type="email" class="form-control" id="email" placeholder="ornek@domain.com">
                                <div class="invalid-feedback">Geçerli bir e-posta adresi giriniz.</div>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="adres" class="form-label required-field">Adres</label>
                            <textarea class="form-control" id="adres" rows="3" required placeholder="Tam adres bilgisi"></textarea>
                            <div class="invalid-feedback">Adres bilgisi zorunludur.</div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="acilDurumKisi" class="form-label">Acil Durumda Aranacak Kişi</label>
                                <input type="text" class="form-control" id="acilDurumKisi" placeholder="Ad Soyad">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="acilDurumTel" class="form-label">Acil Durum Telefonu</label>
                                <input type="tel" class="form-control" id="acilDurumTel" placeholder="0555 123 45 67">
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
                                <select class="form-select" id="medeniHal">
                                    <option value="">Seçiniz</option>
                                    <option value="bekar">Bekar</option>
                                    <option value="evli">Evli</option>
                                    <option value="bosanmis">Boşanmış</option>
                                    <option value="dul">Dul</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="askerlikDurumu" class="form-label">Askerlik Durumu</label>
                                <select class="form-select" id="askerlikDurumu">
                                    <option value="">Seçiniz</option>
                                    <option value="yapti">Yaptı</option>
                                    <option value="muaf">Muaf</option>
                                    <option value="tecilli">Tecilli</option>
                                    <option value="yapmadi">Yapmadı</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="engelDurumu" class="form-label">Engel Durumu</label>
                                <select class="form-select" id="engelDurumu">
                                    <option value="">Seçiniz</option>
                                    <option value="yok">Yok</option>
                                    <option value="var">Var</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="sendika" class="form-label">Sendika</label>
                                <select class="form-select" id="sendika">
                                    <option value="">Seçiniz</option>
                                    <option value="uye">Üye</option>
                                    <option value="uyedeğil">Üye Değil</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="engelAciklama" class="form-label">Engel Açıklaması</label>
                            <textarea class="form-control" id="engelAciklama" rows="2" placeholder="Varsa engel durumu hakkında açıklama"></textarea>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label for="emeklilik" class="form-label">Emeklilik</label>
                                <input type="text" class="form-control" id="emeklilik">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="yaslilik" class="form-label">Yaşlılık</label>
                                <input type="text" class="form-control" id="yaslilik">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="emekliAciklama" class="form-label">Emekli Açıklama</label>
                                <input type="text" class="form-control" id="emekliAciklama">
                            </div>
                        </div>
                    </div>

                    <!-- Form Butonları -->
                    <div class="btn-group-custom">
                        <div class="d-flex justify-content-center gap-3">
                            <button type="button" class="btn btn-success btn-lg" id="btnKaydet">
                                <i class="bi bi-check-circle"></i> Kaydet
                            </button>
                            <button type="button" class="btn btn-primary btn-lg" id="btnGuncelle" style="display: none;">
                                <i class="bi bi-arrow-repeat"></i> Güncelle
                            </button>
                            <button type="button" class="btn btn-info btn-lg" id="btnYazdir">
                                <i class="bi bi-printer"></i> Yazdır
                            </button>
                            <button type="button" class="btn btn-secondary btn-lg" id="btnVazgec">
                                <i class="bi bi-x-circle"></i> Vazgeç
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="../02_js/site.js"></script>
  
   </body>
   </html>
</asp:Content>
