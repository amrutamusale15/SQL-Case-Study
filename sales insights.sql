use sales;

select * from customers;

select * from transactions;

select * from products;

select * from markets;

select count(*) from transactions;

select count(*) from customers;

select count(*)from  transactions where market_code = "Mark001";