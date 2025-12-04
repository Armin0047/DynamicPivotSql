# Dynamic Pivot SQL Query

این اسکریپت یک Pivot داینامیک روی جدول‌های `Sandogh`, `Kheyrie`, و `Facheder` اجرا می‌کند.
ستون‌های خیریه به‌صورت داینامیک ساخته می‌شوند و مجموع مبالغ (`Mablagh`) برای هر نسخه نمایش داده می‌شود.

## نحوه اجرا
کافیست اسکریپت را در SQL Server اجرا کنید:
```sql
EXEC sp_executesql @sql;
