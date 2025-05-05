-- extracting certain fields from the database, ensuring that only successful transactions are returned
SELECT 
  u.id AS "Customer ID", 
  CONCAT(u.first_name, ' ', u.last_name) AS "Customer Name", 
  u.created_at AS "Sign-Up Date",
  u.updated_at AS "KYC Completed Date", 
  u.ladder_use_option AS "Investment Type", 
  DATE_TRUNC('month', u.created_at) AS "Sign-Up Cohort",
  u.is_verified AS "KYC Cohort", 
  t.id AS "Transaction ID", 
  t.tx_type AS "Transaction Type", 
  t.usd_amount AS "USD Amount", 
  t.created_at AS "Transaction Date", 
  t.amount AS "GHS Amount", 
  t.exchange_rate AS "Exchange Rate", 
  DATE_TRUNC('month', t.created_at) AS "Transaction Cohort", 
  EXTRACT(WEEK FROM t.created_at) AS "Week Number of Transaction",
  a.name AS "Asset Type", 
  ip.maturity_date AS "Maturity Date"
FROM transactions AS t
FULL JOIN investment_plans AS ip ON t.investment_plan_id = ip.id
FULL JOIN assets AS a ON ip.asset_id = a.id
FULL JOIN users AS u ON ip.user_id = u.id
WHERE t.status = 'success';