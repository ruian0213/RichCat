IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

CREATE TABLE [DEPARTMENTs] (
    [ID] nvarchar(450) NOT NULL,
    [DEPARTMENT_NAME] nvarchar(max) NULL,
    [PARENT_ID] nvarchar(max) NULL,
    [DEPARTMENT_LEVEL] nvarchar(max) NULL,
    [STATUS] nvarchar(max) NULL,
    CONSTRAINT [PK_DEPARTMENTs] PRIMARY KEY ([ID])
);

GO

CREATE TABLE [MENUs] (
    [ID] nvarchar(450) NOT NULL,
    [MENU_NAME] nvarchar(max) NULL,
    [MENU_URL] nvarchar(max) NULL,
    [PARENT_ID] nvarchar(max) NULL,
    [MENU_LEVEL] nvarchar(max) NULL,
    [SORT_ORDER] nvarchar(max) NULL,
    [STATUS] nvarchar(max) NULL,
    [REMARK] nvarchar(max) NULL,
    [MENU_ICO] nvarchar(max) NULL,
    CONSTRAINT [PK_MENUs] PRIMARY KEY ([ID])
);

GO

CREATE TABLE [ROLEs] (
    [ID] nvarchar(450) NOT NULL,
    [ROLE_NAME] nvarchar(max) NULL,
    [DESCRIPTION] nvarchar(max) NULL,
    [CREATETIME] datetime2 NULL,
    [MODIFYTIME] datetime2 NULL,
    [ROLE_DEFAULTURL] nvarchar(max) NULL,
    CONSTRAINT [PK_ROLEs] PRIMARY KEY ([ID])
);

GO

CREATE TABLE [USERSs] (
    [ID] nvarchar(450) NOT NULL,
    [USER_NAME] nvarchar(max) NULL,
    [USER_PASSWORD] nvarchar(max) NULL,
    [FULLNAME] nvarchar(max) NULL,
    [DEPARTMENT_ID] nvarchar(max) NULL,
    [STATUS] nvarchar(max) NULL,
    [CREATETIME] datetime2 NULL,
    [MODIFYTIME] datetime2 NULL,
    [REMARK] nvarchar(max) NULL,
    [TB_DEPARTMENTID] nvarchar(450) NULL,
    CONSTRAINT [PK_USERSs] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_USERSs_DEPARTMENTs_TB_DEPARTMENTID] FOREIGN KEY ([TB_DEPARTMENTID]) REFERENCES [DEPARTMENTs] ([ID]) ON DELETE NO ACTION
);

GO

CREATE TABLE [TB_MENUROLEs] (
    [ID] nvarchar(450) NOT NULL,
    [ROLE_ID] nvarchar(max) NULL,
    [MENU_ID] nvarchar(max) NULL,
    [ROLE_TYPE] nvarchar(max) NULL,
    [BUTTON_ID] nvarchar(max) NULL,
    [TB_MENUID] nvarchar(450) NULL,
    [TB_ROLEID] nvarchar(450) NULL,
    CONSTRAINT [PK_TB_MENUROLEs] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_TB_MENUROLEs_MENUs_TB_MENUID] FOREIGN KEY ([TB_MENUID]) REFERENCES [MENUs] ([ID]) ON DELETE NO ACTION,
    CONSTRAINT [FK_TB_MENUROLEs_ROLEs_TB_ROLEID] FOREIGN KEY ([TB_ROLEID]) REFERENCES [ROLEs] ([ID]) ON DELETE NO ACTION
);

GO

CREATE TABLE [USERROLEs] (
    [ID] nvarchar(450) NOT NULL,
    [ROLE_ID] nvarchar(max) NULL,
    [USER_ID] nvarchar(max) NULL,
    [TB_ROLEID] nvarchar(450) NULL,
    [TB_USERSID] nvarchar(450) NULL,
    CONSTRAINT [PK_USERROLEs] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_USERROLEs_ROLEs_TB_ROLEID] FOREIGN KEY ([TB_ROLEID]) REFERENCES [ROLEs] ([ID]) ON DELETE NO ACTION,
    CONSTRAINT [FK_USERROLEs_USERSs_TB_USERSID] FOREIGN KEY ([TB_USERSID]) REFERENCES [USERSs] ([ID]) ON DELETE NO ACTION
);

GO

CREATE INDEX [IX_TB_MENUROLEs_TB_MENUID] ON [TB_MENUROLEs] ([TB_MENUID]);

GO

CREATE INDEX [IX_TB_MENUROLEs_TB_ROLEID] ON [TB_MENUROLEs] ([TB_ROLEID]);

GO

CREATE INDEX [IX_USERROLEs_TB_ROLEID] ON [USERROLEs] ([TB_ROLEID]);

GO

CREATE INDEX [IX_USERROLEs_TB_USERSID] ON [USERROLEs] ([TB_USERSID]);

GO

CREATE INDEX [IX_USERSs_TB_DEPARTMENTID] ON [USERSs] ([TB_DEPARTMENTID]);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220416085445_RichCatInitial', N'3.1.24');

GO

DROP INDEX [IX_USERSs_TB_DEPARTMENTID] ON [USERSs];
DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[USERSs]') AND [c].[name] = N'TB_DEPARTMENTID');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [USERSs] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [USERSs] ALTER COLUMN [TB_DEPARTMENTID] uniqueidentifier NULL;
CREATE INDEX [IX_USERSs_TB_DEPARTMENTID] ON [USERSs] ([TB_DEPARTMENTID]);

GO

DECLARE @var1 sysname;
SELECT @var1 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DEPARTMENTs]') AND [c].[name] = N'DEPARTMENT_NAME');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [DEPARTMENTs] DROP CONSTRAINT [' + @var1 + '];');
ALTER TABLE [DEPARTMENTs] ALTER COLUMN [DEPARTMENT_NAME] nvarchar(100) NOT NULL;

GO

DECLARE @var2 sysname;
SELECT @var2 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DEPARTMENTs]') AND [c].[name] = N'ID');
IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [DEPARTMENTs] DROP CONSTRAINT [' + @var2 + '];');
ALTER TABLE [DEPARTMENTs] ALTER COLUMN [ID] uniqueidentifier NOT NULL;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220416091143_ChangeSomeProperties', N'3.1.24');

GO

DECLARE @var3 sysname;
SELECT @var3 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[USERSs]') AND [c].[name] = N'USER_PASSWORD');
IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [USERSs] DROP CONSTRAINT [' + @var3 + '];');
ALTER TABLE [USERSs] ALTER COLUMN [USER_PASSWORD] nvarchar(512) NOT NULL;

GO

DECLARE @var4 sysname;
SELECT @var4 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[USERSs]') AND [c].[name] = N'USER_NAME');
IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [USERSs] DROP CONSTRAINT [' + @var4 + '];');
ALTER TABLE [USERSs] ALTER COLUMN [USER_NAME] nvarchar(64) NOT NULL;

GO

DECLARE @var5 sysname;
SELECT @var5 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[USERSs]') AND [c].[name] = N'STATUS');
IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [USERSs] DROP CONSTRAINT [' + @var5 + '];');
ALTER TABLE [USERSs] ALTER COLUMN [STATUS] int NOT NULL;

GO

DECLARE @var6 sysname;
SELECT @var6 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[USERSs]') AND [c].[name] = N'MODIFYTIME');
IF @var6 IS NOT NULL EXEC(N'ALTER TABLE [USERSs] DROP CONSTRAINT [' + @var6 + '];');
ALTER TABLE [USERSs] ALTER COLUMN [MODIFYTIME] date NULL;

GO

DECLARE @var7 sysname;
SELECT @var7 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[USERSs]') AND [c].[name] = N'FULLNAME');
IF @var7 IS NOT NULL EXEC(N'ALTER TABLE [USERSs] DROP CONSTRAINT [' + @var7 + '];');
ALTER TABLE [USERSs] ALTER COLUMN [FULLNAME] nvarchar(128) NOT NULL;

GO

DECLARE @var8 sysname;
SELECT @var8 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[USERSs]') AND [c].[name] = N'DEPARTMENT_ID');
IF @var8 IS NOT NULL EXEC(N'ALTER TABLE [USERSs] DROP CONSTRAINT [' + @var8 + '];');
ALTER TABLE [USERSs] ALTER COLUMN [DEPARTMENT_ID] uniqueidentifier NOT NULL;

GO

DECLARE @var9 sysname;
SELECT @var9 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[USERSs]') AND [c].[name] = N'CREATETIME');
IF @var9 IS NOT NULL EXEC(N'ALTER TABLE [USERSs] DROP CONSTRAINT [' + @var9 + '];');
ALTER TABLE [USERSs] ALTER COLUMN [CREATETIME] date NULL;

GO

DECLARE @var10 sysname;
SELECT @var10 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[USERSs]') AND [c].[name] = N'ID');
IF @var10 IS NOT NULL EXEC(N'ALTER TABLE [USERSs] DROP CONSTRAINT [' + @var10 + '];');
ALTER TABLE [USERSs] ALTER COLUMN [ID] uniqueidentifier NOT NULL;

GO

DECLARE @var11 sysname;
SELECT @var11 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[USERROLEs]') AND [c].[name] = N'USER_ID');
IF @var11 IS NOT NULL EXEC(N'ALTER TABLE [USERROLEs] DROP CONSTRAINT [' + @var11 + '];');
ALTER TABLE [USERROLEs] ALTER COLUMN [USER_ID] uniqueidentifier NOT NULL;

GO

DROP INDEX [IX_USERROLEs_TB_USERSID] ON [USERROLEs];
DECLARE @var12 sysname;
SELECT @var12 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[USERROLEs]') AND [c].[name] = N'TB_USERSID');
IF @var12 IS NOT NULL EXEC(N'ALTER TABLE [USERROLEs] DROP CONSTRAINT [' + @var12 + '];');
ALTER TABLE [USERROLEs] ALTER COLUMN [TB_USERSID] uniqueidentifier NULL;
CREATE INDEX [IX_USERROLEs_TB_USERSID] ON [USERROLEs] ([TB_USERSID]);

GO

DROP INDEX [IX_USERROLEs_TB_ROLEID] ON [USERROLEs];
DECLARE @var13 sysname;
SELECT @var13 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[USERROLEs]') AND [c].[name] = N'TB_ROLEID');
IF @var13 IS NOT NULL EXEC(N'ALTER TABLE [USERROLEs] DROP CONSTRAINT [' + @var13 + '];');
ALTER TABLE [USERROLEs] ALTER COLUMN [TB_ROLEID] uniqueidentifier NULL;
CREATE INDEX [IX_USERROLEs_TB_ROLEID] ON [USERROLEs] ([TB_ROLEID]);

GO

DECLARE @var14 sysname;
SELECT @var14 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[USERROLEs]') AND [c].[name] = N'ROLE_ID');
IF @var14 IS NOT NULL EXEC(N'ALTER TABLE [USERROLEs] DROP CONSTRAINT [' + @var14 + '];');
ALTER TABLE [USERROLEs] ALTER COLUMN [ROLE_ID] uniqueidentifier NOT NULL;

GO

DECLARE @var15 sysname;
SELECT @var15 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[USERROLEs]') AND [c].[name] = N'ID');
IF @var15 IS NOT NULL EXEC(N'ALTER TABLE [USERROLEs] DROP CONSTRAINT [' + @var15 + '];');
ALTER TABLE [USERROLEs] ALTER COLUMN [ID] uniqueidentifier NOT NULL;

GO

DROP INDEX [IX_TB_MENUROLEs_TB_ROLEID] ON [TB_MENUROLEs];
DECLARE @var16 sysname;
SELECT @var16 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TB_MENUROLEs]') AND [c].[name] = N'TB_ROLEID');
IF @var16 IS NOT NULL EXEC(N'ALTER TABLE [TB_MENUROLEs] DROP CONSTRAINT [' + @var16 + '];');
ALTER TABLE [TB_MENUROLEs] ALTER COLUMN [TB_ROLEID] uniqueidentifier NULL;
CREATE INDEX [IX_TB_MENUROLEs_TB_ROLEID] ON [TB_MENUROLEs] ([TB_ROLEID]);

GO

DROP INDEX [IX_TB_MENUROLEs_TB_MENUID] ON [TB_MENUROLEs];
DECLARE @var17 sysname;
SELECT @var17 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TB_MENUROLEs]') AND [c].[name] = N'TB_MENUID');
IF @var17 IS NOT NULL EXEC(N'ALTER TABLE [TB_MENUROLEs] DROP CONSTRAINT [' + @var17 + '];');
ALTER TABLE [TB_MENUROLEs] ALTER COLUMN [TB_MENUID] uniqueidentifier NULL;
CREATE INDEX [IX_TB_MENUROLEs_TB_MENUID] ON [TB_MENUROLEs] ([TB_MENUID]);

GO

DECLARE @var18 sysname;
SELECT @var18 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TB_MENUROLEs]') AND [c].[name] = N'ROLE_TYPE');
IF @var18 IS NOT NULL EXEC(N'ALTER TABLE [TB_MENUROLEs] DROP CONSTRAINT [' + @var18 + '];');
ALTER TABLE [TB_MENUROLEs] ALTER COLUMN [ROLE_TYPE] int NOT NULL;

GO

DECLARE @var19 sysname;
SELECT @var19 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TB_MENUROLEs]') AND [c].[name] = N'ROLE_ID');
IF @var19 IS NOT NULL EXEC(N'ALTER TABLE [TB_MENUROLEs] DROP CONSTRAINT [' + @var19 + '];');
ALTER TABLE [TB_MENUROLEs] ALTER COLUMN [ROLE_ID] uniqueidentifier NOT NULL;

GO

DECLARE @var20 sysname;
SELECT @var20 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TB_MENUROLEs]') AND [c].[name] = N'MENU_ID');
IF @var20 IS NOT NULL EXEC(N'ALTER TABLE [TB_MENUROLEs] DROP CONSTRAINT [' + @var20 + '];');
ALTER TABLE [TB_MENUROLEs] ALTER COLUMN [MENU_ID] uniqueidentifier NOT NULL;

GO

DECLARE @var21 sysname;
SELECT @var21 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TB_MENUROLEs]') AND [c].[name] = N'BUTTON_ID');
IF @var21 IS NOT NULL EXEC(N'ALTER TABLE [TB_MENUROLEs] DROP CONSTRAINT [' + @var21 + '];');
ALTER TABLE [TB_MENUROLEs] ALTER COLUMN [BUTTON_ID] nvarchar(64) NOT NULL;

GO

DECLARE @var22 sysname;
SELECT @var22 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TB_MENUROLEs]') AND [c].[name] = N'ID');
IF @var22 IS NOT NULL EXEC(N'ALTER TABLE [TB_MENUROLEs] DROP CONSTRAINT [' + @var22 + '];');
ALTER TABLE [TB_MENUROLEs] ALTER COLUMN [ID] uniqueidentifier NOT NULL;

GO

DECLARE @var23 sysname;
SELECT @var23 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ROLEs]') AND [c].[name] = N'ROLE_NAME');
IF @var23 IS NOT NULL EXEC(N'ALTER TABLE [ROLEs] DROP CONSTRAINT [' + @var23 + '];');
ALTER TABLE [ROLEs] ALTER COLUMN [ROLE_NAME] nvarchar(64) NOT NULL;

GO

DECLARE @var24 sysname;
SELECT @var24 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ROLEs]') AND [c].[name] = N'DESCRIPTION');
IF @var24 IS NOT NULL EXEC(N'ALTER TABLE [ROLEs] DROP CONSTRAINT [' + @var24 + '];');
ALTER TABLE [ROLEs] ALTER COLUMN [DESCRIPTION] nvarchar(1024) NOT NULL;

GO

DECLARE @var25 sysname;
SELECT @var25 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ROLEs]') AND [c].[name] = N'ID');
IF @var25 IS NOT NULL EXEC(N'ALTER TABLE [ROLEs] DROP CONSTRAINT [' + @var25 + '];');
ALTER TABLE [ROLEs] ALTER COLUMN [ID] uniqueidentifier NOT NULL;

GO

DECLARE @var26 sysname;
SELECT @var26 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[MENUs]') AND [c].[name] = N'STATUS');
IF @var26 IS NOT NULL EXEC(N'ALTER TABLE [MENUs] DROP CONSTRAINT [' + @var26 + '];');
ALTER TABLE [MENUs] ALTER COLUMN [STATUS] int NOT NULL;

GO

DECLARE @var27 sysname;
SELECT @var27 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[MENUs]') AND [c].[name] = N'SORT_ORDER');
IF @var27 IS NOT NULL EXEC(N'ALTER TABLE [MENUs] DROP CONSTRAINT [' + @var27 + '];');
ALTER TABLE [MENUs] ALTER COLUMN [SORT_ORDER] nvarchar(64) NOT NULL;

GO

DECLARE @var28 sysname;
SELECT @var28 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[MENUs]') AND [c].[name] = N'REMARK');
IF @var28 IS NOT NULL EXEC(N'ALTER TABLE [MENUs] DROP CONSTRAINT [' + @var28 + '];');
ALTER TABLE [MENUs] ALTER COLUMN [REMARK] nvarchar(64) NOT NULL;

GO

DECLARE @var29 sysname;
SELECT @var29 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[MENUs]') AND [c].[name] = N'PARENT_ID');
IF @var29 IS NOT NULL EXEC(N'ALTER TABLE [MENUs] DROP CONSTRAINT [' + @var29 + '];');
ALTER TABLE [MENUs] ALTER COLUMN [PARENT_ID] uniqueidentifier NOT NULL;

GO

DECLARE @var30 sysname;
SELECT @var30 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[MENUs]') AND [c].[name] = N'MENU_URL');
IF @var30 IS NOT NULL EXEC(N'ALTER TABLE [MENUs] DROP CONSTRAINT [' + @var30 + '];');
ALTER TABLE [MENUs] ALTER COLUMN [MENU_URL] nvarchar(1024) NOT NULL;

GO

DECLARE @var31 sysname;
SELECT @var31 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[MENUs]') AND [c].[name] = N'MENU_NAME');
IF @var31 IS NOT NULL EXEC(N'ALTER TABLE [MENUs] DROP CONSTRAINT [' + @var31 + '];');
ALTER TABLE [MENUs] ALTER COLUMN [MENU_NAME] nvarchar(64) NOT NULL;

GO

DECLARE @var32 sysname;
SELECT @var32 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[MENUs]') AND [c].[name] = N'MENU_LEVEL');
IF @var32 IS NOT NULL EXEC(N'ALTER TABLE [MENUs] DROP CONSTRAINT [' + @var32 + '];');
ALTER TABLE [MENUs] ALTER COLUMN [MENU_LEVEL] int NOT NULL;

GO

DECLARE @var33 sysname;
SELECT @var33 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[MENUs]') AND [c].[name] = N'MENU_ICO');
IF @var33 IS NOT NULL EXEC(N'ALTER TABLE [MENUs] DROP CONSTRAINT [' + @var33 + '];');
ALTER TABLE [MENUs] ALTER COLUMN [MENU_ICO] nvarchar(1024) NULL;

GO

DECLARE @var34 sysname;
SELECT @var34 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[MENUs]') AND [c].[name] = N'ID');
IF @var34 IS NOT NULL EXEC(N'ALTER TABLE [MENUs] DROP CONSTRAINT [' + @var34 + '];');
ALTER TABLE [MENUs] ALTER COLUMN [ID] uniqueidentifier NOT NULL;

GO

DECLARE @var35 sysname;
SELECT @var35 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DEPARTMENTs]') AND [c].[name] = N'STATUS');
IF @var35 IS NOT NULL EXEC(N'ALTER TABLE [DEPARTMENTs] DROP CONSTRAINT [' + @var35 + '];');
ALTER TABLE [DEPARTMENTs] ALTER COLUMN [STATUS] int NOT NULL;

GO

DECLARE @var36 sysname;
SELECT @var36 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DEPARTMENTs]') AND [c].[name] = N'PARENT_ID');
IF @var36 IS NOT NULL EXEC(N'ALTER TABLE [DEPARTMENTs] DROP CONSTRAINT [' + @var36 + '];');
ALTER TABLE [DEPARTMENTs] ALTER COLUMN [PARENT_ID] uniqueidentifier NOT NULL;

GO

DECLARE @var37 sysname;
SELECT @var37 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DEPARTMENTs]') AND [c].[name] = N'DEPARTMENT_NAME');
IF @var37 IS NOT NULL EXEC(N'ALTER TABLE [DEPARTMENTs] DROP CONSTRAINT [' + @var37 + '];');
ALTER TABLE [DEPARTMENTs] ALTER COLUMN [DEPARTMENT_NAME] nvarchar(64) NOT NULL;

GO

DECLARE @var38 sysname;
SELECT @var38 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[DEPARTMENTs]') AND [c].[name] = N'DEPARTMENT_LEVEL');
IF @var38 IS NOT NULL EXEC(N'ALTER TABLE [DEPARTMENTs] DROP CONSTRAINT [' + @var38 + '];');
ALTER TABLE [DEPARTMENTs] ALTER COLUMN [DEPARTMENT_LEVEL] int NOT NULL;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220416092359_ChangeSomeProperties2', N'3.1.24');

GO

