# Industrial-Analytics-Platform
Using an example industry dataset, this project focused on production monitoring, downtime analysis and process performance evaluation using SQL, Python and Power BI.

## Project objectives:
Production analysis
Downtime causes identifying
Efficiency measuring
Stability monitoring

## Technologies

- SQL
- Python
- Power BI

## Dataset

Manufacturing Downtime Dataset (Soda Bottling Production Line)

## KPIs

- Total Production
- Downtime Minutes
- Downtime by Cause
- Production Time
- Average Batch Duration
- Production by Product

## Procedure
###Data preparation (ETL with python):
Using PostgreSQL, tables were created from csv files obtained from the main excel data sheet. To import the raw data from csv to sql, Pandas were used.
In the case of the line downtime sheet, the data notation order was not optimal for analysis purpose, so it was redistributed:
the new columns were product_id, downtime_factor and time_consumed.
Melt function was used to reorder the values in the new distribution.

###SQL:
Having the tables, views were generated:
**batch_performance**, to analyze the time consumed per batch;
**KPIs**, to obtain the efficiency based on cycle times;
**Dashboard**, to group our main variables in a more understandable way.
Calculating time for each batch to be produced, an issue was discovered. Time resulted <0 when the batch finished after midnight. This issue was solved on the batch_performance view at the SQL query.

###Dashboard:
At the end, a Power BI was made to have a simple visual understanding of the situation in two pages:
**"Production"**, to see quantities, time consumed and efficiency per product,
**"Root cause analysis"**, where we can see the time lost by downtime causes and filter by them or by product.