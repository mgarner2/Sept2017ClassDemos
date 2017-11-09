﻿using System;
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
    [DataObject]
    public class TrackController
    {
        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public List<TrackList> List_TracksForPlaylistSelection(string tracksby, int argid)
        {
            using (var context = new ChinookContext())
            {
                IEnumerable<TrackList> results = null;

               //code to go here
               //Determine which lookup needs to be done : tracksby
               switch (tracksby)
                {
                    case "Artist":
                        {
                            results = from x in context.Tracks
                                      orderby x.Name
                                      where x.Album.ArtistId == argid
                                      select new TrackList
                                      {
                                          TrackID = x.TrackId,
                                          Name = x.Name,
                                          Title = x.Album.Title,
                                          MediaName = x.MediaType.Name,
                                          GenreName = x.Genre.Name,
                                          Composer = x.Composer,
                                          Milliseconds = x.Milliseconds,
                                          Bytes = x.Bytes,
                                          UnitPrice = x.UnitPrice 
                                      };
                            break;
                        }
                    case "MediaType":
                        {
                            results = from x in context.Tracks
                                      orderby x.Name
                                      where x.MediaType.MediaTypeId  == argid
                                      select new TrackList
                                      {
                                          TrackID = x.TrackId,
                                          Name = x.Name,
                                          Title = x.Album.Title,
                                          MediaName = x.MediaType.Name,
                                          GenreName = x.Genre.Name,
                                          Composer = x.Composer,
                                          Milliseconds = x.Milliseconds,
                                          Bytes = x.Bytes,
                                          UnitPrice = x.UnitPrice
                                      };
                            break;
                        }
                    case "Genre":
                        {
                            results = from x in context.Tracks
                                      orderby x.Name
                                      where x.Genre.GenreId == argid
                                      select new TrackList
                                      {
                                          TrackID = x.TrackId,
                                          Name = x.Name,
                                          Title = x.Album.Title,
                                          MediaName = x.MediaType.Name,
                                          GenreName = x.Genre.Name,
                                          Composer = x.Composer,
                                          Milliseconds = x.Milliseconds,
                                          Bytes = x.Bytes,
                                          UnitPrice = x.UnitPrice
                                      };
                            break;
                        }
                    case "Album":
                        {
                            results = from x in context.Tracks
                                      orderby x.Name
                                      where x.Album.AlbumId == argid
                                      select new TrackList
                                      {
                                          TrackID = x.TrackId,
                                          Name = x.Name,
                                          Title = x.Album.Title,
                                          MediaName = x.MediaType.Name,
                                          GenreName = x.Genre.Name,
                                          Composer = x.Composer,
                                          Milliseconds = x.Milliseconds,
                                          Bytes = x.Bytes,
                                          UnitPrice = x.UnitPrice
                                      };
                            break;
                        }
                    default:
                        {
                            break;
                        }
                }
                //Using an inline if
                //results = from x in context.Tracks
                //          orderby x.Name
                //          where tracksby.Equals("Artist") ? x.Album.ArtistId == argid :
                //          tracksby.Equals("MediaType") ? x.MediaTypeId == argid :
                //          tracksby.Equals("Genre") ? x.GenreId == argid :
                //          x.AlbumId == argid
                //          select new TrackList
                //          {
                //              TrackID = x.TrackId,
                //              Name = x.Name,
                //              Title = x.Album.Title,
                //              MediaName = x.MediaType.Name,
                //              GenreName = x.Genre.Name,
                //              Composer = x.Composer,
                //              Milliseconds = x.Milliseconds,
                //              Bytes = x.Bytes,
                //              UnitPrice = x.UnitPrice
                //          };
                return results.ToList();//You can also use List<T>, and you can just return results;
            }
        }//eom

       
    }//eoc
}
