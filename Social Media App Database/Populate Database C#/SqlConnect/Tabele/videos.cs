using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1.SqlConnect.Tabele
{
    [Table("videos", Schema = "post")]
    public class videos
    {
        
        public int post_id { get; set; }
        public string video_url { get; set; }
    }
}
