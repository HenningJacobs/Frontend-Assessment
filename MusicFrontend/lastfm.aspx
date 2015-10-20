<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="lastfm.aspx.cs" Inherits="myMusic.lastfm" %>

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
    <h3>for Las.fm only key was suplied withoud secret.</h3>

    <input name="txbArtistName" class="form-control" type ="text"/>
    <input name="btnArtistSearch" id="btnArtistSearch" class="btn btn-default" type ="button" value="Search" />

    <div class="panel panel-primary">
  <div class="panel-heading">
    <h2 class="panel-title">Search Results</h2>
  </div>
  <div class="panel-body">
    Panel content
  </div>
        </div>


  
    <script type="text/javascript">


</script>


    <div id="txt">
</div>
<!-- SCRIPT FOR GETTING IMAGES FROM FLICKER.COM USING JSONP -->

  
</asp:Content>
