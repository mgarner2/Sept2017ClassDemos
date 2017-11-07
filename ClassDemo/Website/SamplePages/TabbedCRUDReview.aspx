<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="TabbedCRUDReview.aspx.cs" Inherits="SamplePages_TabbedCRUDReview" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="row jumbotron">
        <h1>Tabbed CRUD REview</h1>
    </div>
    <uc1:MessageUserControl runat="server" ID="MessageUserControl" />
    <%-- Bootstrap - Programable movement between tabs is done with Javascript --%>
     <div class="row">
        <div class="col-md-12"> 
            <%-- md-12 is a Bootstrap Block - Use md blocks for larger laptops or smaller desktop screens  --%>
            <!-- Nav tabs -->
            <ul class="nav nav-tabs">
                <li class="active"><a href="#search" data-toggle="tab">Lookup</a></li>
                <li><a href="#crud" data-toggle="tab">Add Update Delete</a></li>
                <li><a href="#listviewcrud" data-toggle="tab">ListView Crud</a></li>
                <%-- #id = ID of the item on the page to point to. data-toggle = tab --%>
            </ul>
            <!-- tab content area -->
            <div class="tab-content">
                <%-- All tabs --%>
                <!-- user tab -->
                <div class="tab-pane fade in active" id="search">
                    <%-- Single tab --%>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                           Enter Album Name:
                            <asp:TextBox ID="SearchArgAlbum" runat="server"></asp:TextBox>
                            <asp:Button ID="Fetch" runat="server" Text="Fetch" /><br />
                            <asp:GridView ID="SearchResults" runat="server" 
                                AutoGenerateColumns="False" DataSourceID="SearchResultsODS" 
                                AllowPaging="True" GridLines="None" 
                                OnSelectedIndexChanged="SearchResults_SelectedIndexChanged" OnPageIndexChanging="SearchResults_PageIndexChanging" >
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# Bind("AlbumId") %>'
                                                ID="AlbumID" Visible="false"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
                                    <asp:TemplateField >
                                        <ItemTemplate>
                                            <asp:DropDownList runat="server"
                                                ID="ArtistList" 
                                                DataSourceID="ArtistListODS" 
                                                DataTextField="Name" 
                                                DataValueField="ArtistId"
                                                SelectedValue='<%# Bind("ArtistID") %>'>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="ReleaseYear" HeaderText="ReleaseYear" SortExpression="ReleaseYear"></asp:BoundField>
                                    <asp:BoundField DataField="ReleaseLabel" HeaderText="ReleaseLabel" SortExpression="ReleaseLabel"></asp:BoundField>
                                    <asp:CommandField SelectText="View" ShowSelectButton="True"></asp:CommandField>

                                </Columns>
                                <SelectedRowStyle BackColor="#99CCFF" />
                            </asp:GridView>
                            <asp:ObjectDataSource ID="SearchResultsODS" runat="server" 
                                OldValuesParameterFormatString="original_{0}" 
                                SelectMethod="Albums_ListByTitle" 
                                TypeName="ChinookSystem.BLL.AlbumController">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="SearchArgAlbum" 
                                        PropertyName="Text" DefaultValue="zxzx" Name="title" 
                                        Type="String"></asp:ControlParameter>
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                
                </div> <%--eop--%>
                <!-- role tab -->
                <div class="tab-pane fade" id="crud">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:Label ID="Message" runat="server" ></asp:Label>
                           <table>
                               <tr>
                                   <td>Album ID:</td>
                                   <td>
                                       <asp:Label ID="AlbumID" runat="server" ></asp:Label>
                                   </td>
                               </tr>
                               <tr>
                                   <td>Title:</td>
                                   <td>
                                       <asp:TextBox ID="AlbumTitle" runat="server" ></asp:TextBox>
                                   </td>
                               </tr>
                               <tr>
                                   <td>Artist:</td>
                                   <td>
                                       <asp:DropDownList ID="ArtistList" runat="server" 
                                           DataSourceID="ArtistListODS" 
                                           DataTextField="Name" 
                                           DataValueField="ArtistId"></asp:DropDownList>
                                   </td>
                               </tr>
                               <tr>
                                   <td>Release Year:</td>
                                   <td>
                                       <asp:TextBox ID="ReleaseYear" runat="server" ></asp:TextBox>
                                   </td>
                               </tr>
                               <tr>
                                   <td>Release Label:</td>
                                   <td>
                                       <asp:TextBox ID="ReleaseLabel" runat="server" ></asp:TextBox>
                                   </td>
                               </tr>
                               <tr>
                                   <td colspan="2">
                                   <asp:Button ID="Add" runat="server" Text="Add" Width="100px" OnClick="Add_Click" />&nbsp;&nbsp;
                                   <asp:Button ID="Update" runat="server" Text="Update" Width="100px" OnClick="Update_Click"/>&nbsp;&nbsp;
                                   <asp:Button ID="Delete" runat="server" Text="Delete" Width="100px" OnClick="Delete_Click"/>&nbsp;&nbsp;
                                   <asp:Button ID="Clear" runat="server" Text="Clear" Width="100px" OnClick="Clear_Click"/>
                                   </td>
                               </tr>
                           </table>
                            <asp:ObjectDataSource ID="ArtistListODS" runat="server" 
                                OldValuesParameterFormatString="original_{0}" 
                                SelectMethod="Artists_List" 
                                TypeName="ChinookSystem.BLL.ArtistController"></asp:ObjectDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div> <%--eop--%>
                <!-- unregistered user tab -->
                <div class="tab-pane fade in active" id="listviewcrud">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <asp:ListView ID="lvCRUD" runat="server" DataSourceID="odsCRUD" InsertItemPosition="LastItem"
                                DataKeyName="AlbumId">
                                <%-- Need the DataKeyName to DELETE --%>

                                <AlternatingItemTemplate>
                                    <tr style="background-color: #FFF8DC;">
                                        <td>
                                            <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                                            <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                                        </td>
                                        <td>
                                            <asp:Label Text='<%# Eval("AlbumId") %>' runat="server" ID="AlbumIdLabel" Width="50px" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Title") %>' runat="server" ID="TitleLabel" /></td>
                                        <td>
                                            <asp:DropDownList ID="ddlArtistId" runat="server" DataSourceID="ArtistListODS" DataTextField="Name" DataValueField="ArtistId"
                                            SelectedValue='<%# Eval("ArtistId") %>' Enabled="false"></asp:DropDownList>
                                            <%--<asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal">
                                                <asp:ListItem Value="M">Male</asp:ListItem>
                                                <asp:ListItem Value="F">Female</asp:ListItem>
                                            </asp:RadioButtonList>--%>
                                        </td>                                        
                                        <%--<td>
                                            <asp:Label Text='<%# Eval("ArtistId") %>' runat="server" ID="ArtistIdLabel" /></td>--%>
                                        <td align="center">
                                            <asp:Label Text='<%# Eval("ReleaseYear") %>' runat="server" ID="ReleaseYearLabel" Width="50px"/></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("ReleaseLabel") %>' runat="server" ID="ReleaseLabelLabel" /></td>
                                        <%-- Read only Eval (...) Can't insert/update --%>
<%--                                    <td>
                                            <asp:Label Text='<%# Eval("Artist") %>' runat="server" ID="ArtistLabel" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Tracks") %>' runat="server" ID="TracksLabel" /></td>--%>
                                    </tr>
                                </AlternatingItemTemplate>
                                <EditItemTemplate>
                                    <tr style="background-color: #008A8C; color: #FFFFFF;">
                                        <td>
                                            <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" />
                                            <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                                        </td>
                                        <td>
                                            <%-- Bidirectional Bind() -- Only has meaning on Insert and Update template --%>
                                            <%-- Must update the column properties on ALL templates --%>
                                            <asp:TextBox Text='<%# Bind("AlbumId") %>' runat="server" ID="AlbumIdTextBox" Width="50px" Enabled="false"/></td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("Title") %>' runat="server" ID="TitleTextBox" /></td>
                                        <%--<td>
                                            <asp:TextBox Text='<%# Bind("ArtistId") %>' runat="server" ID="ArtistIdTextBox" /></td>--%>
                                        <td><asp:DropDownList ID="ddlArtistId" runat="server" DataSourceID="ArtistListODS" DataTextField="Name" DataValueField="ArtistId"
                                            SelectedValue='<%# Bind("ArtistId") %>'></asp:DropDownList></td>
                                        <td align="center">
                                            <asp:TextBox Text='<%# Bind("ReleaseYear") %>' runat="server" ID="ReleaseYearTextBox" Width="50px" /></td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("ReleaseLabel") %>' runat="server" ID="ReleaseLabelTextBox" /></td>
<%--                                    <td>
                                            <asp:TextBox Text='<%# Bind("Artist") %>' runat="server" ID="ArtistTextBox" /></td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("Tracks") %>' runat="server" ID="TracksTextBox" /></td>--%>
                                    </tr>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <tr style="">
                                        <td>
                                            <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" />
                                            <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" />
                                        </td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("AlbumId") %>'  runat="server" ID="AlbumIdTextBox" Width="50px" Enabled="false"/></td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("Title") %>' runat="server" ID="TitleTextBox" /></td>
                                        <%--<td>
                                            <asp:TextBox Text='<%# Bind("ArtistId") %>' runat="server" ID="ArtistIdTextBox" /></td>--%>
                                        <td><asp:DropDownList ID="ddlArtistId" runat="server" DataSourceID="ArtistListODS" DataTextField="Name" DataValueField="ArtistId"
                                            SelectedValue='<%# Bind("ArtistId") %>'></asp:DropDownList></td>
                                        <td align="center">
                                            <asp:TextBox Text='<%# Bind("ReleaseYear") %>' runat="server" ID="ReleaseYearTextBox" Width="50px" /></td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("ReleaseLabel") %>' runat="server" ID="ReleaseLabelTextBox" /></td>
<%--                                    <td>
                                            <asp:TextBox Text='<%# Bind("Artist") %>' runat="server" ID="ArtistTextBox" /></td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("Tracks") %>' runat="server" ID="TracksTextBox" /></td>--%>
                                    </tr>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <tr style="background-color: #DCDCDC; color: #000000;">
                                        <td>
                                            <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                                            <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                                        </td>
                                        <td>
                                            <asp:Label Text='<%# Eval("AlbumId") %>' runat="server" ID="AlbumIdLabel" Width="50px" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Title") %>' runat="server" ID="TitleLabel" /></td>
                                        <%--<td>
                                            <asp:Label Text='<%# Eval("ArtistId") %>' runat="server" ID="ArtistIdLabel" /></td>--%>
                                        <td>
                                            <asp:DropDownList ID="ddlArtistId" runat="server" DataSourceID="ArtistListODS" DataTextField="Name" DataValueField="ArtistId"
                                            SelectedValue='<%# Eval("ArtistId") %>' Enabled="false"></asp:DropDownList></td>
                                        <td align="center">
                                            <asp:Label Text='<%# Eval("ReleaseYear") %>' runat="server" ID="ReleaseYearLabel" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("ReleaseLabel") %>' runat="server" ID="ReleaseLabelLabel" /></td>
<%--                                    <td>
                                            <asp:Label Text='<%# Eval("Artist") %>' runat="server" ID="ArtistLabel" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Tracks") %>' runat="server" ID="TracksLabel" /></td>--%>
                                    </tr>
                                </ItemTemplate>
                                <LayoutTemplate>
                                    <table runat="server">
                                        <tr runat="server">
                                            <td runat="server">
                                                <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                                    <tr runat="server" style="background-color: #DCDCDC; color: #000000;">
                                                        <th runat="server"></th>
                                                        <th runat="server">AlbumId</th>
                                                        <th runat="server">Title</th>
                                                        <th runat="server">ArtistId</th>
                                                        <th runat="server">Rel. Year</th>
                                                        <th runat="server">Rel. Label</th>
<%--                                                    <th runat="server">Artist</th>
                                                        <th runat="server">Tracks</th>--%>
                                                    </tr>
                                                    <tr runat="server" id="itemPlaceholder"></tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr runat="server">
                                            <td runat="server" style="text-align: center; background-color: #CCCCCC; font-family: Verdana, Arial, Helvetica, sans-serif; color: #000000;">
                                                <asp:DataPager runat="server" ID="DataPager1">
                                                    <Fields>
                                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                                                        <asp:NumericPagerField></asp:NumericPagerField>
                                                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                                                    </Fields>
                                                </asp:DataPager>
                                            </td>
                                        </tr>
                                    </table>
                                </LayoutTemplate>
                                <SelectedItemTemplate>
                                    <tr style="background-color: #008A8C; font-weight: bold; color: #FFFFFF;">
                                        <td>
                                            <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                                            <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                                        </td>
                                        <td>
                                            <asp:Label Text='<%# Eval("AlbumId") %>' runat="server" ID="AlbumIdLabel" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Title") %>' runat="server" ID="TitleLabel" /></td>
                                       <%-- <td>
                                            <asp:Label Text='<%# Eval("ArtistId") %>' runat="server" ID="ArtistIdLabel" /></td>--%>
                                        <td><asp:DropDownList ID="ddlArtistId" runat="server" DataSourceID="ArtistListODS" DataTextField="Name" DataValueField="ArtistId"
                                            SelectedValue='<%# Eval("ArtistId") %>' Enabled="false"></asp:DropDownList></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("ReleaseYear") %>' runat="server" ID="ReleaseYearLabel" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("ReleaseLabel") %>' runat="server" ID="ReleaseLabelLabel" /></td>
<%--                                    <td> 
                                            <asp:Label Text='<%# Eval("Artist") %>' runat="server" ID="ArtistLabel" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Tracks") %>' runat="server" ID="TracksLabel" /></td>
    Comment out Navigational/Virtual Properties--%>
                                    </tr>
                                </SelectedItemTemplate>
                            </asp:ListView>
                            <asp:ObjectDataSource ID="odsCRUD" runat="server" 
                                DataObjectTypeName="Chinook.Data.Entities.Album" 
                                DeleteMethod="Albums_Delete" 
                                InsertMethod="Albums_Add" 
                                SelectMethod="Albums_List" 
                                UpdateMethod="Albums_Update"
                                OldValuesParameterFormatString="original_{0}"                                 
                                TypeName="ChinookSystem.BLL.AlbumController"
                                onDeleted="CheckForException"
                                onInserted="CheckForException"
                                OnUpdated="CheckForException"
                                onSelected="CheckForException">
                            </asp:ObjectDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div> <%--eop--%>
            </div>
        </div>
         <%-- Some people will collect all ODS controls and place them in a single location for easy access 
             The ODS controls are not associated with a specific tab, but the entire page--%>
    </div>
</asp:Content>

