Average Steps Taken at different hours in the day

Select
Distinct ActivityHour as Time_of_day,
sum(StepTotal) as Steps
from hourlysteps_merged
Group by Time_of_day
Order by Steps Desc;

Average Calories burned  at different hours in the day

Select
ActivityHour as Time_in_the_day,
round (avg (Calories)) as Calories
from hourlycalories_merged
Group by ActivityHour
Order By Calories Desc;


Average Calories burned and steps taken at different hours in the day

select
(dailysteps_merged.UserId) as Users, 
round (avg (dailycalories_merged.Calories)) as Calories,
round (avg (dailysteps_merged.StepTotal)) as Steps
from dailycalories_merged
join
dailysteps_merged
on
dailycalories_merged.Id = dailysteps_merged.Id
Group by Users;

Spread of Activity and Inactivity on A Daily basis

select dayname(ActivityDate) as day_of_week,
round(avg(LightlyActiveMinutes)) as average_lightlyactive_minutes,
round(avg(FairlyActiveMinutes)) as average_fairlyactive_minutes,
round(avg(VeryActiveMinutes))as average_veryactive_minutes,
round(avg(SedentaryMinutes)) as average_inactive_minutes
from dailyactivity_merged
group by day_of_week
order by 'day_of_week';

Average Steps Taken on each day of the week

select
dayname(ActivityDay) as day_of_week,
round (avg (StepTotal)) as Steps
from dailysteps_merged
Group by day_of_week;

Daily Step Count Classification per user

select 
distinct UserId as Users, 
round(avg(TotalSteps)) as Average_total_steps,
CASE
 When round(avg(TotalSteps)) < 10000 THEN 'Not Enough Steps'
    When round(avg(TotalSteps)) = 10000 THEN 'Enough Steps'
    Else 'That is Enough Steps'
End as avg_user_steps
from dailyactivity_merged
group by Users;

Daily Sleep hours Classification per user

select 
distinct UserId AS Users,
round (avg(TotalMinutesAsleep) / 60) AS Average_sleep_time_in_hours,
CASE
 When round(avg(TotalMinutesAsleep) / 60) BETWEEN 1 AND 6 THEN 'insufficient sleep'
 When round(avg(TotalMinutesAsleep) / 60) BETWEEN 7 AND 8 THEN 'optimal sleep'
 else 'Okay, Sleeping Beauty'
End AS Sleep_Time_Groupings
From  fit_bit_data.sleepday_merged
Group by Users;

Average Sleep Hours Per User

select 
distinct UserId as Users,
round(AVG(TotalMinutesAsleep)/60) as Average_sleep_time_in_hours
FROM fit_bit_data.sleepday_merged
Group by Users;

Daily Time in Bed Vs Time Asleep in Minutes

select 
dayname(SleepDay) as day_of_week,
round (avg(TotalMinutesAsleep), 2) as Time_Asleep,
round (avg(TotalTimeInBed), 2) as Time_in_bed
from sleepday_merged
Group by day_of_week;







