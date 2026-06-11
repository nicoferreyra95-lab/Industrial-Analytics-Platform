CREATE TABLE Downtime_factors ( Factor_id int PRIMARY KEY, Description text, Operation_error boolean);
CREATE TABLE products ( Product text PRIMARY KEY, Flavor text, Size int, min_batch_time int);

CREATE TABLE Line_Productivity (Date DATE, Product_id text REFERENCES products(Product), Batch int PRIMARY KEY, Operator text, Start_time time, End_time time);

CREATE TABLE Line_Downtime (Batch int REFERENCES Line_Productivity(Batch), Downtime_factor int REFERENCES Downtime_Factors(Factor_id), Time_consumed_min int, PRIMARY KEY (Batch, Downtime_factor))

#prueba de evaluación de tiempos
SELECT
    batch,
    product_id,
    start_time,
    end_time,
    EXTRACT(EPOCH FROM (end_time - start_time))/60 AS actual_minutes
FROM line_productivity
LIMIT 10;

#Vista para KPI de eficiencia
CREATE VIEW batch_performance AS
SELECT
    l.batch,
    l.product_id,
    p.min_batch_time,

    CASE
        WHEN l.end_time >= l.start_time THEN
            EXTRACT(EPOCH FROM (l.end_time - l.start_time))/60
        ELSE
            EXTRACT(EPOCH FROM ((l.end_time - l.start_time) + INTERVAL '24 hours'))/60
    END AS actual_time

FROM line_productivity l
JOIN products p
    ON l.product_id = p.product;

#Vista para KPIs totales
CREATE VIEW KPIs AS
select b.batch, b.product_id, b.min_batch_time, b.actual_time, 
COALESCE(SUM(ld.time_consumed_min), 0) AS downtime_total,
b.actual_time-COALESCE(SUM(ld.time_consumed_min), 0) AS net_production_time,
ROUND(b.min_batch_time::numeric/b.actual_time::numeric,3) AS efficiency

FROM batch_performance b

LEFT JOIN line_downtime ld
    ON b.batch = ld.batch

GROUP BY
    b.batch,
    b.product_id,
    b.min_batch_time,
    b.actual_time;

#Eficiencia media
Select round(avg(efficiency),2) from kpis

#Downtime por producto
SELECT product_id, sum(downtime_total) from kpis GROUP BY product_id

#Downtime por factor numérico
select downtime_factor,  SUM(time_consumed_min) AS downtime
 from line_Downtime group by downtime_factor ORDER BY downtime_factor asc

#Downtime por evento
select d.description, sum(time_consumed_min)
 from line_Downtime join Downtime_factors d on downtime_factor=factor_id
 GROUP BY d.description

 #Vista general para dashboard
CREATE View Dashboard AS
select  kpis.product_id, COUNT(kpis.batch) as batches,
round(avg(kpis.efficiency),3) as avg_efficiency, 
sum(kpis.downtime_total) as total_downtime
from kpis GROUP BY kpis.product_id
ORDER BY kpis.product_id asc
 