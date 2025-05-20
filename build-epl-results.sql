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
