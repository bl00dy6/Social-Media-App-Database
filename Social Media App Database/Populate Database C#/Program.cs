

// See https://aka.ms/new-console-template for more information
using ConsoleApp1.SqlConnect;
using ConsoleApp1.SqlConnect.Tabele;
using Newtonsoft.Json;

Console.WriteLine("eat(); code(); //sleep(); repeat();");

List<string> religii = new List<string>()
{
    "orthodox",
    "catholic",
    "muslim",
    "budhism",
    "martorii lu' Iehova"
};

Random rnd = new Random();
Byte[] b = new Byte[15];
rnd.NextBytes(b);
using (var dbContext = new AdiDbContext())
{
    #region insert accounts

    //List<account> uniqueAccount = new List<account>();

    //for (int i = 0; i < 5000; i++)
    //{
    //    rnd.NextBytes(b);
    //    string localEmail = Faker.Internet.Email();

    //    var user = new account()
    //    {
    //        reg_email = localEmail,
    //        username = localEmail.Substring(0, localEmail.IndexOf('@')),
    //        password = b.ToArray(),
    //        created_at = DateTime.Now.AddMinutes(-Faker.RandomNumber.Next(555000))

    //    };

    //    if (uniqueAccount.Any())
    //    {
    //        if (!uniqueAccount.Any(m => m.reg_email == user.reg_email || m.username == user.username))
    //        {
    //            uniqueAccount.Add(user);
    //        }
    //    }
    //    else
    //    {
    //        uniqueAccount.Add(user);
    //    }
    //}

    //dbContext.accounts.AddRange(uniqueAccount);
    //dbContext.SaveChanges();

    #endregion


    #region insert info for accounts
    //var conturi_create = dbContext.accounts.ToList();

    //foreach (var item in conturi_create)
    //{
    //    string parag = Faker.Lorem.Paragraph();

    //    var user_info = new info()
    //    {
    //        user_id = item.user_id,
    //        first_name = item.username.Trim().IndexOfAny(new char[] { '.', '_' }) > 1 ?
    //           (item.username.Substring(0, item.username.Trim().IndexOfAny(new char[] { '.', '_' })).Substring(0, 1).ToUpper() + item.username.Substring(0, item.username.Trim().IndexOfAny(new char[] { '.', '_' })).Substring(1))
    //           : (item.username.Substring(0, 1).ToUpper() + item.username.Substring(1)),
    //        last_name = item.username.Trim().IndexOfAny(new char[] { '.', '_' }) > 0 ?
    //           (item.username.Substring(item.username.Trim().IndexOfAny(new char[] { '.', '_' }) + 1).Substring(0, 1).ToUpper() + item.username.Substring(item.username.Trim().IndexOfAny(new char[] { '.', '_' }) + 1).Substring(1))
    //           : Faker.Name.Last(),
    //        middle_name = rnd.Next(100) > 50 ? Faker.Name.Middle() : null,
    //        public_email = rnd.Next(100) > 50 ? Faker.Internet.Email() : null,
    //        address = rnd.Next(100) > 30 ? Faker.Address.StreetAddress() : null,
    //        birth_date = DateTime.Now.AddDays(-rnd.Next(3650, 36500)).Date,
    //        city = rnd.Next(100) > 35 ? Faker.Address.City() : null,
    //        gender = rnd.Next(100) > 50 ? 'M' : 'F',
    //        hometown = rnd.Next(100) > 50 ? Faker.Address.City() : null,
    //        intro = rnd.Next(100) > 80 ? (parag.Length > 101 ? parag.Substring(0, 101) : parag) : null,
    //        phone = rnd.Next(100) > 65 ? Faker.Phone.Number() : null,
    //        religion = rnd.Next(100) > 70 ? religii[rnd.Next(5)] : null,
    //        state = rnd.Next(100) > 20 ? Faker.Address.UsState() : null,
    //        website = rnd.Next(100) > 80 ? Faker.Internet.Url() : null
    //    };

    //    dbContext.info.Add(user_info);


    //}
    //dbContext.SaveChanges();
    #endregion


    #region Insert posts

    //var users = dbContext.accounts.ToList();
    //int countusers = users.Count;


    //List<posts> _cahedPosts = new List<posts>();

    //for (int i = 0; i < 35000; i++)
    //{
    //    string desc = Faker.Lorem.Paragraph();
    //    string title = Faker.Lorem.Sentence();
    //    posts postarea = new posts()
    //    {
    //        description = rnd.Next(100) > 65 ? (desc.Length > 100 ? desc.Substring(0, 100) : desc) : null,
    //        post_added = DateTime.Now.AddMinutes(-rnd.Next(5256000)),
    //        title = title.Length > 30 ? title[..30] : title,
    //        user_id = users[rnd.Next(countusers)].user_id,
    //        shared_post_id = null
    //    };



    //    dbContext.posts.Add(postarea);

    //}

    //dbContext.SaveChanges();

    //var existingposts = dbContext.posts.ToList();
    //int countposts = existingposts.Count;

    //for (int i = 0; i < 7000; i++)
    //{
    //    var postRandom = existingposts[rnd.Next(countposts)];
    //    while (postRandom == existingposts[existingposts.Count - 1])
    //    {
    //        postRandom = existingposts[rnd.Next(existingposts.Count)];
    //    }
    //    var postTpUpdate = existingposts[rnd.Next(countposts)];
    //    while (postTpUpdate.post_id < postRandom.post_id)
    //    {
    //        postTpUpdate = existingposts[rnd.Next(existingposts.Count)];
    //    }
    //    postTpUpdate.shared_post_id = postRandom.post_id;
    //    postTpUpdate.post_added = postRandom.post_added.AddMinutes(rnd.Next(5, 14000));

    //    dbContext.posts.Update(postTpUpdate);
    //}

    //dbContext.SaveChanges();

    #endregion

    #region post_likes

    //var users = dbContext.accounts.ToList();
    //var posts = dbContext.posts.ToList();

    //Dictionary<int, List<int>> postarCurente = new Dictionary<int, List<int>>();

    //for (int i = 0; i < 100000; i++)
    //{
    //    var postarRandom = posts[rnd.Next(posts.Count)];
    //    var userRandom = users[rnd.Next(users.Count)];

    //    if (postarCurente.ContainsKey(postarRandom.post_id) && postarCurente[postarRandom.post_id].Any())
    //        while (postarCurente[postarRandom.post_id].Contains(userRandom.user_id))
    //            userRandom = users[rnd.Next(users.Count)];

    //    post_likes like = new post_likes()
    //    {
    //        user_id = userRandom.user_id,
    //        post_id = postarRandom.post_id,
    //        like_date = postarRandom.post_added.AddHours(rnd.Next(1234))
    //    };

    //    if (!postarCurente.ContainsKey(postarRandom.post_id))
    //    {
    //        postarCurente.Add(postarRandom.post_id, new List<int> { userRandom.user_id });

    //    }
    //    else
    //    {
    //        postarCurente[postarRandom.post_id].Add(userRandom.user_id);
    //    }

    //    dbContext.post_Likes.Add(like);
    //}

    //dbContext.SaveChanges();

    #endregion
    #region insert comments
    //var current_posts = dbContext.posts.ToList();
    //var current_users = dbContext.accounts.ToList();
    //Dictionary<int, List<int>> CurrPosts = new Dictionary<int, List<int>>();

    //for (int i = 0; i < 70000; i++)
    //{
    //    var RandPost = current_posts[rnd.Next(current_posts.Count)];
    //    var Randuser = current_users[rnd.Next(current_users.Count)];

    //    string comment = Faker.Lorem.Paragraph();
    //    comments addcomments = new comments()
    //    {
    //        post_id = RandPost.post_id,
    //        user_id = Randuser.user_id,
    //        comment = comment.Length > 300 ? comment.Substring(0, 300) : comment,
    //        comment_added = DateTime.Now.AddMinutes(-rnd.Next(525600))
    //    };
    //    dbContext.comments.Add(addcomments);
    //}
    //dbContext.SaveChanges();

    //var list_comments = dbContext.comments.ToList();
    //for (int i = 0; i < list_comments.Count / 2; i++)
    //{
    //    var rand_comment = list_comments[rnd.Next(list_comments.Count)];
    //    while (rand_comment == list_comments[list_comments.Count - 1])
    //    {
    //        rand_comment = list_comments[rnd.Next(list_comments.Count)];
    //    }
    //    var updated_comment = list_comments[rnd.Next(list_comments.Count)];
    //    while (updated_comment.comment_id < rand_comment.comment_id)
    //    {
    //        updated_comment = list_comments[rnd.Next(list_comments.Count)];
    //    }
    //    updated_comment.reply_to_comment_id = rand_comment.comment_id;
    //    updated_comment.post_id = rand_comment.post_id;
    //    dbContext.comments.Update(updated_comment);
    //}
    //dbContext.SaveChanges();
    #endregion
    #region insert photos
    //var all_posts = dbContext.posts.ToList();

    //for (int i = 0; i < Math.Floor(all_posts.Count / 1.5); i++)
    //{
    //    string pht_url = Faker.Internet.Url();
    //    var rnd_post = rnd.Next(all_posts.Count);
    //    photos pht_tbl = new photos()
    //    {
    //        post_id = all_posts[rnd_post].post_id,
    //        photo_url = pht_url
    //    };
    //    dbContext.photos.Add(pht_tbl);
    //}
    //dbContext.SaveChanges();

    #endregion
    #region insert videos
    //var all_posts = dbContext.posts.ToList();

    //for (int i = 0; i < Math.Floor(all_posts.Count / 1.5); i++)
    //{
    //    string vid_url = Faker.Internet.Url();
    //    var rnd_post = rnd.Next(all_posts.Count);
    //    videos vid_row = new videos()
    //    {
    //        post_id = all_posts[rnd_post].post_id,
    //        video_url = vid_url
    //    };
    //    dbContext.videos.Add(vid_row);
    //}
    //dbContext.SaveChanges();
    #endregion
    #region insert friends
    var all_users = dbContext.accounts.ToList();
    List<int> statusuri = new List<int>() { 1, 2, 3, 4 };
    List<string> statusuriActive = new List<string>();

    foreach (var user in all_users)
    {
        int numarRandomDePrieteni = rnd.Next(500);
        for (int i = 0; i < numarRandomDePrieteni; i++)
        {
            if (!statusuriActive.Any())
            {
                friends friendStatus = new friends()
                {
                    user_id = user.user_id,
                    friend_id = all_users[rnd.Next(all_users.Count)].user_id,
                    friend_date = DateTime.Now.AddMinutes(-rnd.Next(525600)),
                    status_id = statusuri[rnd.Next(4)]

                };
                statusuriActive.Add(friendStatus.user_id.ToString() + friendStatus.friend_id.ToString());
                statusuriActive.Add(friendStatus.friend_id.ToString() + friendStatus.user_id.ToString());


                dbContext.friends.Add(friendStatus);
            }else
            {
                bool cautaPrietenNow = true;

                while (cautaPrietenNow)
                {
                    var prieten = all_users[rnd.Next(all_users.Count)];
                    string verificaPrietenia1 = user.user_id.ToString() + prieten.user_id.ToString();
                    string verificaPrietenia2 = prieten.user_id.ToString() + user.user_id.ToString();

                    if (!statusuriActive.Contains(verificaPrietenia1) || !statusuriActive.Contains(verificaPrietenia2))
                    {
                        friends friendStatus = new friends()
                        {
                            user_id = user.user_id,
                            friend_id = prieten.user_id,
                            friend_date = DateTime.Now.AddMinutes(-rnd.Next(525600)),
                            status_id = statusuri[rnd.Next(4)]

                        };
                        statusuriActive.Add(friendStatus.user_id.ToString() + friendStatus.friend_id.ToString());
                        statusuriActive.Add(friendStatus.friend_id.ToString() + friendStatus.user_id.ToString());


                        dbContext.friends.Add(friendStatus);

                        cautaPrietenNow = false;
                    }
                }

            }
        }

        dbContext.SaveChanges();
    }


    #endregion
}