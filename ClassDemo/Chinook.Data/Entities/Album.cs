using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;


namespace Chinook.Data.Entities
{
    [Table("Albums")]
    public class Album
    {
        [Key]
        public int AlbumId { get; set; }

        [Required(ErrorMessage ="Title is a required field.")]
        [StringLength(160,ErrorMessage ="Title is limited to 160 characters.")]
        public string Title { get; set; }

        public int ArtistId { get; set; }

        public int ReleaseYear { get; set; }

        [StringLength(50,ErrorMessage ="Release Label is limited to 50 characters.")]
        public string ReleaseLabel { get; set; }

        //Navigation properties
        //Album (Child) to Artist (Parent) - Singular Relationship
        public virtual Artist Artist { get; set; }
        public virtual ICollection<Track> Tracks { get; set; }
        //CRUD -- These are not attributes! Configuring the ListView automatically will include these navigational properties.
        //Could use "not mapped properties" before you begin so they aren't picked up by the ListView configurator.
    }
}
