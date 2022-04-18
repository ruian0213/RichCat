using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RichCat.Domain
{
    public partial class Department : AggregateRoot
    {
        //public Department()
        //{
        //    this.Users = new HashSet<User>();
        //}


        public Guid Id { get; set; }
        [Required]
        [MaxLength(64)]
        public string Name { get; set; }
        public Guid? ParentId { get; set; }
        public int Level { get; set; }
        public int Status { get; set; }
        [JsonIgnore]
        [ForeignKey("ParentId")]
        public virtual Department Parent { get; set; }


        [JsonIgnore]
        public virtual ICollection<User> Users { get; set; }

        [JsonIgnore]
        public virtual ICollection<Department> SubDepartments { get; set; }

        public override string ToString()
        {
            return base.ToString();
        }

        
    }
}
