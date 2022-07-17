using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1.SqlConnect.Tabele
{
    [Table("accounts", Schema = "user")]
    public class account
    {
        [Key]
        public int user_id { get; set; }
        public string reg_email { get; set; }
        public string username { get; set; }
        public byte[] password { get; set; }
        public DateTime created_at { get; set; }
    }
}
