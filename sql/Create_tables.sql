CREATE TABLE Downtime_factors ( Factor_id int PRIMARY KEY, Description text, Operation_error boolean);
CREATE TABLE products ( Product text PRIMARY KEY, Flavor text, Size int, min_batch_time int);

CREATE TABLE Line_Productivity (Date DATE, Product_id text REFERENCES products(Product), Batch int PRIMARY KEY, Operator text, Start_time time, End_time time);

CREATE TABLE Line_Downtime (Batch int REFERENCES Line_Productivity(Batch), Downtime_factor int REFERENCES Downtime_Factors(Factor_id), Time_consumed_min int, PRIMARY KEY (Batch, Downtime_factor))
