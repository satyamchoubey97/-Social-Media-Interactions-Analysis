-- 1. Identify Users by Location

select user_id , location from post order by user_id;

-- 2.Determine the Most Followed Hashtags

-- write a query to list the top 5 most-followed hashtags on the platform.
 -- Hint: Join relevant tables to calculate the total follows for each hashtag.

select    h.hashtag_id,h.hashtag_name, count(hf.hashtag_id) as follow from hashtags h left join hashtag_follow hf
 on hf.hashtag_id=h.hashtag_id  group by h.hashtag_id order by follow  desc LIMIT 5
 
 
  -- 3.Find the Most Used Hashtags
  
  
  SELECT hashtag_name, usage_count
FROM (
    SELECT h.hashtag_name, COUNT(ph.post_id) AS usage_count
    FROM Hashtags h
    JOIN PostHashtags ph ON h.hashtag_id = ph.hashtag_id
    GROUP BY h.hashtag_name
) AS hashtag_counts
ORDER BY usage_count DESC
LIMIT 10;
  
 -- 4. Identify the Most Inactive User
 
     select username, user_id from users where user_id not in (select user_id from post);
 
 -- 5.Identify the Posts with the Most Likes
 select  post_id ,count(user_id) as likes from post_likes group by post_id  order by  likes desc Limit 1 ;
 

-- 6.Calculate Average Posts per User
 select user_id,  AVG(post_id) from post group by user_id ;
 
 -- 7.Track the Number of Logins per User
 
 
 select u.user_id ,count(l.login_id) from users u left join login l on u.user_id = l.user_id group by u.user_id ;
 
 
 -- 8. Identify a User Who Liked Every Single Post
 



SELECT DISTINCT user_id, COUNT(post_id) AS mn
FROM post_likes
GROUP BY user_id
HAVING COUNT(post_id) = (SELECT COUNT(DISTINCT post_id) FROM post_likes);



-- 9.Find Users Who Never Commented

select user_id,username from users where user_id not in (select user_id from comments);


 -- 10. Identify a User Who Commented on Every Post
SELECT DISTINCT user_id, COUNT(post_id) AS mn
FROM post_likes
GROUP BY user_id
HAVING COUNT(post_id) = (SELECT COUNT(DISTINCT post_id) FROM post_likes);


-- 11.dentify Users Not Followed by Anyone

select user_id from users u where not  exists (select follower_id from follows f where f.follower_id = u.user_id);

 -- 12. Identify Users Who Are Not Following Anyone
 select user_id from users u where not  exists (select followee_id from follows f where f.followee_id = u.user_id);
 
 -- 13. Find Users Who Have Posted More than 5 Times
 
select user_id , count(post_id) from post group by user_id having  count(post_id) >5;

 -- 14. Identify Users with More than 40 Followers

select distinct follower_id, count(follower_id) as followers from follows group by follower_id order by followers desc  ;

  -- 15. Search for Specific Words in Comments
  
  SELECT comment_id, comment_text
FROM comments
WHERE comment_text LIKE '%good%'
   OR comment_text LIKE '%beautiful%';

  
-- 16.Identify the Longest Captions in Posts
SELECT post_id, caption, LENGTH(caption) AS caption_length
FROM post
ORDER BY LENGTH(caption) DESC
LIMIT 1;






