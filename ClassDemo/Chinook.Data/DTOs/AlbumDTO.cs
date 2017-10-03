using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additional Namespaces 

using Chinook.Data.POCOs;

#endregion 
namespace Chinook.Data.DTOs
{
    public class AlbumDTO
    {
        public string title { get; set; }
        public int year { get; set; }
        public int tracks { get; set; }
        public IEnumerable<TrackPOCO> songs { get; set; }
    }
}
