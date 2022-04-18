using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RichCat.Domain
{
    /// <summary>
    /// 由于不会直接操作此表，所以TB_MENUROLE实体不必作为聚合根，只是作为领域实体即可
    /// </summary>
    public partial class MenuRole : IEntity
    {
        [Required]
        public Guid RoleId { get; set; }
        [Required]
        public Guid MenuId { get; set; }
        public int RoleType { get; set; }
        [MaxLength(64)]
        public string ButtonId { get; set; }

        public virtual Menu Menu { get; set; }
        public virtual Role Role { get; set; }
    }
}
