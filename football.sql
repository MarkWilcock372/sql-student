-- Football Match exercise

/* 
The FootballMatch table shows the EPL matches played in 2024/25 season as of 16th March 2025

Important Columns
Date - Match Date (dd/mm/yy)
Time - Time of match kick off
HomeTeam- Home Team
AwayTeam - Away Team
FTHG -Full Time Home Team Goals
FTAG - Full Time Away Team Goals
FTR	- Full Time Result (H=Home Win, D=Draw, A=Away Win)

Full details at https://zomalex.co.uk/datasets/football_match_dataset.html
*/

SELECT
    fm.Date
    , fm.HomeTeam
    , fm.AwayTeam
    , fm.FTHG
    , fm.FTAG
    , fm.FTR
FROM
    FootballMatch fm;

/*
How many games have been played?.  
- In total
- By each team
- By Month
*/

SELECT
    DATENAME(YEAR, fm.[Date]) AS YearName
    ,DATENAME(MONTH, fm.[Date]) AS MonthName
    --,MONTH(fm.Date) AS MonthNumber
    ,COUNT(*) AS  NumberOfMatches
FROM
    FootballMatch fm
GROUP BY 
    MONTH(fm.Date) 
    ,DATENAME(MONTH, fm.[Date])
    ,DATENAME(YEAR, fm.[Date])
ORDER BY 
    YearName, MONTH(fm.Date);



-- How many goals have been scored by each team?

-- CTE approach

WITH  cte (Team, TotalGoals)  AS (
SELECT
    fm.HomeTeam 
    , SUM(fm.FTHG) 
FROM
    FootballMatch fm
group by fm.HomeTeam
UNION ALL
SELECT
    fm.AwayTeam
    , SUM(fm.FTAG)
FROM
    FootballMatch fm
group by fm.AwayTeam  
)
SELECT cte.Team, SUM(cte.TotalGoals) AS TotalGoals FROM cte GROUP BY cte.Team ORDER BY cte.Team;

-- Build the league table from the match record.  use a temp table approach

DROP TABLE IF EXISTS #LeagueTable;

SELECT
    fm.HomeTeam AS Team
    ,CASE WHEN fm.FTR = 'H' THEN 1  ELSE 0 END AS Won -- SERACHED CASE
    ,CASE fm.ftr WHEN 'D' THEN 1 ELSE 0 END AS Drawn -- simple CASE
    ,fm.FTHG AS GF
    ,fm.FTAG AS GA
    ,CASE fm.FTR WHEN 'H' THEN 3 WHEN 'D' THEN 1 ELSE 0 END AS Points
INTO #LeagueTable
    FROM FootballMatch fm
UNION ALL
SELECT
    fm.AwayTeam
    ,CASE WHEN fm.FTR = 'A' THEN 1 ELSE 0 END AS Won
    ,CASE fm.ftr WHEN 'D' THEN 1 ELSE 0 END AS Drawn -- simple CASE
    ,fm.FTAG
    ,fm.FTHG
    ,CASE fm.FTR WHEN 'A' THEN 3 WHEN 'D' THEN 1 ELSE 0 END
FROM  FootballMatch fm

SELECT * FROM #LeagueTable;

SELECT
    t.Team AS Team
    ,count(*) AS Played
    ,SUM(t.Won) AS Won
    ,SUM(t.Drawn) AS Drawn
    ,SUM(T.GF) AS GF    
    ,SUM(T.GA) AS GA
    ,SUM(t.Points) AS Points
FROM
    #LeagueTable t
GROUP BY t.Team
ORDER BY t.Team;