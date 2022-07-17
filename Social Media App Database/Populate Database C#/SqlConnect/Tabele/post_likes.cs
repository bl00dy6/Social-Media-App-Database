using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1.SqlConnect.Tabele
{
    [Table("likes", Schema = "post")]
    public class post_likes
    {
        public int post_id { get; set; }
        public int user_id { get; set; }
        public DateTime like_date { get; set; }

    }
}
