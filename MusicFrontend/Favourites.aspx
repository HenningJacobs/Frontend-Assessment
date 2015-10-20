<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Favourites.aspx.cs" Inherits="myMusic.Favourites" %>

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
        <table><tr style="vertical-align: top">
        <td>
            <div class="panel panel-default">
                <div class="panel-heading">Favourite artists</div>
    <div id="FavArtist" class="panel-body" style="min-width: 350px;"></div></div>
            </td>
        <td>
            <div class="panel panel-default">
                 <div class="panel-heading">Favourite Releases</div>
      <div id="Releases" class="panel-body" style="min-width: 550px;"></div>
                </div>
        </td>
        </tr></table>


    <script type="text/javascript">

        //On page load
        window.onload = function () {
            DisplayData();
        };

        function DisplayData() {
            //Clear divs
            document.getElementById('FavArtist').innerHTML = "";
            document.getElementById('Releases').innerHTML = "";

            var arr = new Array();

            var temp = getCookie();
            if (temp != null) {
                //concat new and old cookie data
                for (var i = 0; i < temp.length; i++) {
                    //Add artists if not added
                    var addArtist = true;
                    for (var k = 0; k < arr.length; k++) {
                        if (arr[k] == temp[i].artistID)
                            addArtist = false;
                    }
                    if (addArtist == true) {
                        AddDivArtists(temp[i].artistID, encodeURIComponent(temp[i].artist));
                        arr.push(temp[i].artistID);
                    }

                    //Add Releases
                    AddDivReleases(temp[i].releaseID, encodeURIComponent(temp[i].date), encodeURIComponent(temp[i].title), encodeURIComponent(temp[i].label), encodeURIComponent(temp[i].tracks));
                }
            }
        }

        function DeleteArtist(artistID) {
            var arr = new Array();
            var obj = new Object();

            //Get old data
            var temp = getCookie();
            if (temp != null) {
                //concat new and old cookie data
                for (var i = 0; i < temp.length; i++) {
                    if (temp[i].artistID != artistID) {
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
            }

            //Create Json
            var objWarp = new Object();
            objWarp.favourites = arr;
            var val = JSON.stringify(objWarp);

            //create cookie
            document.cookie = "favourites=" + val; var objWarp = new Object();

            //Display
            DisplayData();
        }

        function DeleteRelease(releaseID) {
            var arr = new Array();
            var obj = new Object();

            //Get old data
            var temp = getCookie();
            if (temp != null) {
                //concat new and old cookie data
                for (var i = 0; i < temp.length; i++) {
                    if (temp[i].releaseID != releaseID) {
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
            }

            //Create Json
            var objWarp = new Object();
            objWarp.favourites = arr;
            var val = JSON.stringify(objWarp);

            //create cookie
            document.cookie = "favourites=" + val; var objWarp = new Object();

            //Display
            DisplayData();
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

        function AddDivArtists(id, artistname) {
            document.getElementById('FavArtist').innerHTML += decodeURIComponent(artistname);
            document.getElementById('FavArtist').innerHTML += "<a class=\"pull-right\"; style=\"cursor: pointer\"; onclick=DeleteArtist('" + id + "')>" +
                "<img src=\"http://pngimg.com/upload/star_PNG1595.png\" alt =\"favourite\" style=\"max-height:12px\"></a><br /> ";
        }

        function AddDivReleases(id, date, title, label, tracks) {
            document.getElementById('Releases').innerHTML += decodeURIComponent(date) + " - " + decodeURIComponent(title) + " - " + decodeURIComponent(label) + " - " + decodeURIComponent(tracks);
            document.getElementById('Releases').innerHTML += "<a class=\"pull-right\"; style=\"cursor: pointer\"; onclick=DeleteRelease('" + id + "')>" +
                "<img src=\"http://pngimg.com/upload/star_PNG1595.png\" alt =\"favourite\" style=\"max-height:12px\"></a><br /> ";
        }

        </script>
</asp:Content>
