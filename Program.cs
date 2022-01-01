using Forum.Data;

namespace Forum
{
    class Program
    {
        static void Main(string[] args)
        {
            using var context = new ForumDataContext();
        }
    }
}