using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additional Namepspaces
using Chinook.Data.Entities;
using ChinookSystem.DAL;
using System.ComponentModel; //Expose Methods for ODS Wizard
#endregion

namespace ChinookSystem.BLL
{
    [DataObject] //Annonate your class
    public class ArtistController
    {
        [DataObjectMethod(DataObjectMethodType.Select,false)] //Annotate your method
        public List<Artist> Artists_List()
        {
            using (var context = new ChinookContext())
            {
                return context.Artists.ToList();
            }
        }
    }
}
