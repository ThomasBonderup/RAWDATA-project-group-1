-- Find coplayers
create or replace view co_actor_data as
select title_principals.tconst, name.nconst, name.primaryname
from name, title_principals;

select nconst, primaryname
from co_actor_data
where tconst in (select tconst
from co_actor_data
where primaryname like 'Lauren Bacall'
group by tconst
order by count(primaryname))
limit 12;﻿