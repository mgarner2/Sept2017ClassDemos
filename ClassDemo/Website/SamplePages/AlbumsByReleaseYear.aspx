<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="AlbumsByReleaseYear.aspx.cs" Inherits="SamplePages_AlbumsByReleaseYear" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Albums by Release Year</h1>
    <asp:Label ID="lblMin" runat="server" Text="Enter minimum year"></asp:Label>
    <asp:TextBox ID="txtMin" runat="server"></asp:TextBox>
    <asp:Label ID="lblMax" runat="server" Text="Enter maximum year"></asp:Label>
    <asp:TextBox ID="txtMax" runat="server"></asp:TextBox>
    <asp:LinkButton ID="btnSubmit" runat="server">Submit</asp:LinkButton>
    <br />
    <asp:GridView ID="gvAlbums" runat="server" AutoGenerateColumns="False" DataSourceID="odsAlbums" AllowPaging="True">
        <Columns>
            <%--<asp:BoundField DataField="AlbumId" HeaderText="AlbumId" SortExpression="AlbumId"></asp:BoundField>--%>
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
            <%--<asp:BoundField DataField="ArtistId" HeaderText="ArtistId" SortExpression="ArtistId"></asp:BoundField>--%>
            <asp:BoundField DataField="ReleaseYear" HeaderText="ReleaseYear" SortExpression="ReleaseYear"></asp:BoundField>
            <asp:BoundField DataField="ReleaseLabel" HeaderText="ReleaseLabel" SortExpression="ReleaseLabel"></asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="odsAlbums" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="Albums_ListByReleaseYear" TypeName="ChinookSystem.BLL.AlbumController">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtMin" PropertyName="Text" DefaultValue="1900" Name="minyear" Type="Int32"></asp:ControlParameter>
            <asp:ControlParameter ControlID="txtMax" PropertyName="Text" DefaultValue="2017" Name="maxyear" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

