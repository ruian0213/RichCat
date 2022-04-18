using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace RichCat.Infrastructure.Migrations
{
    public partial class RichCatInitial : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Departments",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    Name = table.Column<string>(maxLength: 64, nullable: false),
                    ParentId = table.Column<Guid>(nullable: true),
                    Level = table.Column<int>(nullable: false),
                    Status = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Departments", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Departments_Departments_ParentId",
                        column: x => x.ParentId,
                        principalTable: "Departments",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Menus",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    Name = table.Column<string>(maxLength: 64, nullable: false),
                    Url = table.Column<string>(maxLength: 1024, nullable: false),
                    ParentId = table.Column<Guid>(nullable: false),
                    Level = table.Column<int>(nullable: false),
                    Order = table.Column<string>(maxLength: 64, nullable: false),
                    Status = table.Column<int>(nullable: false),
                    Remark = table.Column<string>(maxLength: 64, nullable: false),
                    Ico = table.Column<string>(maxLength: 1024, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Menus", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Roles",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    Name = table.Column<string>(maxLength: 64, nullable: false),
                    description = table.Column<string>(maxLength: 1024, nullable: false),
                    CreateTime = table.Column<DateTime>(nullable: true),
                    ModifyTime = table.Column<DateTime>(nullable: true),
                    RoleDefaultURL = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Roles", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    Name = table.Column<string>(maxLength: 64, nullable: false),
                    Password = table.Column<string>(maxLength: 512, nullable: false),
                    FullName = table.Column<string>(maxLength: 128, nullable: false),
                    DepartmentId = table.Column<Guid>(nullable: false),
                    Status = table.Column<int>(nullable: false),
                    CreateTime = table.Column<DateTime>(type: "date", nullable: false),
                    ModifyTime = table.Column<DateTime>(type: "date", nullable: false),
                    Remark = table.Column<string>(maxLength: 256, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Users_Departments_DepartmentId",
                        column: x => x.DepartmentId,
                        principalTable: "Departments",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "MenuRoles",
                columns: table => new
                {
                    RoleId = table.Column<Guid>(nullable: false),
                    MenuId = table.Column<Guid>(nullable: false),
                    RoleType = table.Column<int>(nullable: false),
                    ButtonId = table.Column<string>(maxLength: 64, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MenuRoles", x => new { x.MenuId, x.RoleId });
                    table.ForeignKey(
                        name: "FK_MenuRoles_Menus_MenuId",
                        column: x => x.MenuId,
                        principalTable: "Menus",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_MenuRoles_Roles_RoleId",
                        column: x => x.RoleId,
                        principalTable: "Roles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "UserRoles",
                columns: table => new
                {
                    RoleId = table.Column<Guid>(nullable: false),
                    UserId = table.Column<Guid>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserRoles", x => new { x.UserId, x.RoleId });
                    table.ForeignKey(
                        name: "FK_UserRoles_Roles_RoleId",
                        column: x => x.RoleId,
                        principalTable: "Roles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_UserRoles_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.InsertData(
                table: "Departments",
                columns: new[] { "Id", "Level", "Name", "ParentId", "Status" },
                values: new object[] { new Guid("123f46ae-4c63-4cdb-814a-ae13a00a1034"), 0, "Departments", null, 0 });

            migrationBuilder.InsertData(
                table: "Menus",
                columns: new[] { "Id", "Ico", "Level", "Name", "Order", "ParentId", "Remark", "Status", "Url" },
                values: new object[] { new Guid("c6e8bc91-4cd5-4261-aa04-82713c04f6d5"), "", 0, "menu1", "", new Guid("00000000-0000-0000-0000-000000000000"), "", 0, "" });

            migrationBuilder.InsertData(
                table: "Roles",
                columns: new[] { "Id", "CreateTime", "ModifyTime", "Name", "RoleDefaultURL", "description" },
                values: new object[] { new Guid("c9034d0a-fb56-4b16-96b3-8c3688a6cabb"), new DateTime(2022, 4, 18, 15, 27, 53, 332, DateTimeKind.Local).AddTicks(1060), new DateTime(2022, 4, 18, 15, 27, 53, 332, DateTimeKind.Local).AddTicks(2705), "Role1", "", "" });

            migrationBuilder.InsertData(
                table: "MenuRoles",
                columns: new[] { "MenuId", "RoleId", "ButtonId", "RoleType" },
                values: new object[] { new Guid("c6e8bc91-4cd5-4261-aa04-82713c04f6d5"), new Guid("c9034d0a-fb56-4b16-96b3-8c3688a6cabb"), "Button1", 0 });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "CreateTime", "DepartmentId", "FullName", "ModifyTime", "Name", "Password", "Remark", "Status" },
                values: new object[] { new Guid("e23e73a9-486a-44bd-b8b4-a85bbc68fe0e"), new DateTime(2022, 4, 18, 15, 27, 53, 332, DateTimeKind.Local).AddTicks(6879), new Guid("123f46ae-4c63-4cdb-814a-ae13a00a1034"), "Tester1", new DateTime(2022, 4, 18, 15, 27, 53, 332, DateTimeKind.Local).AddTicks(9336), "Tester1", "111111", "", 0 });

            migrationBuilder.InsertData(
                table: "UserRoles",
                columns: new[] { "UserId", "RoleId" },
                values: new object[] { new Guid("e23e73a9-486a-44bd-b8b4-a85bbc68fe0e"), new Guid("c9034d0a-fb56-4b16-96b3-8c3688a6cabb") });

            migrationBuilder.CreateIndex(
                name: "IX_Departments_ParentId",
                table: "Departments",
                column: "ParentId");

            migrationBuilder.CreateIndex(
                name: "IX_MenuRoles_RoleId",
                table: "MenuRoles",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "IX_UserRoles_RoleId",
                table: "UserRoles",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "IX_Users_DepartmentId",
                table: "Users",
                column: "DepartmentId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "MenuRoles");

            migrationBuilder.DropTable(
                name: "UserRoles");

            migrationBuilder.DropTable(
                name: "Menus");

            migrationBuilder.DropTable(
                name: "Roles");

            migrationBuilder.DropTable(
                name: "Users");

            migrationBuilder.DropTable(
                name: "Departments");
        }
    }
}
