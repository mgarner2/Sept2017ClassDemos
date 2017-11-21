using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

#region Additional Namespaces
using ChinookSystem.BLL;
using Chinook.Data.POCOs;

#endregion
public partial class SamplePages_ManagePlaylist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Request.IsAuthenticated)
        {
            Response.Redirect("~/Account/Login.aspx");
        }
        else
        {
            TracksSelectionList.DataSource = null;
        }
    }

    protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
    {
        MessageUserControl.HandleDataBoundException(e);
    }

    protected void Page_PreRenderComplete(object sender, EventArgs e)
    {
        //PreRenderComplete occurs just after databinding page events
        //load a pointer to point to your DataPager control
        DataPager thePager = TracksSelectionList.FindControl("DataPager1") as DataPager;
        if (thePager !=null)
        {
            //this code will check the StartRowIndex to see if it is greater that the
            //total count of the collection
            if (thePager.StartRowIndex > thePager.TotalRowCount)
            {
                thePager.SetPageProperties(0, thePager.MaximumRows, true);
            }
        }
    }

    protected void ArtistFetch_Click(object sender, EventArgs e)
    {
        //code to go here
        TracksBy.Text = "Artist";
        SearchArgID.Text = ArtistDDL.SelectedValue;
        //Refresh the track list display
        TracksSelectionList.DataBind();
    }

    protected void MediaTypeFetch_Click(object sender, EventArgs e)
    {
        //code to go here
        TracksBy.Text = "MediaType";
        SearchArgID.Text = MediaTypeDDL.SelectedValue;
        TracksSelectionList.DataBind();
    }

    protected void GenreFetch_Click(object sender, EventArgs e)
    {
        //code to go here
        TracksBy.Text = "Genre";
        SearchArgID.Text = GenreDDL.SelectedValue;
        TracksSelectionList.DataBind();
    }

    protected void AlbumFetch_Click(object sender, EventArgs e)
    {
        //code to go here
        TracksBy.Text = "Album";
        SearchArgID.Text = AlbumDDL.SelectedValue;
        TracksSelectionList.DataBind();
    }

    protected void PlayListFetch_Click(object sender, EventArgs e)
    {
        //code to go here
        //standard query lookup
        if (string.IsNullOrEmpty(PlaylistName.Text))
        {
            //display a message to the user via the user control we created: MessageUserControl
            MessageUserControl.ShowInfo("Warning", "Please enter a playlist name.");
        }
        else
        {
            //Obtain the username from the security Identity class
            string username = User.Identity.Name;

            //The MessageUserControl has the try/catch logic embedded in it - you don't need to code your own
            MessageUserControl.TryRun(() =>
            {
                //code to be run under the "watchful eyes" of the user control
                //this is the try(yourcode) of the try/catch
                PlaylistTracksController sysmgr = new PlaylistTracksController();
                List<UserPlaylistTrack> info = sysmgr.List_TracksForPlaylist(PlaylistName.Text, username);
                PlayList.DataSource = info;
                PlayList.DataBind();
            },"","Current Playlist:");
        }
    }

    protected void TracksSelectionList_ItemCommand(object sender, 
        ListViewCommandEventArgs e)
    {
        //code to go here
        if (string.IsNullOrEmpty(PlaylistName.Text))
        {
            //display a message to the user via the user control we created: MessageUserControl
            MessageUserControl.ShowInfo("Warning", "Please enter a playlist name.");
        }
        else
        {
            string username = User.Identity.Name;
            //Where does TrackId come from?
            //ListViewCommandEventArgs e contains the parameter values for this event - which includes CommandArgument
            //CommandArgument is an object
            //int trackID = (int)e.CommandArgument;
            int trackid = int.Parse(e.CommandArgument.ToString());

            //Send your collection of parameter values to the BLL for processing
            MessageUserControl.TryRun(() =>
            {
                //the process
                PlaylistTracksController sysmgr = new PlaylistTracksController();
                List<UserPlaylistTrack> refreshResults = sysmgr.Add_TrackToPlaylist(PlaylistName.Text, username, trackid);
                PlayList.DataSource = refreshResults;
                PlayList.DataBind();

            },"Success","Your track has been added to your playlist.");
        }
    }

    protected void MoveUp_Click(object sender, EventArgs e)
    {
        //code to go here
        if (PlayList.Rows.Count == 0)
        {
            MessageUserControl.ShowInfo("Warning", "No playlist tracks received.");
        }
        else
        {
            if(string.IsNullOrEmpty(PlaylistName.Text))
            {
                MessageUserControl.ShowInfo("Warning", "No playlist name has been retrieved.");
            }
            else
            {
                //check only one row has been selected
                int trackid = 0;
                int tracknumber = 0;
                int rowsSelected = 0;
                CheckBox playlistselection = null;
                //traverse through the gridview looking for a checked box in each row
                for (int i = 0; i <PlayList.Rows.Count; i++)
                {
                    //PlaylistSelection will point to the current Checkbox of the current gridview row being eamined
                    playlistselection = PlayList.Rows[i].FindControl("Selected") as CheckBox;
                    if (playlistselection.Checked)
                    {
                        trackid = int.Parse((PlayList.Rows[i].FindControl("TrackId") as Label).Text);
                        tracknumber = int.Parse((PlayList.Rows[i].FindControl("TrackNumber") as Label).Text);
                        rowsSelected++;
                        
                        
                    }
                }//eo for
                //Check many tracks were selected
                if (rowsSelected != 1)
                {
                    MessageUserControl.ShowInfo("Warning", "Can only move one track at a time");
                }
                else
                {
                    //Check position of the track
                    if (tracknumber == 1)
                    {
                        MessageUserControl.ShowInfo("Information", "Track is already at the top of the list");
                    }
                    else
                    {
                        MoveTrack(trackid, tracknumber, "up");
                    }

                }

            }

        }
    }

    protected void MoveDown_Click(object sender, EventArgs e)
    {
        //code to go here
         if (PlayList.Rows.Count == 0)
        {
            MessageUserControl.ShowInfo("Warning", "No playlist tracks received.");
        }
        else
        {
            if(string.IsNullOrEmpty(PlaylistName.Text))
            {
                MessageUserControl.ShowInfo("Warning", "No playlist name has been retrieved.");
            }
            else
            {
                //check only one row has been selected
                int trackid = 0;
                int tracknumber = 0;
                int rowsSelected = 0;
                CheckBox playlistselection = null;
                //traverse through the gridview looking for a checked box in each row
                for (int i = 0; i <PlayList.Rows.Count; i++)
                {
                    //PlaylistSelection will point to the current Checkbox of the current gridview row being eamined
                    playlistselection = PlayList.Rows[i].FindControl("Selected") as CheckBox;
                    if (playlistselection.Checked)
                    {
                        trackid = int.Parse((PlayList.Rows[i].FindControl("TrackId") as Label).Text);
                        tracknumber = int.Parse((PlayList.Rows[i].FindControl("TrackNumber") as Label).Text);
                        rowsSelected++;
                        
                        
                    }
                }//eo for
                //Check many tracks were selected
                if (rowsSelected != 1)
                {
                    MessageUserControl.ShowInfo("Warning", "Can only move one track at a time");
                }
                else
                {
                    //Check position of the track
                    if (tracknumber == PlayList.Rows.Count)
                    {
                        MessageUserControl.ShowInfo("Information", "Track is already at the bottom of the list");
                    }
                    else
                    {
                        MoveTrack(trackid, tracknumber, "down");
                    }

                }

            }

        }
    }
    protected void MoveTrack(int trackid, int tracknumber, string direction)
    {
        //code to go here
        //wrap up your work under MessageUserControl
        MessageUserControl.TryRun(() =>
        {
            //TryRun(() => {} ); -- Constructing a process

            //Call the appropriate BLL method (Update)
            PlaylistTracksController sysmgr = new PlaylistTracksController();
            sysmgr.MoveTrack(User.Identity.Name, PlaylistName.Text, trackid, tracknumber, direction);

            //Refresh the display
            List<UserPlaylistTrack> results = sysmgr.List_TracksForPlaylist(PlaylistName.Text, User.Identity.Name);
            PlayList.DataSource = results;
            PlayList.DataBind(); 
        }, "Success","Track has been moved.");




    }
    protected void DeleteTrack_Click(object sender, EventArgs e)
    {
        //code to go here
    }
}
