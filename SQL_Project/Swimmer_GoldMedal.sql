--Scenario :- we need to find player with no of gold medals won by them only for players who won only gold medals.

select * from events;

--Method 1
select Gold,count(Gold)
from events
where Gold not in (select silver
                from events
                union
                select Bronze
                from events
                )
group by Gold;


--Method 2
select * from events;

with cte as(
            select Gold as player_name, 'Gold' as medal_type
            from events
            union all
            select silver as player_name,'Silver' as medal_type
            from events
            union all
            select Bronze as player_name,'Bronze' as medal_type
            from events
            )          
select player_name,count(medal_type)
from cte
group by player_name
having count(distinct medal_type)=1 and max(medal_type)='Gold';
                
