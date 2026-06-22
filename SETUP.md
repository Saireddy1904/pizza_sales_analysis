# Pizza Sales Analysis - MySQL Setup Guide

## Prerequisites

- MySQL Server 5.7+ (recommended 8.0+)
- MySQL Client
- Access to terminal/command prompt
- Pizza sales data CSV file

## Installation Steps

### Step 1: Connect to MySQL

```bash
mysql -u username -p
```

### Step 2: Create Database

```sql
CREATE DATABASE pizza_sales_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE pizza_sales_db;
```

### Step 3: Create Tables

Execute the schema file:

```bash
mysql -u username -p pizza_sales_db < schema/database_schema.sql
```

### Step 4: Insert Sample Data (Optional)

```bash
mysql -u username -p pizza_sales_db < schema/sample_data.sql
```

### Step 5: Verify Installation

```bash
mysql -u username -p -e "USE pizza_sales_db; SHOW TABLES;"
```

You should see:
- customers
- orders
- order_items
- pizzas
- pizza_types

## Running Queries

### Execute a specific query file:

```bash
mysql -u username -p pizza_sales_db < queries/02_revenue_analysis.sql
```

### Generate a report:

```bash
mysql -u username -p pizza_sales_db < reports/daily_sales_report.sql > report.txt
```

### Export results to CSV:

```bash
mysql -u username -p pizza_sales_db \
  --execute="SELECT * FROM orders LIMIT 1000" \
  --csv > orders_export.csv
```

## Database Backup and Restore

### Create a backup:

```bash
mysqldump -u username -p pizza_sales_db > backup_pizza_sales.sql
```

### Restore from backup:

```bash
mysql -u username -p pizza_sales_db < backup_pizza_sales.sql
```

## Troubleshooting

### Connection Issues

- Verify MySQL server is running
- Check username and password
- Ensure database exists

### Data Import Issues

- Check file encoding (should be UTF-8)
- Verify field delimiters match CSV format
- Check file permissions

### Query Performance

- Add indexes for frequently queried columns
- Use EXPLAIN to analyze query performance
- Archive old data to maintain performance

## Common Tasks

### View all tables

```sql
SHOW TABLES;
```

### View table structure

```sql
DESC orders;
```

### Show database size

```sql
SELECT table_schema, ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) as 'Size in MB'
FROM information_schema.tables
WHERE table_schema = 'pizza_sales_db'
GROUP BY table_schema;
```

## Next Steps

1. Load your pizza sales data into the database
2. Run analysis queries to generate insights
3. Create views for frequently used reports
4. Set up automated backups
5. Implement data archiving strategy for old records
