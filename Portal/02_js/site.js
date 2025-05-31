 // Form validasyonu ve etkileşimleri
        class PersonelForm {
            constructor() {
                this.form = document.getElementById('personelForm');
                this.currentPhoto = null; // ==> Fotoğraf verisi için eklendi
                this.isEditMode = false; // ==> Düzenleme modunu belirlemek için eklendi
                this.initializeEvents();
            }

            initializeEvents() {
                // TC Kimlik sorgulama
                document.getElementById('tcSorgula').addEventListener('click', () => {
                    this.tcKimlikSorgula();
                });

                // Sicil sorgulama
                document.getElementById('sicilSorgula').addEventListener('click', () => {
                    this.sicilSorgula();
                });

                // ==> Fotoğraf yükleme event'leri eklendi
                document.getElementById('photoUploadArea').addEventListener('click', () => {
                    document.getElementById('fotoUpload').click();
                });

                document.getElementById('fotoUpload').addEventListener('change', (e) => {
                    this.handlePhotoUpload(e);
                });

                document.getElementById('fotoSil').addEventListener('click', () => {
                    this.removePhoto();
                });

                // Form butonları
                document.getElementById('btnKaydet').addEventListener('click', () => {
                    this.formKaydet();
                });

                document.getElementById('btnGuncelle').addEventListener('click', () => {
                    this.formGuncelle();
                });

                document.getElementById('btnYazdir').addEventListener('click', () => {
                    this.formYazdir();
                });

                document.getElementById('btnVazgec').addEventListener('click', () => {
                    this.formTemizle();
                });

                // Telefon formatı
                this.telefonFormatiEkle('ceptel');
                this.telefonFormatiEkle('evTel');
                this.telefonFormatiEkle('acilDurumTel');

                // TC Kimlik formatı
                this.tcKimlikFormati();

                // ==> Gelişmiş validasyonlar eklendi
                this.advancedValidations();

                // Engel durumu değişikliği
                document.getElementById('engelDurumu').addEventListener('change', (e) => {
                    const aciklamaField = document.getElementById('engelAciklama');
                    if (e.target.value === 'var') {
                        aciklamaField.required = true;
                        aciklamaField.parentElement.style.display = 'block';
                    } else {
                        aciklamaField.required = false;
                        if (e.target.value === 'yok') {
                            aciklamaField.value = '';
                        }
                    }
                });
            }

            // ==> Fotoğraf yükleme fonksiyonu eklendi
            handlePhotoUpload(event) {
                const file = event.target.files[0];
                if (!file) return;

                // Dosya boyutu kontrolü
                if (file.size > 2 * 1024 * 1024) { // 2MB
                    this.showToast('Fotoğraf boyutu 2MB\'dan küçük olmalıdır', 'error');
                    return;
                }

                // Dosya tipi kontrolü
                if (!file.type.match('image.*')) {
                    this.showToast('Sadece resim dosyaları yüklenebilir', 'error');
                    return;
                }

                const reader = new FileReader();
                reader.onload = (e) => {
                    this.displayPhoto(e.target.result);
                    this.currentPhoto = file;
                    this.showToast('Fotoğraf başarıyla yüklendi', 'success');
                };
                reader.readAsDataURL(file);
            }

            // ==> Fotoğraf görüntüleme fonksiyonu eklendi
            displayPhoto(src) {
                const photoContent = document.getElementById('photoContent');
                photoContent.innerHTML = `
                    <img src="${src}" alt="Personel Fotoğrafı" class="photo-preview">
                    <p class="mt-2 mb-0 text-muted small">Fotoğrafı değiştirmek için tıklayın</p>
                `;
                document.getElementById('fotoSil').style.display = 'inline-block';
            }

            // ==> Fotoğraf silme fonksiyonu eklendi
            removePhoto() {
                const photoContent = document.getElementById('photoContent');
                photoContent.innerHTML = `
                    <i class="bi bi-camera fs-1 text-muted"></i>
                    <p class="mt-2 mb-0 text-muted">Fotoğraf Yükle</p>
                    <small class="text-muted">JPG, PNG (Max: 2MB)</small>
                `;
                document.getElementById('fotoUpload').value = '';
                document.getElementById('fotoSil').style.display = 'none';
                this.currentPhoto = null;
                this.showToast('Fotoğraf silindi', 'info');
            }

            // ==> Gelişmiş validasyonlar eklendi
            advancedValidations() {
                // E-posta validasyonu
                const emailInput = document.getElementById('email');
                emailInput.addEventListener('blur', () => {
                    if (emailInput.value && !this.isValidEmail(emailInput.value)) {
                        emailInput.setCustomValidity('Geçerli bir e-posta adresi giriniz');
                    } else {
                        emailInput.setCustomValidity('');
                    }
                });

                // Telefon validasyonları
                const telefonlar = ['ceptel', 'evTel', 'acilDurumTel'];
                telefonlar.forEach(telId => {
                    const telInput = document.getElementById(telId);
                    if (telInput) {
                        telInput.addEventListener('blur', () => {
                            if (telInput.value && !this.isValidPhoneNumber(telInput.value)) {
                                telInput.setCustomValidity('Geçerli bir telefon numarası giriniz');
                            } else {
                                telInput.setCustomValidity('');
                            }
                        });
                    }
                });

                // Doğum tarihi validasyonu
                const dogumTarihi = document.getElementById('dogumTarihi');
                dogumTarihi.addEventListener('change', () => {
                    if (dogumTarihi.value) {
                        const yas = this.calculateAge(dogumTarihi.value);
                        if (yas < 18 || yas > 65) {
                            dogumTarihi.setCustomValidity('Yaş 18-65 arasında olmalıdır');
                        } else {
                            dogumTarihi.setCustomValidity('');
                        }
                    }
                });
            }

            // ==> TC Kimlik sorgulama fonksiyonu tamamlandı
            tcKimlikSorgula() {
                   const tcKimlik = document.getElementById('tcKimlik').value;
                   
                   if (!this.isValidTcKimlik(tcKimlik)) {
                       this.showToast('Geçerli bir TC Kimlik numarası giriniz', 'error');
                       return;
                   }
                   
                   const btn = document.getElementById('tcSorgula');
                   const spinner = btn.querySelector('.loading-spinner');
                   
                   // Loading durumu
                   spinner.style.display = 'inline-block';
                   btn.disabled = true;
                   
                   // Simülasyon - gerçek API'ye bağlanacak
                   setTimeout(() => {
                       // Örnek veri doldurma
                       this.fillSampleData();
                       this.showToast('Bilgiler TC Kimlik ile sorgulandı', 'success');
                       
                       spinner.style.display = 'none';
                       btn.disabled = false;
                   }, 1500);
               }

               sicilSorgula() {
                   const sicilNo = document.getElementById('sicilNo').value;
                   
                   if (!sicilNo.trim()) {
                       this.showToast('Sicil numarası giriniz', 'error');
                       return;
                   }
                   
                   const btn = document.getElementById('sicilSorgula');
                   const spinner = btn.querySelector('.loading-spinner');
                   
                   // Loading durumu
                   spinner.style.display = 'inline-block';
                   btn.disabled = true;
                   
                   // Simülasyon - gerçek API'ye bağlanacak
                   setTimeout(() => {
                       this.fillExistingPersonelData();
                       this.setEditMode(true);
                       this.showToast('Personel bilgileri sicil no ile getirildi', 'success');
                       
                       spinner.style.display = 'none';
                       btn.disabled = false;
                   }, 1500);
               }

               // ==> Örnek veri doldurma fonksiyonu eklendi
               fillSampleData() {
                   document.getElementById('ad').value = 'Mehmet';
                   document.getElementById('soyad').value = 'Yılmaz';
                   document.getElementById('dogumYeri').value = 'Ankara';
                   document.getElementById('dogumTarihi').value = '1985-05-15';
                   document.getElementById('cinsiyet').value = 'E';
               }

               // ==> Mevcut personel verisi doldurma fonksiyonu eklendi
               fillExistingPersonelData() {
                   document.getElementById('ad').value = 'Ayşe';
                   document.getElementById('soyad').value = 'Kaya';
                   document.getElementById('dogumYeri').value = 'İstanbul';
                   document.getElementById('dogumTarihi').value = '1988-03-20';
                   document.getElementById('cinsiyet').value = 'K';
                   document.getElementById('ceptel').value = '0532 123 45 67';
                   document.getElementById('email').value = 'ayse.kaya@kurum.gov.tr';
                   document.getElementById('unvan').value = 'uzman';
                   document.getElementById('birim').value = 'idari';
                   document.getElementById('adres').value = 'Çankaya Mahallesi, Ankara';
               }

               // ==> Düzenleme modu ayarlama fonksiyonu eklendi
               setEditMode(isEdit) {
                   this.isEditMode = isEdit;
                   const btnKaydet = document.getElementById('btnKaydet');
                   const btnGuncelle = document.getElementById('btnGuncelle');
                   
                   if (isEdit) {
                       btnKaydet.style.display = 'none';
                       btnGuncelle.style.display = 'inline-block';
                   } else {
                       btnKaydet.style.display = 'inline-block';
                       btnGuncelle.style.display = 'none';
                   }
               }

               formKaydet() {
                   if (!this.validateForm()) {
                       this.showToast('Lütfen gerekli alanları doldurunuz', 'error');
                       return;
                   }
                   
                   const formData = this.getFormData();
                   
                   // API'ye kayıt gönderme simülasyonu
                   setTimeout(() => {
                       this.showToast('Personel kaydı başarıyla oluşturuldu', 'success');
                       this.formTemizle();
                   }, 1000);
               }

               formGuncelle() {
                   if (!this.validateForm()) {
                       this.showToast('Lütfen gerekli alanları doldurunuz', 'error');
                       return;
                   }
                   
                   const formData = this.getFormData();
                   
                   // API'ye güncelleme gönderme simülasyonu
                   setTimeout(() => {
                       this.showToast('Personel bilgileri başarıyla güncellendi', 'success');
                       this.setEditMode(false);
                   }, 1000);
               }

               formYazdir() {
                   if (!this.validateForm()) {
                       this.showToast('Yazdırabilmek için form geçerli olmalıdır', 'error');
                       return;
                   }
                   
                   // Yazdırma penceresi açma
                   const printWindow = window.open('', '_blank');
                   printWindow.document.write(this.generatePrintContent());
                   printWindow.document.close();
                   printWindow.print();
               }

               // ==> Yazdırma içeriği oluşturma fonksiyonu eklendi
               generatePrintContent() {
                   const formData = this.getFormData();
                   return `
                   <!DOCTYPE html>
                   <html>
                   <head>
                       <title>Personel Bilgi Formu</title>
                       <style>
                           body { font-family: Arial, sans-serif; font-size: 12px; }
                           .header { text-align: center; border-bottom: 2px solid #333; margin-bottom: 20px; }
                           .section { margin-bottom: 15px; }
                           .section-title { font-weight: bold; background-color: #f5f5f5; padding: 5px; }
                           .field { margin: 5px 0; }
                           .field label { font-weight: bold; display: inline-block; width: 150px; }
                       </style>
                   </head>
                   <body>
                       <div class="header">
                           <h2>PERSONEL BİLGİ FORMU</h2>
                       </div>
                       <div class="section">
                           <div class="section-title">Kimlik Bilgileri</div>
                           <div class="field"><label>TC Kimlik:</label> ${formData.tcKimlik}</div>
                           <div class="field"><label>Ad Soyad:</label> ${formData.ad} ${formData.soyad}</div>
                           <div class="field"><label>Doğum Tarihi:</label> ${formData.dogumTarihi}</div>
                       </div>
                       <div class="section">
                           <div class="section-title">İş Bilgileri</div>
                           <div class="field"><label>Sicil No:</label> ${formData.sicilNo}</div>
                           <div class="field"><label>Unvan:</label> ${formData.unvan}</div>
                           <div class="field"><label>Birim:</label> ${formData.birim}</div>
                       </div>
                       <div class="section">
                           <div class="section-title">İletişim Bilgileri</div>
                           <div class="field"><label>Telefon:</label> ${formData.ceptel}</div>
                           <div class="field"><label>E-posta:</label> ${formData.email}</div>
                           <div class="field"><label>Adres:</label> ${formData.adres}</div>
                       </div>
                   </body>
                   </html>
                   `;
               }

               formTemizle() {
                   this.form.reset();
                   this.removePhoto();
                   this.setEditMode(false);
                   this.form.classList.remove('was-validated');
                   this.showToast('Form temizlendi', 'info');
               }

               // ==> Form verilerini toplama fonksiyonu eklendi
               getFormData() {
                   const formData = new FormData(this.form);
                   const data = {};
                   
                   // Tüm form elemanlarını topla
                   const elements = this.form.querySelectorAll('input, select, textarea');
                   elements.forEach(element => {
                       if (element.type !== 'file') {
                           data[element.id] = element.value;
                       }
                   });
                   
                   // Fotoğraf varsa ekle
                   if (this.currentPhoto) {
                       data.photo = this.currentPhoto;
                   }
                   
                   return data;
               }

               validateForm() {
                   let isValid = true;
                   
                   // Zorunlu alanları kontrol et
                   const requiredFields = [
                       'tcKimlik', 'sicilNo', 'ad', 'soyad', 
                       'unvan', 'kurumBaslama', 'ceptel', 'adres'
                   ];
                   
                   requiredFields.forEach(fieldId => {
                       const field = document.getElementById(fieldId);
                       if (!field.value.trim()) {
                           field.classList.add('is-invalid');
                           isValid = false;
                       } else {
                           field.classList.remove('is-invalid');
                       }
                   });
                   
                   // TC Kimlik kontrolü
                   const tcKimlik = document.getElementById('tcKimlik').value;
                   if (tcKimlik && !this.isValidTcKimlik(tcKimlik)) {
                       document.getElementById('tcKimlik').classList.add('is-invalid');
                       isValid = false;
                   }
                   
                   // E-posta kontrolü
                   const email = document.getElementById('email').value;
                   if (email && !this.isValidEmail(email)) {
                       document.getElementById('email').classList.add('is-invalid');
                       isValid = false;
                   }
                   
                   // Telefon kontrolları
                   const ceptel = document.getElementById('ceptel').value;
                   if (ceptel && !this.isValidPhoneNumber(ceptel)) {
                       document.getElementById('ceptel').classList.add('is-invalid');
                       isValid = false;
                   }
                   
                   this.form.classList.add('was-validated');
                   return isValid;
               }

               // ==> Validasyon yardımcı fonksiyonları eklendi
               isValidTcKimlik(tcKimlik) {
                   if (!tcKimlik || tcKimlik.length !== 11) return false;
                   
                   const digits = tcKimlik.split('').map(Number);
                   const sum1 = digits[0] + digits[2] + digits[4] + digits[6] + digits[8];
                   const sum2 = digits[1] + digits[3] + digits[5] + digits[7];
                   
                   const check1 = (sum1 * 7 - sum2) % 10;
                   const check2 = (sum1 + sum2 + digits[9]) % 10;
                   
                   return check1 === digits[9] && check2 === digits[10];
               }

               isValidEmail(email) {
                   const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                   return emailRegex.test(email);
               }

               isValidPhoneNumber(phone) {
                   const phoneRegex = /^0[0-9]{3}\s[0-9]{3}\s[0-9]{2}\s[0-9]{2}$/;
                   return phoneRegex.test(phone);
               }

               calculateAge(birthDate) {
                   const today = new Date();
                   const birth = new Date(birthDate);
                   let age = today.getFullYear() - birth.getFullYear();
                   const monthDiff = today.getMonth() - birth.getMonth();
                   
                   if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birth.getDate())) {
                       age--;
                   }
                   
                   return age;
               }

               // ==> Telefon formatı ekleme fonksiyonu eklendi
               telefonFormatiEkle(inputId) {
                   const input = document.getElementById(inputId);
                   if (!input) return;
                   
                   input.addEventListener('input', (e) => {
                       let value = e.target.value.replace(/\D/g, '');
                       
                       if (value.length > 0) {
                           if (value.length <= 4) {
                               value = value.replace(/(\d{4})/, '$1');
                           } else if (value.length <= 7) {
                               value = value.replace(/(\d{4})(\d{3})/, '$1 $2');
                           } else if (value.length <= 9) {
                               value = value.replace(/(\d{4})(\d{3})(\d{2})/, '$1 $2 $3');
                           } else {
                               value = value.replace(/(\d{4})(\d{3})(\d{2})(\d{2})/, '$1 $2 $3 $4');
                           }
                       }
                       
                       e.target.value = value;
                   });
               }

               // ==> TC Kimlik formatı ekleme fonksiyonu eklendi
               tcKimlikFormati() {
                   const tcInput = document.getElementById('tcKimlik');
                   tcInput.addEventListener('input', (e) => {
                       e.target.value = e.target.value.replace(/\D/g, '').slice(0, 11);
                   });
               }

               // ==> Toast mesaj gösterme fonksiyonu eklendi
               showToast(message, type = 'info') {
                   const toastContainer = document.getElementById('toastContainer');
                   const toastId = 'toast-' + Date.now();
                   
                   const bgClass = {
                       'success': 'bg-success',
                       'error': 'bg-danger',
                       'warning': 'bg-warning',
                       'info': 'bg-info'
                   }[type] || 'bg-info';
                   
                   const iconClass = {
                       'success': 'bi-check-circle',
                       'error': 'bi-exclamation-triangle',
                       'warning': 'bi-exclamation-triangle',
                       'info': 'bi-info-circle'
                   }[type] || 'bi-info-circle';
                   
                   const toastHtml = `
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
                   
                   const toastElement = document.getElementById(toastId);
                   const toast = new bootstrap.Toast(toastElement, {
                       autohide: true,
                       delay: 5000
                   });
                   
                   toast.show();
                   
                   // Toast kapandığında DOM'dan kaldır
                   toastElement.addEventListener('hidden.bs.toast', () => {
                       toastElement.remove();
                   });
               }
           }

           // Form sınıfını başlat
           document.addEventListener('DOMContentLoaded', () => {
               new PersonelForm();
           });