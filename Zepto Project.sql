DROP TABLE IF EXISTS zepto;

CREATE TABLE zepto (
  
    Category TEXT,
    name TEXT,
    mrp INTEGER,
    discountPercent INTEGER,
    availableQuantity INTEGER,
    discountedSellingPrice INTEGER,
    weightInGms INTEGER,
    outofStock BOOLEAN,   
    quantity INTEGER
);

alter table zepto
add column  sku_id serial primary key;

-- sample data
select sku_id , * from zepto;

-- count of rows
select count(*) from zepto;

-- null values
select * from zepto
where row(zepto.*) is null

-- different categories
select distinct category
from zepto
order by category;

-- in stock vs out of stock
select outofstock, count(sku_id)
from zepto
group by outofstock;

-- product name multiple times
select name, count(name) as repeated
from zepto
group by name
having count(name) > 1
order by repeated desc;

--Data Cleaning

--Price = 0
select * from zepto
where mrp = 0 or discountedsellingprice = 0;

--Delete it

delete from zepto
where mrp = 0;

--Convert paise to rupee

--update zepto
--set mrp = mrp/100.0, discountedsellingprice = discountedsellingprice/100.0;

select mrp, discountedsellingp;

--Find the top best 10 value-products according to discount percent

select distinct name, mrp, discountpercent from zepto
order by discountpercent desc
limit 10;

--What are the products with high mrp but out of stock

select name, max(mrp) from zepto
group by name, outofstock
having outofstock = true
order by max(mrp) desc
limit 5;

--Calculate estimated revenue for each category

select category, sum(discountedsellingprice * availablequantity) as Revenue from zepto
group by category
order by revenue desc; 

--Find all the products with mrp greater than 500 and discount is less than 10%

select distinct name, mrp, discountpercent from zepto
where mrp > 500 and discountpercent < 10
order by discountpercent desc;

--Identidy the top 5 categories offering the highest average discount percentage

select category, round(avg(discountpercent), 2) as average from zepto
group by category
order by average desc
limit 5;

--Find the price per gram for products above 100g and sort by best value

select distinct name, discountedsellingprice, weightingms, round(cast(discountedsellingprice as numeric) /weightingms, 2) as price_per_gram from zepto
where weightingms >= 100
order by price_per_gram;

--Group the products into low, medium, bulk acc to gms

select distinct name, weightingms, 
case when weightingms < 1000 then 'low'
     when weightingms >= 1000 and weightingms < 5000 then 'medium'
	 else 'bulk'
	 end as weightcategory
from zepto
order by weightingms desc;

--What is the total inventory weight per category

select category, sum(weightingms * availablequantity) as total_quantity from zepto
group by category
order by total_quantity;
















