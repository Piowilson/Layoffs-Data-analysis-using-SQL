-- Exploratory Data Analysis

select * from layoffs_staging2;

select max(total_laid_off)
from layoffs_staging2;

select * from layoffs_staging2
where percentage_laid_off=1
order by total_laid_off DESC;

select * from layoffs_staging2
where percentage_laid_off=1
order by funds_raised_millions DESC;

select company,sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 DESC;

select MIN(`date`),MAX(`date`) from layoffs_staging2;

select industry,sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 DESC;

select country,sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 DESC;

select year(`date`),sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 DESC;

select company,sum(total_laid_off)
from layoffs_staging2
group by company
order by 1 DESC;

select * from layoffs_staging2;

select substring(`date`,6,2) as month,sum(total_laid_off)
from layoffs_staging2
group by month;

select substring(`date`,1,7) as `month`,sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1;

with Rolling_Total as
(
select substring(`date`,1,7) as `month`,sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1
)
select `month`,total_off ,sum(total_off) over(order by `month`) as rolling_total
from Rolling_Total;

select company,sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 Desc;

select company,year(`date`),sum(total_laid_off)
from layoffs_staging2
group by company,year(`date`)
order by 3 desc;


with company_year (company,Years,total_laid_off)as
(
select company,year(`date`),sum(total_laid_off)
from layoffs_staging2
group by company,year(`date`)
),company_year_rank as
(
select *,dense_rank() over(partition by Years order by total_laid_off desc) as Ranking
 from company_year
 where Years is not null
 )
 select * from company_year_rank
 where Ranking <= 5;
 
 
















