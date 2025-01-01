create table social_media_usage(
	User_ID varchar(50),
	App varchar(50),
	Daily_Minutes_Spent INT,
	Posts_Per_Day INT,
	Likes_Per_Day INT,
	Follows_Per_Day INT
);

copy social_media_usage from 'C:\Program Files\PostgreSQL\16\data\Data_copy\social_media_usage.csv'
delimiter ','
csv header;

--Basic Data Overview

-- Number of users per platform
select app,count(distinct user_id) no_of_users
from social_media_usage
group by app
order by no_of_users desc;

-- Average daily minutes spent on each platform
select app,round(avg(daily_minutes_spent),2) time_spent
from social_media_usage
group by app
order by time_spent desc;

-- Total posts per day per platform
select app,sum(posts_per_day) total_posts_per_day
from social_media_usage
group by app
order by total_posts_per_day desc;

--Engagement Metrics Analysis

-- Likes-to-post ratio per user
select * from social_media_usage

select user_id,(likes_per_day/posts_per_day) as likes_to_post_ratio
from social_media_usage
where posts_per_day>0;

-- Time-to-post ratio per user
select user_id,(daily_minutes_spent/posts_per_day) as time_to_post_ratio
from social_media_usage
where posts_per_day>0;

-- Get features to use for clustering (Likes-to-Post Ratio, Time-to-Post Ratio)
select User_ID,(Likes_Per_Day / Posts_Per_Day) as Likes_to_Post_Ratio,
(Daily_Minutes_Spent / Posts_Per_Day) as Time_to_Post_Ratio
from social_media_usage
where Posts_Per_Day > 0;

-- Engagement comparison by platform
select app,round(avg(Likes_Per_Day),2) Avg_likes,
round(avg(Posts_Per_Day),2) avg_posts,
round(avg(Follows_Per_Day),2) avg_follows
from social_media_usage
group by app;

-- Correlation between daily time spent and follower growth
select app,round(avg(daily_minutes_spent),2) avg_daily_minutes,
round(avg(Follows_Per_Day),2) avG_follows_per_day
from social_media_usage
group by app
order by avg_daily_minutes desc;

-- Find users who use more than one platform
select user_id,count(distinct app) as platform_count
from social_media_usage
group by user_id
having count(distinct app)>1;




























