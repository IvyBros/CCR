<%@ Page MasterPageFile="~/Admin/Admin.Master" Language="C#" AutoEventWireup="true" CodeBehind="CropProfilePic.aspx.cs" Inherits="CutterCreekRanch.Admin.CropProfilePic" %>
<asp:Content ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="/css/jquery.Jcrop.min.css" type="text/css" />
    <style>

        .jcrop-holder #preview-pane {
          display: block;
          position: absolute;
          z-index: 2000;
          top: 10px;
          right: -280px;
          padding: 6px;
          border: 1px rgba(0,0,0,.4) solid;
          background-color: white;
          border-radius: 6px;
          box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2);
        }

        /* The Javascript code will set the aspect ratio of the crop
           area based on the size of the thumbnail preview,
           specified here */
        #preview-pane .preview-container {
          width: 250px;
          height: 250px;
          overflow: hidden;
        }
        .crop-btn{
            margin:20px;
            padding:5px;
        }
    </style>
</asp:Content>
<asp:Content ContentPlaceHolderID="main" runat="server">
    
    <form runat="server" id="form1">
    <h1><a href="/Admin/ManageDogs.aspx">Manage Dogs</a> | <a href="/Admin/ManagePhotos.aspx">Manage Photos</a> | <a href="/Admin/ManagePeople.aspx">Manage People</a></h1>
    <div>
        <asp:Panel ID="pnlCrop" runat="server"> 
            <h2>Choose Crop Region</h2>
            <hr />
            <h3>Source Image</h3>
            <asp:Image ID="target" runat="server"  ClientIDMode="Static" /> 
            <asp:HiddenField ID="X" runat="server" ClientIDMode="Static" /> 
            <asp:HiddenField ID="Y" runat="server" ClientIDMode="Static" /> 
            <asp:HiddenField ID="W" runat="server" ClientIDMode="Static" /> 
            <asp:HiddenField ID="H" runat="server" ClientIDMode="Static" /> 
            <asp:Button ID="btnCrop" runat="server" Text="Crop" OnClick="btnCrop_Click" CssClass="crop-btn" />
            <div id="preview-pane">                
                <div class="preview-container">
                    <asp:Image runat="server" CssClass="jcrop-preview" ID="preview" ClientIDMode="Static" />
                </div>
            </div>
            <p>
                Select the area you wish to crop by clicking and dragging on the source image.  A preview will be
                displayed in the preview pane.  When you're happy with your selection, click the "crop" button.
            </p>
        </asp:Panel>
        <asp:Panel ID="pnlCropped" runat="server" Visible="false">
            <asp:Image ID="imgCropped" runat="server" />
        </asp:Panel>
    </div>
    </form>
</asp:Content>
<asp:Content ContentPlaceHolderID="footer" runat="server">
    <script src="/js/jquery.Jcrop.min.js"></script>
    <script>
        jQuery(function ($) {
            // Create variables (in this scope) to hold the API and image size
            var jcrop_api,
                boundx,
                boundy,

                // Grab some information about the preview pane
                $preview = $('#preview-pane'),
                $pcnt = $('#preview-pane .preview-container'),
                $pimg = $('#preview-pane .preview-container img'),

                xsize = $pcnt.width(),
                ysize = $pcnt.height();

            //console.log('init', [xsize, ysize]);
            $('#target').Jcrop({
                onChange: updatePreview,
                onSelect: storeCoords,
                aspectRatio: xsize / ysize
            }, function () {
                // Use the API to get the real image size
                var bounds = this.getBounds();
                boundx = bounds[0];
                boundy = bounds[1];
                // Store the API in the jcrop_api variable
                jcrop_api = this;

                // Move the preview into the jcrop container for css positioning
                $preview.appendTo(jcrop_api.ui.holder);
            });

            function updatePreview(c) {
                if (parseInt(c.w) > 0) {
                    var rx = xsize / c.w;
                    var ry = ysize / c.h;

                    $pimg.css({
                        width: Math.round(rx * boundx) + 'px',
                        height: Math.round(ry * boundy) + 'px',
                        marginLeft: '-' + Math.round(rx * c.x) + 'px',
                        marginTop: '-' + Math.round(ry * c.y) + 'px'
                    });
                }
            };

        });
        function storeCoords(c) {
            $('#X').val(c.x);
            $('#Y').val(c.y);
            $('#W').val(c.w);
            $('#H').val(c.h);
        };
    </script>
</asp:Content>