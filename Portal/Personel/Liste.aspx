<%@ Page Title="Personel Listesi" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Liste.aspx.cs" Inherits="Portal.Personel.Liste" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table-responsive {
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        }
        
        .action-buttons {
            white-space: nowrap;
        }
        
        .photo-thumbnail {
            width: 40px;
            height: 40px;
            object-fit: cover;
            border-radius: 50%;
        }
        
        .search-section {
            background: #f8f9fa;
            border-radius: 0.375rem;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }
        
        .status-badge {
            font-size: 0.75rem;
        }
        
        .pagination-info {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-top: 1rem;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid my-4">
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-md-8">
                <h2><i class="bi bi-people-fill"></i> Personel Listesi</h2>
                <p class="text-muted">Kayıtlı personelleri görüntüleyin ve yönetin</p>
            </div>
            <div class="col-md-4 text-end">
                <a href="Kayit.aspx" class="btn btn-success">
                    <i class="bi bi-person-plus"></i> Yeni Personel Ekle
                </a>
            </div>
        </div>

        <!-- Arama ve Filtreleme -->
        <div class="search-section">
            <div class="row g-3">
                <div class="col-md-3">
                    <label for="txtArama" class="form-label">Genel Arama</label>
                    <div class="input-group">
                        <asp:TextBox ID="txtArama" runat="server" CssClass="form-control" placeholder="Ad, soyad, TC, sicil..."></asp:TextBox>
                        <asp:Button ID="btnAra" runat="server" CssClass="btn btn-outline-primary" Text="Ara" OnClick="btnAra_Click" />
                    </div>
                </div>
                <div class="col-md-2">
                    <label for="ddlBirim" class="form-label">Birim</label>
                    <asp:DropDownList ID="ddlBirim" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="Filtrele">
                        <asp:ListItem Value="">Tümü</asp:ListItem>
                        <asp:ListItem Value="idari">İdari İşler</asp:ListItem>
                        <asp:ListItem Value="mali">Mali İşler</asp:ListItem>
                        <asp:ListItem Value="teknik">Teknik İşler</asp:ListItem>
                        <asp:ListItem Value="insankaynaklari">İnsan Kaynakları</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <label for="ddlUnvan" class="form-label">Unvan</label>
                    <asp:DropDownList ID="ddlUnvan" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="Filtrele">
                        <asp:ListItem Value="">Tümü</asp:ListItem>
                        <asp:ListItem Value="memur">Memur</asp:ListItem>
                        <asp:ListItem Value="uzman">Uzman</asp:ListItem>
                        <asp:ListItem Value="mudurassistani">Müdür Yardımcısı</asp:ListItem>
                        <asp:ListItem Value="mudur">Müdür</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <label for="ddlDurum" class="form-label">Durum</label>
                    <asp:DropDownList ID="ddlDurum" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="Filtrele">
                        <asp:ListItem Value="">Tümü</asp:ListItem>
                        <asp:ListItem Value="aktif">Aktif</asp:ListItem>
                        <asp:ListItem Value="pasif">Pasif</asp:ListItem>
                        <asp:ListItem Value="izinli">İzinli</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <label class="form-label">&nbsp;</label>
                    <div class="d-grid gap-2 d-md-flex">
                        <asp:Button ID="btnTemizle" runat="server" CssClass="btn btn-outline-secondary" Text="Temizle" OnClick="btnTemizle_Click" />
                        <asp:Button ID="btnExcel" runat="server" CssClass="btn btn-outline-success" Text="Excel" OnClick="btnExcel_Click" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Personel Tablosu -->
        <div class="card">
            <div class="card-header">
                <div class="row align-items-center">
                    <div class="col">
                        <h5 class="mb-0">
                            <asp:Label ID="lblToplamKayit" runat="server" Text="Toplam: 0 kayıt"></asp:Label>
                        </h5>
                    </div>
                    <div class="col-auto">
                        <div class="input-group input-group-sm">
                            <span class="input-group-text">Sayfa başına:</span>
                            <asp:DropDownList ID="ddlSayfaBoyutu" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="SayfaBoyutuDegisti">
                                <asp:ListItem Value="10">10</asp:ListItem>
                                <asp:ListItem Value="25" Selected="True">25</asp:ListItem>
                                <asp:ListItem Value="50">50</asp:ListItem>
                                <asp:ListItem Value="100">100</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvPersonel" runat="server" 
                        CssClass="table table-hover mb-0" 
                        AutoGenerateColumns="false"
                        AllowPaging="true" 
                        PageSize="25"
                        OnPageIndexChanging="gvPersonel_PageIndexChanging"
                        OnRowCommand="gvPersonel_RowCommand"
                        OnRowDataBound="gvPersonel_RowDataBound"
                        EmptyDataText="Kayıt bulunamadı">
                        
                        <HeaderStyle CssClass="table-dark" />
                        <PagerStyle CssClass="pagination-custom" />
                        
                        <Columns>
                            <asp:TemplateField HeaderText="#" ItemStyle-Width="50px" ItemStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 + (gvPersonel.PageIndex * gvPersonel.PageSize) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:TemplateField HeaderText="Fotoğraf" ItemStyle-Width="60px" ItemStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <img src='<%# GetPhotoUrl(Eval("Fotograf")) %>' class="photo-thumbnail" alt="Fotoğraf" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:BoundField DataField="SicilNo" HeaderText="Sicil No" ItemStyle-Width="100px" />
                            <asp:BoundField DataField="TCKimlik" HeaderText="TC Kimlik" ItemStyle-Width="120px" />
                            
                            <asp:TemplateField HeaderText="Ad Soyad">
                                <ItemTemplate>
                                    <strong><%# Eval("Ad") %> <%# Eval("Soyad") %></strong>
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:BoundField DataField="Unvan" HeaderText="Unvan" ItemStyle-Width="120px" />
                            <asp:BoundField DataField="Birim" HeaderText="Birim" ItemStyle-Width="120px" />
                            
                            <asp:TemplateField HeaderText="İletişim" ItemStyle-Width="140px">
                                <ItemTemplate>
                                    <small>
                                        <i class="bi bi-telephone"></i> <%# Eval("CepTel") %><br/>
                                        <i class="bi bi-envelope"></i> <%# Eval("Email") %>
                                    </small>
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:TemplateField HeaderText="Durum" ItemStyle-Width="80px" ItemStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <span class='<%# GetStatusBadgeClass(Eval("CalismaDurumu").ToString()) %>'>
                                        <%# GetStatusText(Eval("CalismaDurumu").ToString()) %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:TemplateField HeaderText="İşlemler" ItemStyle-Width="120px" ItemStyle-CssClass="text-center action-buttons">
                                <ItemTemplate>
                                    <asp:Button ID="btnGoruntule" runat="server" 
                                        CssClass="btn btn-sm btn-outline-info me-1" 
                                        Text="👁" ToolTip="Görüntüle"
                                        CommandName="Goruntule" 
                                        CommandArgument='<%# Eval("ID") %>' />
                                    
                                    <asp:Button ID="btnDuzenle" runat="server" 
                                        CssClass="btn btn-sm btn-outline-primary me-1" 
                                        Text="✏️" ToolTip="Düzenle"
                                        CommandName="Duzenle" 
                                        CommandArgument='<%# Eval("ID") %>' />
                                    
                                    <asp:Button ID="btnSil" runat="server" 
                                        CssClass="btn btn-sm btn-outline-danger" 
                                        Text="🗑️" ToolTip="Sil"
                                        CommandName="Sil" 
                                        CommandArgument='<%# Eval("ID") %>'
                                        OnClientClick="return confirm('Bu personeli silmek istediğinizden emin misiniz?');" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        
                        <PagerTemplate>
                            <div class="d-flex justify-content-between align-items-center p-3">
                                <div>
                                    <asp:Label ID="lblSayfaBilgi" runat="server"></asp:Label>
                                </div>
                                <nav>
                                    <ul class="pagination pagination-sm mb-0">
                                        <li class="page-item <%# gvPersonel.PageIndex == 0 ? "disabled" : "" %>">
                                            <asp:LinkButton ID="lnkIlk" runat="server" CssClass="page-link" CommandName="Page" CommandArgument="First">İlk</asp:LinkButton>
                                        </li>
                                        <li class="page-item <%# gvPersonel.PageIndex == 0 ? "disabled" : "" %>">
                                            <asp:LinkButton ID="lnkOnceki" runat="server" CssClass="page-link" CommandName="Page" CommandArgument="Prev">‹</asp:LinkButton>
                                        </li>
                                        
                                        <%# GetPageNumbers() %>
                                        
                                        <li class="page-item <%# gvPersonel.PageIndex == gvPersonel.PageCount - 1 ? "disabled" : "" %>">
                                            <asp:LinkButton ID="lnkSonraki" runat="server" CssClass="page-link" CommandName="Page" CommandArgument="Next">›</asp:LinkButton>
                                        </li>
                                        <li class="page-item <%# gvPersonel.PageIndex == gvPersonel.PageCount - 1 ? "disabled" : "" %>">
                                            <asp:LinkButton ID="lnkSon" runat="server" CssClass="page-link" CommandName="Page" CommandArgument="Last">Son</asp:LinkButton>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </PagerTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

    <!-- Toast Container -->
    <div class="toast-container position-fixed bottom-0 end-0 p-3">
        <div id="liveToast" class="toast" role="alert">
            <div class="toast-header">
                <strong class="me-auto">Bilgi</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
            </div>
            <div class="toast-body" id="toastMessage">
            </div>
        </div>
    </div>
</asp:Content>