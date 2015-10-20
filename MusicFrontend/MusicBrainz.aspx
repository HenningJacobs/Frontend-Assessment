<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="MusicBrainz.aspx.cs" Inherits="myMusic.MusicBrainz" %>

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
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <h3>Search for artist:</h3>
     <input id="txbArtistName" name="txbArtistName" class="form-control" type ="text"/>
    <input name="btnArtistSearch" id="btnArtistSearch" class="btn btn-default" type ="button" value="Search" />
    
    <table><tr style="vertical-align: top">
        <td>
            <div class="panel panel-default">
                <div class="panel-heading">Search results</div>
    <div id="SearchResults" class="panel-body" style="min-width: 350px;"></div></div>
            </td>
        <td>
            <div class="panel panel-default">
                 <div class="panel-heading">Short list</div>
                          <div id="Albums" class="panel-body" style="min-width: 550px;"></div>
                </div>
        </td>
        </tr></table>
       <script type="text/javascript">
           ///start search
           $("#btnArtistSearch").click(function () {
               //Clear divs
               document.getElementById('SearchResults').innerHTML = "";
               document.getElementById('Albums').innerHTML = "";
               //Get string value
               var query = document.getElementById('txbArtistName').value;
               //Get music brains data
               $.getJSON("http://musicbrainz.org/ws/2/artist/?query=artist:" + query + "&fmt=json",
               {
                   format: "json"
               },

               //Loop through data and add to Div search results
               function (data) {
                   $.each(data.artists, function (i, item) {
                       AddDivSearchResults(item.id, item.name);
                   });
               });
           });

           function AddDivSearchResults(id, artistname) {
               document.getElementById('SearchResults').innerHTML += artistname;
               document.getElementById('SearchResults').innerHTML += "<a class=\"pull-right\"; style=\"cursor: pointer\"; onclick=DisplayAlbumResults('" + encodeURIComponent(id) + "')>add to short list</a><br />";
           }
          
           function DisplayAlbumResults(id) {
               //Clear div
               document.getElementById('Albums').innerHTML = "";
               //Get artists from Music Brains
               $.getJSON("http://musicbrainz.org/ws/2/artist/" + decodeURIComponent(id) + "?inc=releases&fmt=json",
            {
                format: "json"
            },
            function (data) {
                var artistname = decodeURIComponent(data.name);
                
                $.each(data.releases, function (i, item) {
                    //Get Albums from music brains
                    $.getJSON("http://musicbrainz.org/ws/2/release/" + item.id + "?inc=labels+recordings&fmt=json",
                      {
                          format: "json"
                      },
                      function (data) {
                          var labelname = "";
                          $.each(data["label-info"], function (j, x) {
                              labelname = x.label.name;
                          });
                          var trackcount = data["media"][0]["track-count"];

                          //Add Albums
                          document.getElementById('Albums').innerHTML += item.date.substring(0, 4) + " - " + item.title.replace("'", "").replace("\"", "") + " - " + labelname + " - " + trackcount; + "<br />";
                          document.getElementById('Albums').innerHTML += "<a class=\"pull-right\"; style=\"cursor: pointer\"; onclick=AddCookieItem('" + encodeURIComponent(id) + "','" + encodeURIComponent(artistname) + "','" + encodeURIComponent(item.id) + "','" + item.date + "','" + encodeURIComponent(item.title.replace("'", "").replace("\"", "")) + "','" + encodeURIComponent(labelname) + "','" + trackcount + "')>" +
                              "<img src=\"http://images.clipartpanda.com/clipart-star-RTA9RqzTL.png\" alt =\"favourite\" style=\"max-height:12px\"></a> ";
                          document.getElementById('Albums').innerHTML += "<br />";
                      });
                });
            });
           }
    
           function AddCookieItem(artistID, artist, releaseID, date, title, label, tracks) {
               var arr = new Array();
               var obj = new Object();
               
               //Add cookie data
               obj.artistID = decodeURIComponent(artistID);
               obj.artist = decodeURIComponent(artist);
               obj.releaseID = decodeURIComponent(releaseID);
               obj.date = date;
               obj.title = decodeURIComponent(title);
               obj.label = decodeURIComponent(label);
               obj.tracks = tracks;

               arr.push(obj);

               //Get old data
               var temp = getCookie();
               if (temp != null) {
                   //concat new and old cookie data
                   for (var i = 0; i < temp.length; i++) {
                       var ob = new Object();
                       ob.artistID = temp[i].artistID;
                       ob.artist = temp[i].artist;
                       ob.releaseID = temp[i].releaseID;
                       ob.date = temp[i].date;
                       ob.title = temp[i].title;
                       ob.label = temp[i].label;
                       ob.tracks = temp[i].tracks;
                       arr.push(ob);
                   }
               }
               
               //Create Json
               var objWarp = new Object();
               objWarp.favourites = arr;
               var val = JSON.stringify(objWarp);
               
               //create cookie
               document.cookie = "favourites=" + val; var objWarp = new Object();
           }

           function getCookie() {
               var key, val, res;

               //Get all cookie
               var oldCookie = document.cookie.split(';');
               for (var i = 0; i < oldCookie.length; i++) {
                   key = oldCookie[i].substr(0, oldCookie[i].indexOf('='));
                   val = oldCookie[i].substr(oldCookie[i].indexOf("=") + 1);
                   key = key.replace(/^\s+|\s+$/g, "");
                   //find "favourites"
                   if (key == "favourites") {
                       res = val;
                   }
               }

               if (res == undefined) {
                   return null;
               } else {
                   res = JSON.parse(res);
                   return res.favourites;
               }
           }

           


        </script>
   
  
</asp:Content>
