using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RichCat.Domain
{
    public partial class Role : AggregateRoot
    {


        public Role()
        {
            this.MenuRole = new HashSet<MenuRole>();
            this.UserRole = new HashSet<UserRole>();
        }

        public Guid Id { get; set; }
        [Required]
        [MaxLength(64)]
        public string Name { get; set; }
        [Required]
        [MaxLength(1024)]
        public string description { get; set; }
        public Nullable<System.DateTime> CreateTime { get; set; }
        public Nullable<System.DateTime> ModifyTime { get; set; }
        public string RoleDefaultURL { get; set; }

        public virtual ICollection<MenuRole> MenuRole { get; set; }
        public virtual ICollection<UserRole> UserRole { get; set; }
    }
}

