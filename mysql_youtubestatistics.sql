

#1 create a new column date_created to contain the created_year, created_month and created_date
set sql_safe_updates = 0;

use youtube_analysis;
alter table youtubestatistics add column date_created date not null;

update youtubestatistics 
set date_created = (concat(created_year, '-', 
case created_month
when 'jan' then 1
when 'mar' then 3
when 'apr' then 4
when 'may' then 5
when 'jun' then 6
when 'jul' then 7
when 'aug' then 8
when 'sep' then 9
when 'oct' then 10
when 'nov' then 11
when 'dec' then 12
else 2
end
,'-', created_date));

alter table youtubestatistics drop column created_month;
alter table youtubestatistics drop column created_year;
alter table youtubestatistics drop column created_date;

#2 what are the top countries in the youtube space in terms of uploads, views, earning and subscribers

with pct_pay as(
select 
country,
sum(subscribers) as total_subscribers, 
sum(`video views`) as total_video_views, 
sum(uploads) as total_uploads, 
sum(highest_yearly_earnings) as total_earnings,
count(Youtuber) as num_youtubers
from youtubestatistics
group by country
order by total_earnings desc)

#3 what is the percentage pay per country

select 
round(sum(case when country = 'United States' then total_earnings end) / sum(total_earnings) *100, 4)  as pct_earnings_usa,
round(sum(case when country = 'India' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_india,
round(sum(case when country = 'South Korea' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_korea,
round(sum(case when country = 'Brazil' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_brazil,
round(sum(case when country = 'Pakistan' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_pakistan,
round(sum(case when country = 'United Kingdom' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_uk,
round(sum(case when country = 'Argentina' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_argentina,
round(sum(case when country = 'Russia' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_russia,
round(sum(case when country = 'United Arab Emirates' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_uae,
round(sum(case when country = 'Indonesia' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_indonesia,
round(sum(case when country = 'Colombia' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_colombia,
round(sum(case when country = 'Turkey' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_turkey,
round(sum(case when country = 'Japan' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_japan,
round(sum(case when country = 'Philippines' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_phillipines,
round(sum(case when country = 'Mexico' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_mexico,
round(sum(case when country = 'Thailand' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_thailand,
round(sum(case when country = 'Germany' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_germany,
round(sum(case when country = 'Canada' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_canada,
round(sum(case when country = 'Italy' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_italy,
round(sum(case when country = 'Latvia' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_latvia,
round(sum(case when country = 'Spain' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_spain,
round(sum(case when country = 'Ukraine' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_ukrain,
round(sum(case when country = 'Sweden' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_sweden,
round(sum(case when country = 'Saudi Arabia' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_saudi,
round(sum(case when country = 'Australia' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_australia,
round(sum(case when country = 'Jordan' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_jordan,
round(sum(case when country = 'Vietnam' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_vietnam,
round(sum(case when country = 'Barbados' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_barbados,
round(sum(case when country = 'Chile' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_chile,
round(sum(case when country = 'Kuwait' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_kuwait,
round(sum(case when country = 'Netherlands' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_netherlands,
round(sum(case when country = 'Malaysia' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_malaysia,
round(sum(case when country = 'Singapore' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_singapore,
round(sum(case when country = 'France' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_france,
round(sum(case when country = 'Egypt' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_egypt,
round(sum(case when country = 'Ecuador' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_ecuador,
round(sum(case when country = 'Switzerland' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_switzerland,
round(sum(case when country = 'El Salvador' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_el_salvador,
round(sum(case when country = 'China' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_china,
round(sum(case when country = 'Venezuela' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_venezuela,
round(sum(case when country = 'samoa' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_samoa,
round(sum(case when country = 'cuba' then total_earnings end) / sum(total_earnings)*100, 4)  as pct_earnings_cuba
from pct_pay;

#5 what are the top 10 channel types according to views

select 
channel_type,
sum(`video views`) as total_views
from youtubestatistics
group by channel_type
order by total_views desc
limit 10;





