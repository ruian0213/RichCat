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
    [JsonObject(MemberSerialization.OptOut)]
    public partial class UserRole : IEntity
    {
        [Required]
        public Guid RoleId { get; set; }
        [Required]
        public Guid UserId { get; set; }

        [JsonIgnore]
        [ForeignKey("RoleId")]
        public virtual Role Role { get; set; }

        [JsonIgnore]
        [ForeignKey("UserId")]
        public virtual User User { get; set; }
    }
}
