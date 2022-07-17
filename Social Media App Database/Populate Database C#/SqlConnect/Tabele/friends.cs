using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1.SqlConnect.Tabele
{
    [Table("friends", Schema = "social")]
    public class friends
    {
        public int user_id { get; set; }
        public int friend_id { get; set; }
        public int status_id { get; set; }
        public DateTime friend_date { get; set; }
        
    }
}
