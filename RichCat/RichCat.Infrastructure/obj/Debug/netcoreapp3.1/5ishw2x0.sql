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

