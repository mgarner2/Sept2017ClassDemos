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
#endregion

namespace ChinookSystem.BLL
{
    [DataObject]//Annonate Class
    public class AlbumController
    {
        [DataObjectMethod(DataObjectMethodType.Select,false)] //Annotate Method
        public List<ArtistAlbumByReleaseYear> Albums_ListforArtist(int artistId)
        {
            using (var context = new ChinookContext())
            {
                var results = from x in context.Albums //Ensure context.Entity is used because we are going through Context before we go to Database
                              where x.ArtistId.Equals(artistId)//Verify Parameter Names
                              select new ArtistAlbumByReleaseYear //Verify POCO / DTO Class
                              {
                                  Title = x.Title,
                                  Released = x.ReleaseYear
                              };
                return results.ToList(); //Test results.Dump(); in LinqPad
            }
        }
    }
}
