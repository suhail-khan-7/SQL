-- Project title :- Netflix data analysis SQL project.

-- Analysis-1
-- 1. Count how many titles are available for each type.

select type,count(*) as total_title
from titles
group by type

-- 2. Find the average IMDb score of all 'MOVIE' titles.

select type,title,avg(imdb_score) as avr_score
from titles
group by type,title
having type='movie'

-- 3. List titles along with the total number of votes, sorted by most votes.

select title,sum(imdb_votes) as total_votes
from titles
group by title
order by total_votes desc

-- 4. Join titles and credits to list the first 10 title-character pairs.

select top(10) c.character,t.title
from credits as c
inner join titles as t
on c.id=t.id

-- 5. How many titles does each genre appear in?

select genres,count(title) as count_of_title_appear
from titles
group by genres
order by count_of_title_appear desc

-- 6. Find titles released between 2000 and 2010 with an IMDb score above 7.

select title,release_year,imdb_score
from titles
where release_year between 2000 and 2010 and imdb_score>7
order by imdb_score 

-- 7. Show the number of seasons for each title with more than 1 season.

select title,seasons
from titles
where seasons>1
order by seasons 

-- 8. Show top 5 most popular titles based on tmdb_popularity.

select top(5) title,tmdb_popularity
from titles
order by tmdb_popularity desc

--Analysis-2
-- 1. List the top 5 actors who played in the most titles.

select top(5) c.name,count(*) as total_count_of_title
from credits as c
inner join titles as t
on c.id=t.id
group by c.name 
order by total_count_of_title desc

-- 2. List titles and the number of people credited in each.

select t.title,count(c.name) as total_num_of_people_credit
from credits as c
inner join titles as t
on c.id=t.id
group by t.title 
order by total_num_of_people_credit desc

-- 3. Find all titles with both an IMDb score above 7 and a TMDB score above 70(7). (it's 7 not 70)

select title,imdb_score,tmdb_score
from titles
where imdb_score>7 and tmdb_score>7

-- 4. Which production countries have produced the most titles?

select production_countries,count(*) as total_count_of_title_country_have_produced
from titles
group by production_countries
order by  total_count_of_title_country_have_produced desc

-- 5. Show the average runtime by title type.

select type,avg(runtime) as average_runtime_in_each_title_type
from titles
group by type

-- 6. List titles where the word “love” appears in the title.

select *
from titles
where title like '%love%'

-- 7. Find top 5 directors by number of titles directed.

select c.name,c.role,count(t.title) as total_count_of_title_directed
from credits as c
left join titles as t
on c.id=t.id
group by c.name,c.role
having c.role in ('director')
order by total_count_of_title_directed desc

-- 8. Show the most recent title each person acted in.*

select c.name,t.release_year,t.title
from credits as c
inner join titles as t
on t.id=c.id
where t.release_year=(
select max(t2.release_year)
from credits as c2
join titles as t2
on c2.id=t2.id
where c2.name=c.name)

--Analysis-3
-- 1. Find titles with IMDb scores higher than the average IMDb score of all titles.

select title,imdb_score
from titles
where imdb_score>(select avg(imdb_score)
from titles)

-- 2. List the top 5 most common roles from the credits table using a CTE.

with role_count as (select role,count(*) as role_count 
from credits
group by role)

select top(1)*
from role_count
order by role_count desc

-- 3. Find the top 3 longest movies by runtime using a subquery.

select top(3) title,type,runtime
from titles
where type='movie'
order by runtime desc

-- 4. Show titles and their IMDb score ranks (1 = highest) using a CTE.

with rank_title as (select *,ROW_NUMBER() over (order by imdb_score desc) as rank
from titles)

select *
from rank_title
where rank=1

-- 5. List all people who acted in titles released in 2020.

select c.name,t.title,t.release_year
from credits as c
left join titles as t
on c.id=t.id
where t.release_year=2020 and role='actor'

-- 6. Get average IMDb score per type and show only types with average score > 7 using a CTE.

with average_imdb_score as (select type, avg(imdb_score) as average_imdb
from titles
group by type)

select *
from average_imdb_score
where average_imdb>7


-- 7. Find titles that have more than 3 people credited.

select t.title,count(c.person_id) as count_of_name
from credits as c
left join  titles as t
on c.id=t.id
group by title
having count(c.name)>3

-- 8. List each actor and the number of unique titles they appeared in using CTE.

WITH actor_titles AS (
    SELECT c.name,COUNT(DISTINCT t.title) AS unique_title_count
    FROM credits AS c
    JOIN titles AS t
        ON c.id = t.id
    WHERE c.role = 'ACTOR'
    GROUP BY c.name
)
SELECT *
FROM actor_titles
ORDER BY unique_title_count DESC
