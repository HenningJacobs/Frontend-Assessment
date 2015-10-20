<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MusicFrontend._Default" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <section class="featured">
        <div class="content-wrapper">
          <a href="lastfm.aspx" class="btn btn-default">last.fm</a> | 
          <a href="musicbrainz.aspx" class="btn btn-default">muxicbrainz</a> |
          <a href="favourites.aspx" class="btn btn-default">favourites</a>
          
        </div>
    </section>
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h3>&nbsp;</h3>
     
</asp:Content>