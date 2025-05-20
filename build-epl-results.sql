-- Build the English Premier League results table from the match record

SELECT
    m.[Date]
    ,m.HomeTeam
    ,m.AwayTeam
    ,m.FTHG
    ,m.FTAG  
    ,FTR
FROM
    FootballMatch m;

/*
Each match produces two results - one from  the home team and one from the away team perspective
build a results table from the match table
*/
-- home team view
DROP TABLE if EXISTS  #LeagueTable 

GO

SELECT
   m.[Date]
    ,m.HomeTeam AS Team
    ,m.FTHG AS [For]
    ,m.FTAG as [Against] 
    , CASE m.FTR WHEN 'H' THEN 'W' WHEN 'A' THEN 'L' ELSE 'D' END AS Result
    , CASE m.FTR WHEN 'H' THEN 1 ELSE 0 END AS Won
    , CASE m.FTR WHEN 'A' THEN 1 ELSE 0 END AS Lost
    , CASE m.FTR WHEN 'D' THEN 1 ELSE 0 END AS Drawn
INTO #LeagueTable
FROM
    FootballMatch m
UNION ALL
-- away team view
SELECT
    m.[Date]
    ,m.AwayTeam AS Team
    ,m.FTAG AS [For]
    ,m.FTHG as [Against] 
    , CASE m.FTR WHEN 'H' THEN 'L' WHEN 'A' THEN 'W' ELSE 'D' END AS Result
    , CASE m.FTR WHEN 'A' THEN 1 ELSE 0 END AS Won
    , CASE m.FTR WHEN 'H' THEN 1 ELSE 0 END AS Lost
    , CASE m.FTR WHEN 'D' THEN 1 ELSE 0 END AS Drawn
FROM
    FootballMatch m

select * from #LeagueTable
;

with cte AS (
SELECT
    t.Team
    ,COUNT(1) as Played
    , (SELECT COUNT(*) FROM #LeagueTable t2 WHERE t2.Result = 'W' AND t2.Team = t.Team) AS Won2
    , SUM(t.Won) as Won
    , SUM(t.Lost) as Lost
    , SUM(t.Drawn) as Drawn
    ,SUM(t.[For]) AS [For]
    ,SUM(t.Against) AS Against
    ,SUM(t.[For]) - SUM(t.Against) AS [GD]
    ,SUM(t.Won) * 3 + SUM (T.Drawn) AS Points
FROM
    #LeagueTable t
GROUP BY t.Team)
SELECT cte.* 
, RANK() OVER (order by cte.Points DESC , GD DESC, [For] DESC) as Position
FROM cte
order by cte.Points DESC , GD DESC, [For] DESC
























SELECT
    t.Team
--    ,COUNT(*) as Played
    ,SUM(t.[For]) AS [For]
    ,SUM(t.Against) AS Against
--    , (select Count(*) from #LeagueTable t2 WHERE t2.Result = 'W' and t2.Team = t.Team) AS Won
--    ,SUM(t.[For]) - SUM(t.Against) AS [GD]
FROM
    #LeagueTable t
GROUP BY t.Team

