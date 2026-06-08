# Data Dictionary

## Line Productivity

| Column | Description |
|----------|----------|
| Date | Production date |
| Product | Product ID |
| Batch | Batch ID |
| Operator | Operator responsible |
| Start Time | Time the batch production started |
| End Time | Time the batch production ended |

## Products

| Column | Description |
|----------|----------|
| Product | Product ID |
| Flavor | Soda flavor used |
| Size | Bottle size (Vol) |
| Min batch time | Minimum production time |

## Line downtime

| Column | Description |
|----------|----------|
| Batch | Batch ID |
| Downtime factor | Downtime minutes for each factor ID |

## Downtime factors

| Column | Description |
|----------|----------|
| Factor | Factor ID |
| Description | Downtime factor description |
| Human error | (Yes/no) |
