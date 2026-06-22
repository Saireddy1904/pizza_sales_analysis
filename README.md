# Pizza Sales Analysis - MySQL Edition

A comprehensive pizza sales analysis project using MySQL for data storage, querying, and analytics.

## 📊 Project Overview

This project analyzes pizza sales data stored in MySQL database. It includes database schema design, data import, complex SQL queries, and business intelligence insights.

## 🎯 Objectives

- Design efficient MySQL database schema for pizza sales
- Analyze sales trends and patterns using SQL queries
- Identify top-performing pizza categories and products
- Understand customer purchasing behavior
- Generate revenue insights and performance metrics
- Create reusable SQL queries for reporting

## 📁 Project Structure

```
pizza_sales_analysis/
├── README.md
├── SETUP.md
├── schema/
│   ├── database_schema.sql
│   ├── create_tables.sql
│   └── sample_data.sql
├── queries/
│   ├── 01_basic_queries.sql
│   ├── 02_revenue_analysis.sql
│   ├── 03_product_analysis.sql
│   ├── 04_customer_analysis.sql
│   └── 05_trend_analysis.sql
├── reports/
│   ├── daily_sales_report.sql
│   ├── product_performance.sql
│   ├── category_breakdown.sql
│   └── monthly_summary.sql
└── data/
    └── pizza_sales.csv
```

## 🚀 Getting Started

### Prerequisites

- MySQL Server 5.7+ or MySQL 8.0+
- MySQL Client (mysql command-line tool)
- A terminal/command prompt
- Pizza sales data (CSV file)

### Installation Steps

#### 1. Create Database
```sql
CREATE DATABASE pizza_sales_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE pizza_sales_db;
```

#### 2. Create Tables
```bash
mysql -u username -p pizza_sales_db < schema/create_tables.sql
```

#### 3. Import Data
```bash
mysql -u username -p pizza_sales_db -e "LOAD DATA LOCAL INFILE 'data/pizza_sales.csv' INTO TABLE orders FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;"
```

#### 4. Verify Data
```bash
mysql -u username -p -e "USE pizza_sales_db; SELECT COUNT(*) as total_records FROM orders;"
```

## 📋 Database Schema

### Tables

#### 1. **pizzas**
| Column | Type | Description |
|--------|------|-------------|
| pizza_id | INT PRIMARY KEY | Unique pizza identifier |
| pizza_name | VARCHAR(100) | Name of the pizza |
| pizza_type | VARCHAR(50) | Category (Classic, Veggie, Chicken, etc.) |
| price | DECIMAL(10,2) | Price of the pizza |

#### 2. **orders**
| Column | Type | Description |
|--------|------|-------------|
| order_id | INT PRIMARY KEY | Unique order identifier |
| order_date | DATE | Date of the order |
| order_time | TIME | Time of the order |
| pizza_id | INT | Foreign key to pizzas table |
| pizza_size | VARCHAR(20) | Size (Small, Medium, Large, XL) |
| quantity | INT | Number of pizzas ordered |
| unit_price | DECIMAL(10,2) | Price per pizza |
| total_price | DECIMAL(10,2) | Total order amount |

#### 3. **customers** (Optional)
| Column | Type | Description |
|--------|------|-------------|
| customer_id | INT PRIMARY KEY | Unique customer identifier |
| customer_name | VARCHAR(100) | Name of customer |
| order_id | INT | Foreign key to orders table |

## 🔍 SQL Queries

### Key Analyses

#### 1. Total Revenue
```sql
SELECT 
    SUM(total_price) as total_revenue,
    COUNT(DISTINCT order_id) as total_orders,
    AVG(total_price) as avg_order_value
FROM orders;
```

#### 2. Top 10 Pizza Types by Revenue
```sql
SELECT 
    p.pizza_name,
    p.pizza_type,
    COUNT(o.order_id) as order_count,
    SUM(o.total_price) as total_revenue,
    AVG(o.total_price) as avg_price
FROM orders o
JOIN pizzas p ON o.pizza_id = p.pizza_id
GROUP BY p.pizza_id, p.pizza_name, p.pizza_type
ORDER BY total_revenue DESC
LIMIT 10;
```

#### 3. Sales by Pizza Size
```sql
SELECT 
    pizza_size,
    COUNT(*) as order_count,
    SUM(quantity) as total_quantity,
    SUM(total_price) as total_revenue,
    AVG(total_price) as avg_order_value
FROM orders
GROUP BY pizza_size
ORDER BY total_revenue DESC;
```

#### 4. Monthly Sales Trend
```sql
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') as month,
    COUNT(DISTINCT order_id) as total_orders,
    SUM(total_price) as monthly_revenue,
    AVG(total_price) as avg_order_value
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month ASC;
```

#### 5. Daily Peak Hours
```sql
SELECT 
    HOUR(order_time) as hour,
    COUNT(*) as order_count,
    SUM(total_price) as hourly_revenue
FROM orders
GROUP BY HOUR(order_time)
ORDER BY hourly_revenue DESC;
```

## 📊 Analysis Reports

### Available Reports

1. **Daily Sales Report** - Daily revenue, order count, average order value
2. **Product Performance** - Top performing pizzas and categories
3. **Category Breakdown** - Revenue by pizza type
4. **Monthly Summary** - Month-over-month performance metrics
5. **Size Analysis** - Sales breakdown by pizza size
6. **Peak Hours Analysis** - Busy periods identification

Run any report:
```bash
mysql -u username -p pizza_sales_db < reports/daily_sales_report.sql
```

## 🛠️ Technologies Used

- **MySQL 8.0+** - Database management system
- **SQL** - Query language for analysis
- **CSV** - Data import format

## 📈 Key Metrics Calculated

- Total Revenue
- Average Order Value (AOV)
- Total Orders
- Total Items Sold
- Revenue by Category
- Revenue by Size
- Daily/Monthly Trends
- Peak Hours
- Product Performance Rankings

## 📝 Usage Examples

### Connect to Database
```bash
mysql -u your_username -p pizza_sales_db
```

### Run Analysis Queries
```bash
# View total revenue
mysql -u username -p pizza_sales_db < queries/02_revenue_analysis.sql

# View top products
mysql -u username -p pizza_sales_db < queries/03_product_analysis.sql

# View trends
mysql -u username -p pizza_sales_db < queries/05_trend_analysis.sql
```

### Export Results to CSV
```bash
mysql -u username -p pizza_sales_db \
  -e "SELECT * FROM orders LIMIT 1000;" \
  > results.csv
```

## 🎯 Analysis Insights

This project provides:
- ✅ Real-time sales metrics
- ✅ Customer purchasing patterns
- ✅ Product performance rankings
- ✅ Seasonal trends identification
- ✅ Revenue forecasting foundation
- ✅ Business decision support

## 📋 Future Enhancements

- [ ] Create views for common reports
- [ ] Add stored procedures for automated analysis
- [ ] Implement triggers for data validation
- [ ] Add customer segmentation analysis
- [ ] Create dashboard queries
- [ ] Add data backup and recovery procedures
- [ ] Implement data archiving strategy

## 🔒 Database Maintenance

### Backup Database
```bash
mysqldump -u username -p pizza_sales_db > backup_pizza_sales_$(date +%Y%m%d).sql
```

### Restore Database
```bash
mysql -u username -p pizza_sales_db < backup_pizza_sales_20240622.sql
```

## 📊 Performance Tips

1. **Add Indexes** for frequently queried columns:
```sql
CREATE INDEX idx_order_date ON orders(order_date);
CREATE INDEX idx_pizza_type ON pizzas(pizza_type);
CREATE INDEX idx_pizza_size ON orders(pizza_size);
```

2. **Use EXPLAIN** to analyze query performance:
```sql
EXPLAIN SELECT * FROM orders WHERE order_date = '2024-01-15';
```

3. **Archive old data** to maintain performance:
```sql
CREATE TABLE orders_archive LIKE orders;
INSERT INTO orders_archive SELECT * FROM orders WHERE order_date < DATE_SUB(NOW(), INTERVAL 1 YEAR);
```

## 📞 Support & Documentation

- [MySQL Official Documentation](https://dev.mysql.com/doc/)
- [SQL Tutorial](https://www.w3schools.com/sql/)
- For issues, create a GitHub issue in this repository

## 📄 License

This project is licensed under the MIT License - see LICENSE file for details.

## 👤 Author

**Saireddy1904**
- GitHub: [@Saireddy1904](https://github.com/Saireddy1904)

---

**Last Updated:** June 2026

*Happy analyzing! 🍕📊*
