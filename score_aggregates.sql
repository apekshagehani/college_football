with punting_cte as (Select 
	"Team",
	"Year",                     
    sum("Punts") as "Punting_total_Punts",
    sum("Avg") as "Punting_total_Avg",
    sum( case when  "In20" = '--' then 0 when "In20" = '' then 0 else cast( "In20" as DECIMAL)  end   ) as "punting_total_In20",
	sum("Blk") as "punting_total_Blocked"   ,
	sum(case when  "Net" = '--' then 0 else cast( "Net" as DECIMAL) end  ) as "punting_total_Net" ,               
	sum( case when  "TB" = '--' then 0 else Cast( "TB" AS DECIMAL) end) as "Punting_total_TB",
    sum( case when  "Ret" = '--' then 0  when "Ret"='' then 0 else Cast( "Ret" AS DECIMAL) END  ) as "Punting_total_Returns",
    sum( case when  "RYds" = '--' then 0  when "RYds"='' then 0  else Cast( "RYds" AS DECIMAL) END ) as "Punting_total_ReturnYards"    ,           
    sum(  Cast( "Yds" AS DECIMAL)  ) as "Punting_total_Yards" ,      
    sum( case when  "FC" = '--' then 0  when "FC"='' then 0  else Cast( "FC" AS DECIMAL)  end ) as "Punting_total_FairChance"      ,
	max( case when  "Lg" = '--' then 0  when "Lg"='' then 0  else  Cast( "Lg" AS DECIMAL) end  ) as "Punting_max_Lg"     
FROM dvproject2
where "Stat_Type"  = 'Punting'                   
group By "Team","Year" ),
scoring_cte as (Select 
	"Team",
	"Year",                     
    sum("Tot") as "Scoring_total_Tot",
	sum("Pts") as "Scoring_total_pts",
	sum("R") as "Scoring_total_Rushing_touchdown",
    sum("P") as "Scoring_total_P",
	sum("KR") as "Scoring_total_kr",	
	sum("PR") as "Scoring_total_PR",
	sum("IR") as "Scoring_total_IR",
	sum("FR") as "Scoring_total_FR",
	sum("BK") as "Scoring_total_BK",	  
	sum("BP") as "Scoring_total_BP",
	sum("FGR") as "Scoring_total_FGR",
	sum("Conv") as "Scoring_total_Conv",
	sum("Saf") as "Scoring_total_Saf"
	--sum( case when  "PAT" = '--' then 0 when "PAT" = '' then 0 else cast( "PAT" as DECIMAL)  end   ) as "Scoring_total_PAT",
	--sum( case when  "FG" = '--' then 0 when "FG" = '' then 0 else cast( "FG" as DECIMAL)  end   ) as "Scoring_total_FG"              
	
FROM dvproject2
where "Stat_Type"  = 'Scoring'                   
group By "Team","Year" ),

passing_cte as (Select 
	"Team",
	"Year",                     
    sum("Cmp") as "passing_total_Cmp",
	sum("Pct") as "passingtotal_Pct",
	sum("YPA") as "passing_total_YPA",
	sum("TD%") as "passing_total_td_percent",	
	sum("Int%") as "passing_total_Int_percent",
	sum("Int") as "passing_total_Int",
	sum("Att") as "passing_total_Att",
    sum("Rate") as "passing_total_Rate",
	sum("Yds") as "passing_total_Yds",	  
	sum("TD") as "passing_total_TD",
    sum( case when  "Loss" = '--' then 0 when "Loss" = '' then 0 else cast( "Loss" as DECIMAL)  end   ) as "Passing_total_Loss",
	sum( case when  "TB" = '--' then 0 when "TB" = '' then 0 else cast( "TB" as DECIMAL)  end   ) as "Passing_total_TB",
	sum( case when  "Sack" = '--' then 0 when "Sack" = '' then 0 else cast( "Sack" as DECIMAL)  end   ) as "Passing_total_Sac"   ,
	sum( case when  "Lg" = '--' then 0 when "Lg" like '%t' then cast(trim( TRAILING 't' from "Lg") as decimal)  when  "Lg" = '' then 0  else cast( "Lg" as DECIMAL)  end   ) as "Passing_total_Lg"   
FROM dvproject2
where "Stat_Type"  = 'Passing'                   
group By "Team","Year" ),

punt_return_cte as (Select 
	"Team",
	"Year",                     
    sum("Num") as "punt_return_total_Num",
	sum("Yds") as "punt_return_total_Yds",
	sum("Avg") as "punt_return_total_Avg",
	sum("TD") as "punt_return_total_td"	,
	sum( case when  "FC" = '--' then 0 when "FC" = '' then 0 else cast( "FC" as DECIMAL)  end   ) as "punt_return_total_FC",
	sum( case when  "Lg" = '--' then 0 when "Lg" like '%t' then cast(trim( TRAILING 't' from "Lg") as decimal)  when  "Lg" = '' then 0  else cast( "Lg" as DECIMAL)  end   ) as "punt_return_total_Lg"   
FROM dvproject2
where "Stat_Type"  = 'Punt Return'        
group By "Team","Year" ),  
receiving_cte as (Select 
	"Team",
	"Year",                     
    sum("Yds") as "receiving_total_Yds",
	sum("Avg") as "receiving_total_Avg",
    sum("TD") as "receiving_total_TD",
    sum("Rec") as "receiving_total_Rec",	
	sum( case when  "Lg" = '--' then 0 when "Lg" like '%t' then cast(trim( TRAILING 't' from "Lg") as decimal)  when  "Lg" = '' then 0  else cast( "Lg" as DECIMAL)  end   ) as "receiving_total_Lg"   
FROM dvproject2
where "Stat_Type"  = 'Receiving'        
group By "Team","Year" ),

kickoff_cte as (Select 
	"Team",
	"Year",             
    sum("Yds") as "kickoff_total_Yds",
    sum("Yds") as "kickoff_total_Yds",
	sum("Avg") as "kickoff_total_Avg",
    sum("Num") as "kickoff_total_Num",
    sum( case when  "TB" = '--' then 0 else Cast( "TB" AS DECIMAL) end) as "kickoff_total_TB",
    sum("OB") as "kickoff_dtotal_OB",
    sum( case when  "Ret" = '--' then 0  when "Ret"='' then 0 else Cast( "Ret" AS DECIMAL) END  ) as "kickoff_total_Returns",
    sum( case when  "RYds" = '--' then 0  when "RYds"='' then 0  else Cast( "RYds" AS DECIMAL) END ) as "kickoff_total_ReturnYards"    ,  
    sum( case when  "Lg" = '--' then 0 when "Lg" like '%t' then cast(trim( TRAILING 't' from "Lg") as decimal)  when  "Lg" = '' then 0  else cast( "Lg" as DECIMAL)  end   ) as "kickoff_total_Lg" ,  
    sum("TD") as "kickoff_total_TD"
FROM dvproject2
where "Stat_Type"  = 'Kickoff'        
group By "Team","Year" ),
kickoff_return_cte as (Select 
	"Team",
	"Year",             
    sum("Yds") as "kickofff_return_total_Yds",
    sum("Num") as "kickoff_return_total_Num",
    sum("Yds") as "kickofff_return_total_Yds",
	sum("Avg") as "kickofff_return_total_Avg",
    sum( case when  "FC" = '--' then 0 when "FC" = '' then 0 else cast( "FC" as DECIMAL)  end   ) as "kickofff_return_total_FC",
    sum( case when  "Lg" = '--' then 0 when "Lg" like '%t' then cast(trim( TRAILING 't' from "Lg") as decimal)  when  "Lg" = '' then 0  else cast( "Lg" as DECIMAL)  end   ) as "kickofff_return_total_Lg"   ,
    sum("TD") as "kickofff_return_total_TD"
FROM dvproject2
where "Stat_Type"  = 'Kickoff Return'        
group By "Team","Year" ),
defense_cte as (Select 
	"Team",
	"Year",             
	sum("Int") as "defense_total_Int",                
    sum("Yds") as "defense_total_Yds",
    sum("Yds") as "defense_total_Yds",
	sum("Avg") as "defense_total_Avg",
    sum( case when  "Lg" = '--' then 0 when "Lg" like '%t' then cast(trim( TRAILING 't' from "Lg") as decimal)  when  "Lg" = '' then 0  else cast( "Lg" as DECIMAL)  end   ) as "defense_total_Lg"   ,
    sum("TD") as "defense_total_TD",
	sum("Solo") as "defense_total_TD"   ,
    sum("Ast") as "defense_total_Ast" ,
    sum("Tot") as "defense_total_Ast" ,
    sum("YdsL") as "defense_total_YdsL" ,
    sum( case when  "Sack" = '--' then 0   when  "Sack" = '' then 0  else cast( "Sack" as DECIMAL)  end   ) as "defense_total_Sack"           
	                
FROM dvproject2
where "Stat_Type"  = 'Defense'        
group By "Team","Year" ),
rushing_cte as (Select 
	"Team",
	"Year",                     
    sum("Yds") as "rushing_total_Yds",
	sum("Avg") as "rushing_total_Avg",
    sum("TD") as "rushing_total_TD",
    sum("Gain") as "rushing_total_gain",	
    sum("Att") as "rushing_total_att",
    sum( case when  "Loss" = '--' then 0 when "Loss" = '' then 0 else cast( "Loss" as DECIMAL)  end   ) as "Passing_total_Loss",
	sum(case when  "Lg" = '--' then 0 when "Lg" like '%t' then cast(trim( TRAILING 't' from "Lg") as decimal)  when  "Lg" = '' then 0  else cast( "Lg" as DECIMAL)  end   ) as "rushing_total_Lg",
    sum(case when  "TB" = '' then 0 else Cast( "TB" as DECIMAL ) end) as "rushing_total_tb"
FROM dvproject2
where "Stat_Type"  = 'Rushing'        
group By "Team","Year")


select
coalesce(punting_cte."Team", scoring_cte."Team",passing_cte."Team",receiving_cte."Team", punt_return_cte."Team",kickoff_cte."Team", kicking_cte."Team",  rushing_cte."Team",kickoff_return_cte."Team" ) as "Team",
coalesce(punting_cte."Year", scoring_cte."Year",passing_cte."Year", receiving_cte."Year",punt_return_cte."Year",kickoff_cte."Year", kicking_cte."year",  rushing_cte."Year",kickoff_return_cte."Year",'2009' ) AS "Year",
punting_cte.*,
scoring_cte.*,
passing_cte.*,
punt_return_cte.*,
receiving_cte.*,
kickoff_cte.* ,
kicking_cte.*,
rushing_cte.*,
kickoff_return_cte.*,
defense_cte.*
from 
receiving_cte
left  JOIN punting_cte
on receiving_cte."Team"=punting_cte."Team" and receiving_cte."Year"=punting_cte."Year"
LEFT join 
scoring_cte 
on receiving_cte."Team"=scoring_cte."Team" and receiving_cte."Year"=scoring_cte."Year"
LEFT join 
passing_cte
on receiving_cte."Team"=passing_cte."Team" and receiving_cte."Year"=passing_cte."Year"
LEFT join 
punt_return_cte
on receiving_cte."Team"=punt_return_cte."Team" and receiving_cte."Year"=punt_return_cte."Year"
LEFT join 
 kickoff_cte
on receiving_cte."Team"=kickoff_cte."Team" and receiving_cte."Year"=kickoff_cte."Year"
LEFT join kickoff_return_cte
on receiving_cte."Team"=kickoff_return_cte."Team" and receiving_cte."Year"=kickoff_return_cte."Year"
LEFT JOIN defense_cte
on receiving_cte."Team"=defense_cte."Team" and receiving_cte."Year"=defense_cte."Year"
LEFT JOIN kicking_cte
on receiving_cte."Team"=kicking_cte."Team" and receiving_cte."Year"=kicking_cte."year"
LEFT Join rushing_cte
on receiving_cte."Team"=rushing_cte."Team" and receiving_cte."Year"=rushing_cte."Year"



