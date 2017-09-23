<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="FirstLinqSample.aspx.cs" Inherits="SamplePages_FirstLinqSample" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1> Albums for Artist</h1>
    <asp:Label ID="lblArtist" runat="server" Text="Select an Artist:"></asp:Label>
    <asp:DropDownList ID="ddlArtist" runat="server" DataSourceID="odsArtist" DataTextField="Name" DataValueField="ArtistId"></asp:DropDownList>
    <asp:Button ID="btnSubmit" runat="server" Text="Submit" />
    <br />
    <asp:GridView ID="gvArtistAlbums" runat="server" AutoGenerateColumns="False" DataSourceID="odsArtistAlbums" AllowPaging="True">
        <Columns>
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
            <asp:BoundField DataField="Released" HeaderText="Released" SortExpression="Released"></asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="odsArtist" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="Artists_List" TypeName="ChinookSystem.BLL.ArtistController"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsArtistAlbums" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="Albums_ListforArtist" TypeName="ChinookSystem.BLL.AlbumController">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlArtist" PropertyName="SelectedValue" DefaultValue="0" Name="artistId" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

