using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1.SqlConnect.Tabele
{
    [Table("info", Schema = "user")]
    public class info
    {
        [Key]
        public int user_id { get; set; }
        public string first_name { get; set; }
        public string middle_name { get; set; }
        public string last_name { get; set; }
        public string public_email { get; set; }
        public string phone { get; set; }
        public string address { get; set; }
        public string city { get; set; }
        public string state { get; set; }
        public string hometown { get; set; }
        public char gender { get; set; }
        public DateTime birth_date { get; set; }
        public string website { get; set; }
        public string religion { get; set; }
        public string intro { get; set; }
     
    }
}
