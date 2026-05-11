SELECT  salesvolume.january
,   salesvolume.february
,   salesvolume.march
,   salesvolume.april
,   salesvolume.may
,   salesvolume.june
,   salesvolume.july
,   salesvolume.august
,   salesvolume.september
,   salesvolume.october
,   salesvolume.november
,   salesvolume.december
,   suppliers.country
FROM     ((producttable
INNER JOIN salesvolume
ON  producttable.stocknumber = salesvolume.stocknumber)
INNER JOIN suppliers
ON  producttable.suppliernumber = suppliers.suppliernumber)
WHERE suppliers.country LIKE 'United States%'