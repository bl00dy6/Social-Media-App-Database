using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1.SqlConnect.Tabele
{
    [Table("posts", Schema = "post")]
    public class posts
    {
        [Key]
        public int post_id { get; set; }
        public int user_id { get; set; }
        public int? shared_post_id { get; set; }
        public string title { get; set; }
        public string? description { get; set; }
        public DateTime post_added { get; set; }
        
    }
}
