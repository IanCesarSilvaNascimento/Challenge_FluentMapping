IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [Category] (
    [Id] int NOT NULL IDENTITY,
    [Name] NVARCHAR(80) NOT NULL,
    [Slug] VARCHAR(80) NOT NULL,
    CONSTRAINT [PK_Category] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [User] (
    [Id] int NOT NULL IDENTITY,
    [Name] NVARCHAR(80) NOT NULL,
    [Email] nvarchar(max) NULL,
    [PasswordHash] nvarchar(max) NULL,
    [Image] nvarchar(max) NULL,
    [Slug] VARCHAR(80) NOT NULL,
    [Bio] nvarchar(max) NULL,
    CONSTRAINT [PK_User] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Post] (
    [Id] int NOT NULL IDENTITY,
    [Title] nvarchar(max) NULL,
    [Summary] nvarchar(max) NULL,
    [Body] nvarchar(max) NULL,
    [Slug] nvarchar(450) NULL,
    [CreateDate] datetime2 NOT NULL,
    [LastUpdateDate] SMALLDATETIME NOT NULL DEFAULT (GETDATE()),
    [CategoryId] int NULL,
    [UserId] int NULL,
    CONSTRAINT [PK_Post] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Post_Category] FOREIGN KEY ([CategoryId]) REFERENCES [Category] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Post_User_UserId] FOREIGN KEY ([UserId]) REFERENCES [User] ([Id])
);
GO

CREATE UNIQUE INDEX [IX_Category_Slug] ON [Category] ([Slug]);
GO

CREATE INDEX [IX_Post_CategoryId] ON [Post] ([CategoryId]);
GO

CREATE UNIQUE INDEX [IX_Post_Slug] ON [Post] ([Slug]) WHERE [Slug] IS NOT NULL;
GO

CREATE INDEX [IX_Post_UserId] ON [Post] ([UserId]);
GO

CREATE UNIQUE INDEX [IX_User_Slug] ON [User] ([Slug]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220101020433_InitialCreation', N'6.0.1');
GO

COMMIT;
GO

