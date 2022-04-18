using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RichCat.Domain
{
    public partial class Menu : AggregateRoot
    {
        public Menu()
        {
            this.MenumRole = new HashSet<MenuRole>();
        }

        public Guid Id { get; set; }
        [Required]
        [MaxLength(64)]
        public string Name { get; set; }
        [Required]
        [MaxLength(1024)]
        public string Url { get; set; }
        public Guid ParentId { get; set; }
        public int Level { get; set; }
        [Required]
        [MaxLength(64)]
        public string Order { get; set; }
        public int Status { get; set; }
        [Required]
        [MaxLength(64)]
        public string Remark { get; set; }
        [MaxLength(1024)]
        public string Ico { get; set; }

        public virtual ICollection<MenuRole> MenumRole { get; set; }
    }
}
