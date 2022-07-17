using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1.SqlConnect.Tabele
{
    [Table("comments", Schema = "post")]
    public class comments
    {
        [Key]
        public int comment_id { get; set; } 
        public int post_id { get; set; }
        public int user_id { get; set; }
        public int? reply_to_comment_id { get; set; }
        public string comment { get; set; }
        public DateTime? comment_added { get; set; }
    }
}
