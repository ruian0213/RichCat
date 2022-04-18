using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace RichCat.Domain
{
    public partial class User:AggregateRoot
    {
        public User()
        {
            this.UserRole = new HashSet<UserRole>();
        }

        public Guid Id { get; set; }
        [Required]
        [MaxLength(64)]
        public string Name { get; set; }
        [Required]
        [MaxLength(512)]
        public string Password { get; set; }
        [Required]
        [MaxLength(128)]
        public string FullName { get; set; }
        public Guid DepartmentId { get; set; }
        public int Status { get; set; }

        [Required]
        [Column(TypeName = "date")]
        public System.DateTime CreateTime { get; set; }
        [Required]
        [Column(TypeName = "date")]
        public System.DateTime ModifyTime { get; set; }
        [MaxLength(256)]
        public string Remark { get; set; }

        public virtual Department Department { get; set; }

        public virtual ICollection<UserRole> UserRole { get; set; }
    }
}
