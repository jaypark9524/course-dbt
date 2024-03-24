1. How many users do we have? 
Answer: 130 users

```
SELECT DISTINCT(USER_ID)
FROM DEV_DB.DBT_JAYMOLOCOCOM.USERS
```

2. On average, how many orders do we receive per hour? 
Answer: ~15 orders per hour

```
WITH hourly_orders AS (
    SELECT 
        HOUR(CREATED_AT) AS hour, COUNT(1) AS orders
    FROM DEV_DB.DBT_JAYMOLOCOCOM.ORDERS
    GROUP BY 1
)

SELECT AVG(orders) AS hourly_avg_orders
FROM hourly_orders
```

3. On average, how long does an order take from being placed to being delivered? 
Answer: 3.89 days

```
SELECT 
    AVG(TIMESTAMPDIFF(DAY, CREATED_AT, DELIVERED_AT)) AS avg_delivery_time
FROM DEV_DB.DBT_JAYMOLOCOCOM.ORDERS
```

4. How many users have only made one purchase? Two purchases? Three+ purchases? 
Answer: 25 users (1 order), 28 users (2 orders), 71 users (3+ orders)

```
WITH summary AS (
    SELECT 
        USER_ID, 
        COUNT(1) AS orders 
    FROM DEV_DB.DBT_JAYMOLOCOCOM.ORDERS
    GROUP BY 1
)

SELECT 
    COUNT_IF(orders=1) AS single_order_users,
    COUNT_IF(orders=2) AS double_order_users,
    COUNT_IF(orders>=3) AS triple_plus_order_users
FROM summary
```

5. On average, how many unique sessions do we have per hour? 
Answer: 39.5 (~40) sessions per hour

```
WITH sessions AS (
    SELECT 
        HOUR(CREATED_AT) AS hour, 
        COUNT(DISTINCT SESSION_ID) AS sessions
    FROM DEV_DB.DBT_JAYMOLOCOCOM.EVENTS
    GROUP BY 1
)

SELECT AVG(sessions) AS avg_sessions_per_hour
FROM sessions
```