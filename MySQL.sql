use manufacturing;
show tables;

#Q1 Total manufacture quantity
select concat(round(sum(manufactured_qty)/1000000,2),' M') as Total_Manufactured
from production;

#Q2 Number of units that failed quality checks and were rejected
select * from production;
select concat(round(sum(rejected_qty)/1000,2),' K') as Total_Rejected from production;

#Q3 processed qty: quantity of items that completed specific manufacturing stage
select concat(round(sum(processed_qty)/1000000,2),' M')as Total_Processed
from production;


#Q4 Wastage Quantity: materials or items lost during the production process

select *, concat(round((wastage/total_produced)*100,2),' %')as `Wastage_%` from(
select concat(round(sum(produced_qty)/1000000,2),' M')as Total_produced, 
concat(round(sum(Manufactured_qty)/1000000,2),' M')as Total_manufactured,
concat(round(sum(produced_qty-manufactured_qty)/1000000,2),' M')as Wastage
from production)ab;

#Q5 Employee wise rejected qty
select Emp_name, sum(rejected_qty)as Total_Rejected
from production
group by emp_name
order by 2 desc;

#Q6 machine wise rejected qty
select * from prod;
select *, concat(round((total_rejected/Manufactured_Qty)*100,2),' %')as `Rejected_%` from ( 
select Machine_name, 
sum(Manufactured_Qty)as Manufactured_qty ,
sum(rejected_qty)as Total_Rejected
from production
group by machine_name)ab
order by 4 desc;

#Q7 production comparison trend

select order_month, Total_produced from(
select month(wo_date)as month_no, monthname(wo_date)as order_month,
concat(round(sum(Produced_Qty)/1000,0),' K') as Total_produced
from production
group by 1 ,2
order by 1)ab;

#Q8 manufactured Vs rejected

select *, 
concat(round((total_rejected/total_manufactured)*100,2),' %')as `Rejected_%`from(
select concat(round(sum(manufactured_qty)/1000000,2),' M')as Total_Manufactured,
concat(round(sum(rejected_qty)/1000000,2),' M')as Total_Rejected from production)ab;

#Q9 department wise manufactured vs rejected
select * from prod;
select department_name, 
concat(round(sum(manufactured_qty)/1000000,2),' M')as Total_Manufactured,
concat(round(sum(rejected_qty)/1000000,3),' M') as Total_Rejected
from production
group by 1;



