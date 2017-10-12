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
        [DataObjectMethod(DataObjectMethodType.Select, false)] //Annotate Method
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
        //Add new method for album entity
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<Album> Albums_ListByReleaseYear(int minyear, int maxyear)
        {
            using (var context = new ChinookContext())
            {
                var results =
                from x in context.Albums
                where x.ReleaseYear >= minyear && x.ReleaseYear <= maxyear
                orderby x.ReleaseYear, x.Title
                select x;

                return results.ToList();
            }

        }
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<Album> Albums_ListByTitle(string title)
        {
            using (var context = new ChinookContext())
            {
                var results = from x in context.Albums
                              where x.Title.Contains(title)
                              orderby x.Title, x.ReleaseYear
                              select x;
                return results.ToList();
            }
        }//eom

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<Album> Albums_List()
        {
            using (var context = new ChinookContext())
            {
                return context.Albums.ToList();
            }

        }
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public Album Albums_Get(int albumid)
        {
            using (var context = new ChinookContext())
            {
                return context.Albums.Find(albumid);
            }

        }
        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public int Albums_Add(Album item) //What is being passed in is an instance of your entity
        {
            using (var context = new ChinookContext()) 
            {
                item = context.Albums.Add(item);//.Add just stages the record to be commited to SQL table
                context.SaveChanges();//.SaveChanges commits the request
                return item.AlbumId;
            }
        }
        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public int Albums_Update(Album item)
        {
            using (var context = new ChinookContext())
            {
                context.Entry(item).State = System.Data.Entity.EntityState.Modified;
                return context.SaveChanges();
            }
        }
        
        public int Albums_Delete(int albumid) //Don't need to pass in the entity - just the primary key
        {
            using (var context = new ChinookContext())
            {
                var existingItem = context.Albums.Find(albumid); //Lookup to get the full entity
                context.Albums.Remove(existingItem); //Remove the entity
                return context.SaveChanges(); //Commit the removal 
                //This is a full removal of the record
                //Alternatively, you may set a bool like Status to Deleted to indicate a record is deleted, rather than remove the item from the database

            }
        }
        [DataObjectMethod(DataObjectMethodType.Delete,false)]
        public int Albums_Delete(Album item)
        {
            return Albums_Delete(item.AlbumId);
        }
    }
}
