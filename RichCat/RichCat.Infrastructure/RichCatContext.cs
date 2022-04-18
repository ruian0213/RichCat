using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;

using RichCat.Domain;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Logging.Debug;

namespace RichCat.Infrastructure
{
    public class RichCatContext : DbContext
    {


        public DbSet<Department> Departments { get; set; }
        public DbSet<Menu> Menus { get; set; }
        public DbSet<Role> Roles { get; set; }
        public DbSet<MenuRole> MenuRoles { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<UserRole> UserRoles { get; set; }
        

        public RichCatContext(DbContextOptions<RichCatContext> options) : base(options)
        {
            
        }

        //protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        //{
        //    optionsBuilder.UseLoggerFactory(LoggerFactory).EnableSensitiveDataLogging()
        //        .UseSqlServer("Data Source = .; Initial Catalog = RichCat; User Id = sa; Password = Aa000000");
        //}

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UserRole>().HasKey(x => new { x.UserId, x.RoleId });

            modelBuilder.Entity<MenuRole>().HasKey(x => new { x.MenuId, x.RoleId });

            modelBuilder.Entity<UserRole>().HasOne(ur => ur.User).WithMany(u => u.UserRole).HasForeignKey(ur => ur.UserId).OnDelete(DeleteBehavior.Restrict);
            modelBuilder.Entity<UserRole>().HasOne(ur => ur.Role).WithMany(r => r.UserRole).HasForeignKey(ur => ur.RoleId).OnDelete(DeleteBehavior.Restrict);
            modelBuilder.Entity<User>().HasOne(u => u.Department).WithMany(d => d.Users).HasForeignKey(u=>u.DepartmentId).OnDelete(DeleteBehavior.Restrict);


            modelBuilder.Entity<Department>().HasOne(d => d.Parent).WithMany(d => d.SubDepartments)
                .HasForeignKey(d => d.ParentId).OnDelete(DeleteBehavior.Restrict);

            Guid departmentId = Guid.NewGuid();
            Department department = new Department{ Id = departmentId , Level = 0, Name="Departments", Status = 0 };
            Guid menuId = Guid.NewGuid();
            Menu menu = new Menu{ Id = menuId , Level= 0, Ico="", Name="menu1", ParentId = Guid.Empty, Order = string.Empty, Remark=string.Empty, Status = 0, Url = ""};
            Guid roleId = Guid.NewGuid();
            Role role = new Role { Id = roleId, CreateTime= DateTime.Now, description=string.Empty, ModifyTime= DateTime.Now, Name ="Role1", RoleDefaultURL=string.Empty };
            Guid userId = Guid.NewGuid();
            User user = new User { CreateTime = DateTime.Now, DepartmentId = departmentId, FullName = "Tester1", Id = userId, ModifyTime = DateTime.Now, Name = "Tester1", Password = "111111", Remark = string.Empty, Status = 0 };
            MenuRole menuRole = new MenuRole { ButtonId = "Button1", MenuId = menuId, RoleId=roleId, RoleType = 0 };
            UserRole userRole = new UserRole { RoleId=roleId, UserId =userId };

            modelBuilder.Entity<Department>().HasData(department);
            modelBuilder.Entity<Menu>().HasData(menu);
            modelBuilder.Entity<Role>().HasData(role);
            modelBuilder.Entity<User>().HasData(user);
            modelBuilder.Entity<MenuRole>().HasData(menuRole);
            modelBuilder.Entity<UserRole>().HasData(userRole);

        }

        /// <summary>
        /// 创建数据库方法
        /// </summary>
        /// <param name="UserId"></param>
        /// <returns></returns>
        [DbFunction]
        public static User DataBaseFunction(Guid UserId)
        {
            throw new NotImplementedException();
        }


        public static readonly LoggerFactory LoggerFactory = new LoggerFactory(new[] { new DebugLoggerProvider() });
    }
}
