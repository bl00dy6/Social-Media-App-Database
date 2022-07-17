using ConsoleApp1.SqlConnect.Tabele;
using Microsoft.EntityFrameworkCore;


namespace ConsoleApp1.SqlConnect
{
    public class AdiDbContext : DbContext
    {

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer(@"Server=localhost;Database=SocialMediaApp;Trusted_Connection=True;");
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<post_likes>()
                .HasKey(m => new { m.user_id, m.post_id });

            modelBuilder.Entity<photos>()
               .HasKey(m => new { m.post_id, m.photo_url });

            modelBuilder.Entity<videos>()
               .HasKey(m => new { m.post_id, m.video_url });

            modelBuilder.Entity<friends>()
                .HasKey(m => new { m.user_id, m.friend_id });
        }


        public DbSet<account> accounts { get; set; }
        public DbSet<info> info { get; set; }
        public DbSet<posts> posts { get; set; }
        public DbSet<post_likes> post_Likes { get; set; }
        public DbSet<comments> comments { get; set; }
        public DbSet<photos> photos { get; set; }
        public DbSet<videos> videos { get; set; }
        public DbSet<friends> friends { get; set; }
    }
}
