## Data
   Possui o contexto do banco de dados em memória, a conexão com o banco de dados Forum e o contexto de mapeamento.
```Code
   using Forum.Data.Mappings;
   using Forum.Models;
   using Microsoft.EntityFrameworkCore;

   namespace Forum.Data
   {

       public class ForumDataContext : DbContext
       {

           public DbSet<Category>? Categories { get; set; }


           public DbSet<Post>? Posts { get; set; }



           public DbSet<User>? Users { get; set; }

           protected override void OnConfiguring(DbContextOptionsBuilder options)
               =>options.UseSqlServer("Server=localhost,1433;Database=Forum;User ID=sa;Password=1q2w3e4r@#$;Trusted_Connection=False; TrustServerCertificate=True;");

            protected override void OnModelCreating(ModelBuilder modelBuilder)
           {
               modelBuilder.ApplyConfiguration(new CategoryMap());
               modelBuilder.ApplyConfiguration(new UserMap());
               modelBuilder.ApplyConfiguration(new PostMap());
           }


       }
    }
```
## Mappings
  Possui o contexto de mapeamento das tabelas Category,User,Post do banco de dados com as propriedades,constrains,indices,relacionamentos etc.
```Code
   using Forum.Models;
   using Microsoft.EntityFrameworkCore;
   using Microsoft.EntityFrameworkCore.Metadata.Builders;

   namespace Forum.Data.Mappings
   {
       public class CategoryMap : IEntityTypeConfiguration<Category>
       {
           public void Configure(EntityTypeBuilder<Category> builder)
           {
               // Tabela
               builder.ToTable("Category");

               // Chave Primária
               builder.HasKey(x => x.Id);

               // Identity
               builder.Property(x => x.Id)
                   .ValueGeneratedOnAdd()
                   .UseIdentityColumn();

               // Propriedades
               builder.Property(x => x.Name)
                   .IsRequired()
                   .HasColumnName("Name")
                   .HasColumnType("NVARCHAR")
                   .HasMaxLength(80);

               builder.Property(x => x.Slug)
                   .IsRequired()
                   .HasColumnName("Slug")
                   .HasColumnType("VARCHAR")
                   .HasMaxLength(80);

               // Índices
               builder
                   .HasIndex(x => x.Slug, "IX_Category_Slug")
                   .IsUnique();
           }
       }
   }
```

## Models
  Possui o contexto de modelos das tabelas.
```Code
   using System.Collections.Generic;

   namespace Forum.Models
   {
       public class Category
       {
           public int Id { get; set; }
           public string? Name { get; set; }
           public string? Slug { get; set; }

           public IList<Post>? Posts { get; set; }
       }
   }
```

# Utilização
 No terminal digite o comando abaixo para adicionar o pacote do entity framework e depois execute o algoritimo principal.
```Code
dotnet add package Microsoft.EntityFrameworkCore.SqlServer
dotnet add  package Microsoft.EntityFrameworkCore.Design
dotnet run
```
