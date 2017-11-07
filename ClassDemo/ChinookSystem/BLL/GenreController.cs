using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additional Namepspaces
using Chinook.Data.Entities;
using ChinookSystem.DAL;
using System.ComponentModel; //Expose Methods for ODS Wizard
using Chinook.Data.POCOs;
using Chinook.Data.DTOs;
#endregion

namespace ChinookSystem.BLL
{
    [DataObject]
    public class GenreController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<GenreDTO> Genre_GenreAlbumTracks()
        {
            using (var context = new ChinookContext())
            {
                var results = from x in context.Genres
                              select new GenreDTO
                              {
                                  genre = x.Name,
                                  albums = from y in x.Tracks
                                           group y by y.Album into grp
                                           select new AlbumDTO
                                           {
                                               title = grp.Key.Title,
                                               year = grp.Key.ReleaseYear,
                                               tracks = grp.Count(),
                                               songs = from z in grp
                                                       select new TrackPOCO
                                                       {
                                                           song = z.Name,
                                                           milliseconds = z.Milliseconds
                                                       }
                                           }
                              };
                return results.ToList();
            }
        }
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<SelectionList> List_GenreNames()
        {
            using (var context = new ChinookContext())
            {
                var results = from x in context.Genres
                              orderby x.Name
                              select new SelectionList
                              {
                                  IDValueField = x.GenreId,
                                  DisplayText = x.Name
                              };
                return results.ToList();
            }
        }
    }

}
