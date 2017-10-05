<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="GenreAlbumTracks.aspx.cs" Inherits="SamplePages_GenreAlbumTracks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Genre Album Tracks</h1>
    <!--Inside a Repeator, you need a minimum of:
        *ItemTemplate
        *HeaderTemplate
        *FooterTemplate
        *AlternatingItemTemplate
        *SeparatorTemplate
        
        Outer Repeater will display the first fields from the DTO Class which do not repeat (fields that are not inside a collection)
        Nested Repeator will display the collection of the previous Repeator
        Nested repeator will get its datasource form the collection of the ***PREVIOUS DTO LEVEL*** (Either POCO or another DTO)-->
    <asp:Repeater ID="rptGenreAlbumTrackList" runat="server" DataSourceID="odsGenreAlbumTrackList"  ItemType="Chinook.Data.DTOs.GenreDTO">
        <ItemTemplate>
            <h2> Genre: <%#Eval("genre") %></h2>
            <asp:Repeater ID="rptAlbumTrackList" runat="server" DataSource='<%# Eval("albums") %>' ItemType="Chinook.Data.DTOs.AlbumDTO">
                <ItemTemplate>
                    <h4> Album: <%# string.Format("{0} ({1}) Tracks: {2}",Eval("title"), Eval("year"), Eval("tracks")) %></h4>
                  
                   <%--ListView--%>
                    <asp:ListView ID="lvTrackList" runat="server" DataSource="<%# Item.songs %>" ItemType="Chinook.Data.POCOs.TrackPOCO">
                        <LayoutTemplate>
                            <table>
                                <tr>
                                    <th>Song</th>
                                    <th>Length</th>
                                </tr>
                                <tr id="itemPlaceholder" runat="server"></tr>
                            </table>
                        </LayoutTemplate>
                        <ItemTemplate><%--First Detail Line - Use the Item Template--%>
                            <tr>
                                <td>
                                    <asp:Label ID="lblSong" runat="server" Text="<%# Item.song %>" Width="640px"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblLength" runat="server" Text="<%# Item.length %>"></asp:Label>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <AlternatingItemTemplate><%--Second Detail Line - Use the Alternating Item Template--%>
                            <tr style="background-color:lightgrey">
                                <td>
                                    <asp:Label ID="lblSong2" runat="server" Text="<%# Item.song %>" Width="640px"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblLength2" runat="server" Text="<%# Item.length %>"></asp:Label>
                                </td>
                            </tr>
                        </AlternatingItemTemplate>
                        <EmptyDataTemplate>
                            No data available at this time.
                        </EmptyDataTemplate>
                    </asp:ListView>
                     
                   <%--GridView - Edit Columns can set up the Grid View through a Wizard--%>
                   <%-- <asp:GridView ID="gvTrackList" runat="server" DataSource="<%# Item.songs %>" ItemType="Chinook.Data.POCOs.TrackPOCO" GridLines="None" AutoGenerateColumns="False">
                        <Columns>
                            <asp:TemplateField HeaderText="Song">
                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                <ItemTemplate>
                                    <asp:Label ID="lblSong" runat="server" Text="<%# Item.song %>" Width="600px"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Length">
                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <ItemTemplate>
                                    <asp:Label ID="lblLength" runat="server" Text="<%# Item.length %>"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>                           
                        </Columns>
                        <EmptyDataTemplate>
                            No data available at this time.
                        </EmptyDataTemplate>
                    </asp:GridView>--%>

                   <%--Nested Repeater--%>
                   <%-- <asp:Repeater ID="rptTrackList" runat="server" DataSource="<%# Item.songs %>" ItemType="Chinook.Data.POCOs.TrackPOCO">
                        
                        <HeaderTemplate>
                            <table>
                                <tr>
                                    <th>Song</th>
                                    <th>Length</th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td style="width:600px"><%# Item.song %></td>
                                <td><%# Item.length %></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>--%>
                </ItemTemplate>
                <SeparatorTemplate>
                    <hr style="height:3px;border:none;color:#000;background-color:#000;" />
                </SeparatorTemplate>
            </asp:Repeater>
        </ItemTemplate>
    </asp:Repeater>
    <asp:ObjectDataSource ID="odsGenreAlbumTrackList" runat="server" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="Genre_GenreAlbumTracks" TypeName="ChinookSystem.BLL.GenreController">

    </asp:ObjectDataSource>
</asp:Content>

