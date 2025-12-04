DECLARE @columns NVARCHAR(MAX), @sql NVARCHAR(MAX);

-- ساخت لیست ستون‌ها با FOR XML PATH (بدون ORDER BY)
SELECT @columns = STUFF((
    SELECT ',' + QUOTENAME(K.Kheyrie)
    FROM (
        SELECT DISTINCT K.Kheyrie
        FROM Sandogh S
        JOIN Kheyrie K ON K.KheyrieCode = S.KheyrieCode
        WHERE S.state = 50
    ) AS DistinctKheyrie
    FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 1, '');

-- ساخت کوئری Pivot داینامیک
SET @sql = '
SELECT *
FROM (
    SELECT 
        H.Sh_Noskhe,
        H.DateFac,
        H.BimarName,
        H.mobile,
        K.Kheyrie,
        S.Mablagh
    FROM Facheder H
    INNER JOIN Sandogh S ON S.Sh_noskhe = H.Sh_noskhe
    INNER JOIN Kheyrie K ON K.KheyrieCode = S.KheyrieCode
    WHERE S.state = 50 AND H.state = 0
) AS SourceTable
PIVOT (
    SUM(Mablagh)
    FOR Kheyrie IN (' + @columns + ')
) AS PivotTable;
';

-- اجرای کوئری
EXEC sp_executesql @sql;
