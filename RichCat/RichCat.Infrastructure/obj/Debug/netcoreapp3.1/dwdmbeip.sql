IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

CREATE TABLE [Departments] (
    [ID] uniqueidentifier NOT NULL,
    [Name] nvarchar(64) NOT NULL,
    [ParentId] uniqueidentifier NOT NULL,
    [Level] int NOT NULL,
    [Status] int NOT NULL,
    CONSTRAINT [PK_Departments] PRIMARY KEY ([ID])
);

GO

CREATE TABLE [Menus] (
    [Id] uniqueidentifier NOT NULL,
    [Name] nvarchar(64) NOT NULL,
    [Url] nvarchar(1024) NOT NULL,
    [ParentId] uniqueidentifier NOT NULL,
    [Level] int NOT NULL,
    [Order] nvarchar(64) NOT NULL,
    [Status] int NOT NULL,
    [Remark] nvarchar(64) NOT NULL,
    [Ico] nvarchar(1024) NULL,
    CONSTRAINT [PK_Menus] PRIMARY KEY ([Id])
);

GO

CREATE TABLE [Roles] (
    [Id] uniqueidentifier NOT NULL,
    [Name] nvarchar(64) NOT NULL,
    [description] nvarchar(1024) NOT NULL,
    [CreateTime] datetime2 NULL,
    [ModifyTime] datetime2 NULL,
    [RoleDefaultURL] nvarchar(max) NULL,
    CONSTRAINT [PK_Roles] PRIMARY KEY ([Id])
);

GO

CREATE TABLE [Users] (
    [Id] uniqueidentifier NOT NULL,
    [Name] nvarchar(64) NOT NULL,
    [Password] nvarchar(512) NOT NULL,
    [FullName] nvarchar(128) NOT NULL,
    [DepartmentId] uniqueidentifier NOT NULL,
    [Status] int NOT NULL,
    [CreateTime] date NULL,
    [ModifyTime] date NULL,
    [REMARK] nvarchar(max) NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Users_Departments_DepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [Departments] ([ID]) ON DELETE CASCADE
);

GO

CREATE TABLE [TB_MENUROLEs] (
    [RoleId] uniqueidentifier NOT NULL,
    [MenuId] uniqueidentifier NOT NULL,
    [RoleType] int NOT NULL,
    [ButtonId] nvarchar(64) NULL,
    CONSTRAINT [PK_TB_MENUROLEs] PRIMARY KEY ([MenuId], [RoleId]),
    CONSTRAINT [FK_TB_MENUROLEs_Menus_MenuId] FOREIGN KEY ([MenuId]) REFERENCES [Menus] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_TB_MENUROLEs_Roles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [Roles] ([Id]) ON DELETE CASCADE
);

GO

CREATE TABLE [UserRoles] (
    [RoleId] uniqueidentifier NOT NULL,
    [UserId] uniqueidentifier NOT NULL,
    CONSTRAINT [PK_UserRoles] PRIMARY KEY ([UserId], [RoleId]),
    CONSTRAINT [FK_UserRoles_Roles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [Roles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_UserRoles_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Users] ([Id]) ON DELETE CASCADE
);

GO

CREATE INDEX [IX_TB_MENUROLEs_RoleId] ON [TB_MENUROLEs] ([RoleId]);

GO

CREATE INDEX [IX_UserRoles_RoleId] ON [UserRoles] ([RoleId]);

GO

CREATE INDEX [IX_Users_DepartmentId] ON [Users] ([DepartmentId]);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220418023400_RichCatInitial', N'3.1.24');

GO

