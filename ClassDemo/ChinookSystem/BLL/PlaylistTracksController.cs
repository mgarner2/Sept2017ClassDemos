using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additional Namespaces
using Chinook.Data.Entities;
using Chinook.Data.DTOs;
using Chinook.Data.POCOs;
using ChinookSystem.DAL;
using System.ComponentModel;
#endregion

namespace ChinookSystem.BLL
{
    public class PlaylistTracksController
    {
        public List<UserPlaylistTrack> List_TracksForPlaylist(
            string playlistname, string username)
        {
            using (var context = new ChinookContext())
            {

                //What would happen if there is no match for the incoming parameter values?
                //We need to ensure that the results have a valid value
                //This value will be the result of a query: either a null(not found_) or an IEnumerable<T> collection

                //to achieve a valid value encapsulate the query in a .FirstOrDefault()
                var results = (from x in context.Playlists
                               where x.UserName.Equals(username)
                                && x.Name.Equals(playlistname)
                               select x).FirstOrDefault();
                if (results == null)
                {
                    return null;
                }
                else
                {
                    //Now get the tracks
                    var theTracks = from x in context.PlaylistTracks
                                    where x.PlaylistId.Equals(results.PlaylistId)
                                    orderby x.TrackNumber
                                    select new UserPlaylistTrack
                                    {
                                        TrackID = x.TrackId,
                                        TrackNumber = x.TrackNumber,
                                        TrackName = x.Track.Name,
                                        Milliseconds = x.Track.Milliseconds,
                                        UnitPrice = x.Track.UnitPrice
                                    };
                    return theTracks.ToList();
                }

            }

        }//eom
        public List<UserPlaylistTrack> Add_TrackToPlaylist(string playlistname, string username, int trackid)
        {
            //code to go here
            using (var context = new ChinookContext())
            {
                //Part One:

                var exists = (from x in context.Playlists
                              where x.UserName.Equals(username)
                               && x.Name.Equals(playlistname)
                              select x).FirstOrDefault();
                //initialize the tracknumber
                int tracknumber = 0;
                //I Will need to create an instance of PlaylistTrack
                PlaylistTrack newTrack = null;
                //Determine if a playlist "parent" instance needs to be created
                if (exists == null)
                {
                    //This is a new playlist
                    //Create an instance of a playlist to add to a Playlist Table
                    exists = new Playlist();
                    exists.Name = playlistname;
                    exists.UserName = username;
                    exists = context.Playlists.Add(exists);
                    //At this time there is NO physical pkey
                    //The pseudokey is handled by the HashSet
                    tracknumber = 1;
                }
                else
                {
                    //Playlist exists
                    //Need to generate the next tracknumber
                    tracknumber = exists.PlaylistTracks.Count() + 1;

                    //validation: in our example, a track can only exist once on a playlist
                    newTrack = exists.PlaylistTracks.SingleOrDefault(x => x.TrackId == trackid);
                    if (newTrack != null)
                    {
                        throw new Exception("Playlist already has requested track");
                    }
                }

                //Part Two: Add the PlaylistTrack instance
                //using navigation to .Add the newTrack to PlaylistTrack
                newTrack = new PlaylistTrack();
                newTrack.TrackId = trackid;
                newTrack.TrackNumber = tracknumber;

                //NOTE: The pkey for PlaylistID may not yet exist
                //Using navigation, one can let HashSet handle the PlaylistID pkey value
                exists.PlaylistTracks.Add(newTrack);

                //Physically add all data to the database (COMMIT)
                context.SaveChanges();
                return List_TracksForPlaylist(playlistname, username);
            }
        }//eom
        public void MoveTrack(string username, string playlistname, int trackid, int tracknumber, string direction)
        {
            using (var context = new ChinookContext())
            {
                //code to go here
                var exists = (from x in context.Playlists
                              where x.UserName.Equals(username)
                               && x.Name.Equals(playlistname)
                              select x).FirstOrDefault();
                if (exists == null)
                {
                    throw new Exception("Playlist does not exist.");
                }
                else
                {
                    PlaylistTrack moveTrack = (from x in exists.PlaylistTracks where x.TrackId == trackid select x).FirstOrDefault();
                    if (moveTrack == null)
                    {
                        throw new Exception("Track does not exist on playlist.");
                    }
                    else
                    {
                        PlaylistTrack otherTrack = null;
                        if (direction.Equals("up"))
                        {
                            if (moveTrack.TrackNumber == 1)
                            {
                                throw new Exception("Track already at the top of the list.");
                            }
                            else
                            {
                                otherTrack = (from x in exists.PlaylistTracks
                                              where x.TrackNumber == moveTrack.TrackNumber - 1
                                              select x).FirstOrDefault();
                                if (otherTrack == null)
                                {
                                    throw new Exception("Other track is missing");
                                }
                                else
                                {
                                    moveTrack.TrackNumber -= 1;
                                    otherTrack.TrackNumber += 1;
                                }
                            }
                        }
                        else
                        {
                            //down
                            if (moveTrack.TrackNumber == exists.PlaylistTracks.Count)
                            {
                                throw new Exception("Track already at the bottom of the list.");
                            }
                            else
                            {
                                otherTrack = (from x in exists.PlaylistTracks
                                              where x.TrackNumber == moveTrack.TrackNumber + 1
                                              select x).FirstOrDefault();
                                if (otherTrack == null)
                                {
                                    throw new Exception("Other track is missing");
                                }
                                else
                                {
                                    moveTrack.TrackNumber += 1;
                                    otherTrack.TrackNumber -= 1;
                                }
                            }
                        }//eof up/down
                         //staging
                        context.Entry(moveTrack).Property(y => y.TrackNumber).IsModified = true;
                        context.Entry(otherTrack).Property(y => y.TrackNumber).IsModified = true;
                        context.SaveChanges();
                    }

                }
            }//eom
        }


        public void DeleteTracks(string username, string playlistname, List<int> trackstodelete)
        {
           
           
        }//eom
    }
}
