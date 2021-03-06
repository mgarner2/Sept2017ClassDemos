﻿using System;
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
    [DataObject] //Annonate your class
    public class ArtistController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)] //Annotate your method
        public List<Artist> Artists_List()
        {
            using (var context = new ChinookContext())
            {
                return context.Artists.ToList();
            }
        }
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<SelectionList> List_ArtistNames()
        {
            using (var context = new ChinookContext())
            {
                var results = from x in context.Artists
                              orderby x.Name
                              select new SelectionList
                              {
                                  IDValueField = x.ArtistId,
                                  DisplayText = x.Name
                              };
                return results.ToList();
            }
        }
    }
}
