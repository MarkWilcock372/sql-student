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

-- results from home team perspective
SELECT      
    m.HomeTeam  as Team
    ,m.FTHG AS GoalsFor
    ,m.FTAG  AS GoalsAgainst
--    ,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' WHEN 'A' THEN 'L' END As Result
    --,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' ELSE 'L' END As Result
    ,CASE when m.FTHG > m.FTAG then 'W' when M.FTHG = M.FTAG then 'D' else 'L' end as Result
FROM
    FootballMatch m

-- results from home team perspective
SELECT      
    m.HomeTeam  as Team
    ,m.FTHG AS GoalsFor
    ,m.FTAG  AS GoalsAgainst
--    ,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' WHEN 'A' THEN 'L' END As Result
    --,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' ELSE 'L' END As Result
    ,CASE when m.FTHG > m.FTAG then 'W' when M.FTHG = M.FTAG then 'D' else 'L' end as Result
FROM
    FootballMatch m

-- results from home team perspective
SELECT      
    m.HomeTeam  as Team
    ,m.FTHG AS GoalsFor
    ,m.FTAG  AS GoalsAgainst
--    ,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' WHEN 'A' THEN 'L' END As Result
    --,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' ELSE 'L' END As Result
    ,CASE when m.FTHG > m.FTAG then 'W' when M.FTHG = M.FTAG then 'D' else 'L' end as Result
FROM
    FootballMatch m

-- results from home team perspective
SELECT      
    m.HomeTeam  as Team
    ,m.FTHG AS GoalsFor
    ,m.FTAG  AS GoalsAgainst
--    ,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' WHEN 'A' THEN 'L' END As Result
    --,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' ELSE 'L' END As Result
    ,CASE when m.FTHG > m.FTAG then 'W' when M.FTHG = M.FTAG then 'D' else 'L' end as Result
FROM
    FootballMatch m

-- results from home team perspective
SELECT      
    m.HomeTeam  as Team
    ,m.FTHG AS GoalsFor
    ,m.FTAG  AS GoalsAgainst
--    ,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' WHEN 'A' THEN 'L' END As Result
    --,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' ELSE 'L' END As Result
    ,CASE when m.FTHG > m.FTAG then 'W' when M.FTHG = M.FTAG then 'D' else 'L' end as Result
FROM
    FootballMatch m

DROP TABLE IF EXISTS #EPLResults;

-- results from home team perspective
SELECT      
    m.HomeTeam  as Team
    ,m.FTHG AS GoalsFor
    ,m.FTAG  AS GoalsAgainst
--    ,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' WHEN 'A' THEN 'L' END As Result
    --,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' ELSE 'L' END As Result
    ,CASE when m.FTHG > m.FTAG then 'W' when M.FTHG = M.FTAG then 'D' else 'L' end as Result
INTO #EPLResults
FROM
    FootballMatch m
UNION ALL
-- results from AWAY team perspective
SELECT      
    m.AwayTeam  as Team
    ,m.FTAG AS GoalsFor
    ,m.FTHG  AS GoalsAgainst
    ,CASE m.FTR WHEN 'A' THEN 'W' WHEN 'D' THEN 'D' WHEN 'H' THEN 'L' END As Result
FROM
    FootballMatch m

SELECT * FROM #EPLResults;

-- group by team to build the league table

SELECT
    r.Team
    , COUNT(*) as Played
    , sum(r.GoalsFor) as GoalsFor
    , sum(r.GoalsAgainst) as GoalsAgainst
    , sum(r.GoalsFor) - sum(r.GoalsAgainst) as GD
    , sum(CASE WHEN r.Result = 'W' THEN 1 ELSE 0 END) aS Won
    , sum(CASE WHEN r.Result = 'D' THEN 1 ELSE 0 END) aS Drawn
    , sum(CASE WHEN r.Result = 'L' THEN 1 ELSE 0 END) aS Lost
    , SUM(CASE r.Result WHEN 'W' THEN 3 WHEN 'D' THEN 1 ELSE 0 END ) as Points
from #EPLResults r
GROUP BY r.Team
ORDER BY Points DESC, GD DESC


