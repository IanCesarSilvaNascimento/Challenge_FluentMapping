## Data
   Possui o contexto do banco de dados em memória e a conexão com o banco de dados Forum.
```Code
  using Forum.Models;
  using Microsoft.EntityFrameworkCore;

  namespace Forum.Data
  {

      public class ForumDataContext : DbContext
      {

          public DbSet<Category>? Categories { get; set; }


          public DbSet<Post>? Posts { get; set; }


          public DbSet<Role>? Roles { get; set; }


          public DbSet<User>? Users { get; set; }

          protected override void OnConfiguring(DbContextOptionsBuilder options)
              =>options.UseSqlServer("Server=localhost,1433;Database=Forum;User ID=sa;Password=1q2w3e4r@#$");


      }
  }
```
## Models
  Possui o contexto de configurações das tabelas Category,User,Post e Role do banco de dados.
```Code
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Forum.Models
{
    //     CREATE TABLE [Post] (
    //     [Id] INT NOT NULL IDENTITY(1, 1),
    //     [CategoryId] INT NOT NULL,
    //     [AuthorId] INT NOT NULL,
    //     [Title] VARCHAR(160) NOT NULL,
    //     [Summary] VARCHAR(255) NOT NULL,
    //     [Body] TEXT NOT NULL,
    //     [Slug] VARCHAR(80) NOT NULL,
    //     [CreateDate] DATETIME NOT NULL DEFAULT(GETDATE()),
    //     [LastUpdateDate] DATETIME NOT NULL DEFAULT(GETDATE()),

    //     CONSTRAINT [PK_Post] PRIMARY KEY([Id]),
    //     CONSTRAINT [FK_Post_Category] FOREIGN KEY([CategoryId]) REFERENCES [Category]([Id]),
    //     CONSTRAINT [UQ_Post_Slug] UNIQUE([Slug])
    // )
    // CREATE NONCLUSTERED INDEX [IX_Post_Slug] ON [Post]([Slug])

    [Table("Post")]

    public class Post
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
               
        [Required]
        [MinLength(3)]
        [MaxLength(160)]
        [Column("Title", TypeName = "NVARCHAR")]
        public string? Title { get; set; }
        
        [Required]
        [MinLength(3)]
        [MaxLength(255)]
        [Column("Summary", TypeName = "NVARCHAR")]
        public string? Summary { get; set; }
        
        [Required]
        [Column("Body", TypeName = "TEXT")]
        public string? Body { get; set; }
        
        [Required]
        [MinLength(3)]
        [MaxLength(80)]
        [Column("Slug", TypeName = "NVARCHAR")]
        public string? Slug { get; set; }

        [Required]
        [Column("CreateDate",TypeName = "DateTime")]
        public DateTime CreateDate { get; set; }

        
        [Required]
        [Column("LastUpdateDate",TypeName = "DateTime")]
        public DateTime LastUpdateDate { get; set; }

        [ForeignKey("CategoryId")]
        public int CategoryId { get; set; }
        public Category? category { get; set; }
 
    }
}
```
# Program.cs
  Classe principal para testar a inclusão, leitura, atualização e remoção do mapeamento.
```Code
using Forum.Data;
using Forum.Models;
using Microsoft.EntityFrameworkCore;

namespace Forum
{

    public class Program
    {

        public static void Main()
        {

            using var context = new ForumDataContext();

            var user = new User
            {
                Name = "Goku SSJ3",
                Slug = "gokussj3",
                Email = "teste4@gmail.com",
                Bio = "MVP dragon ball",
                Image = "image teste",
                PasswordHash = "123098457"
            };

            var category = new Category
            {
                Name = "Testando Fundamento EF core",
                Slug = "testando-fundamento-ef-core"
            };

            var post = new Post
            {
                category = category,
                Body = "<p>Hello world</p>",
                Slug = "testando-fundamento", 
                Summary = "Neste artigo vamos testar",
                Title = "Começando a testar",
                CreateDate = DateTime.Now,
                LastUpdateDate = DateTime.Now,
            };
            context.Users.Add(user);
            context.Posts.Add(post);
            context.SaveChanges();

            //Listando usuários do banco
            var items = context
                .Users
                .AsNoTracking()
                .ToList();

            foreach (var item in items)
                Console.WriteLine(item.Name);





        }

    }
}
```
# Utilização
 No terminal digite o comando abaixo para adicionar o pacote do entity framework e depois execute o algoritimo principal.
```Code
dotnet add package Microsoft.EntityFrameworkCore.SqlServer

dotnet run
```
