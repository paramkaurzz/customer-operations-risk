# Customer Operations & Risk Analytics
# Python Analysis

import pandas as pd

# Load transaction data
df = pd.read_csv("../data/customer_transactions.csv")

# Convert transaction date to datetime
df["Transaction_Date"] = pd.to_datetime(df["Transaction_Date"])

# -----------------------------
# Data Quality Checks
# -----------------------------

print("Dataset shape:")
print(df.shape)

print("\nMissing values:")
print(df.isnull().sum())

print("\nDuplicate rows:")
print(df.duplicated().sum())

# -----------------------------
# Transaction Analysis
# -----------------------------

print("\nTransaction amount statistics:")
print(df["Amount"].describe())

# -----------------------------
# High-Value Transactions
# -----------------------------

df["High_Value_Flag"] = df["Amount"] > 1500

high_value_count = df["High_Value_Flag"].sum()

high_value_value = df.loc[
    df["High_Value_Flag"],
    "Amount"
].sum()

print("\nHigh-value transactions:")
print(high_value_count)

print("\nValue of high-value transactions:")
print(round(high_value_value, 2))

# -----------------------------
# Unusual-Hour Transactions
# -----------------------------

df["Unusual_Hour_Flag"] = df["Transaction_Hour"] < 5

unusual_hour_count = df["Unusual_Hour_Flag"].sum()

print("\nUnusual-hour transactions:")
print(unusual_hour_count)

# -----------------------------
# Combined Risk Analysis
# -----------------------------

high_value_unusual = (
    df["High_Value_Flag"] &
    df["Unusual_Hour_Flag"]
)

combined_count = high_value_unusual.sum()

combined_value = df.loc[
    high_value_unusual,
    "Amount"
].sum()

print("\nHigh-value transactions during unusual hours:")
print(combined_count)

print("\nValue of high-value transactions during unusual hours:")
print(round(combined_value, 2))

# -----------------------------
# Transactions Requiring Review
# -----------------------------

df["Review_Flag"] = (
    df["High_Value_Flag"] |
    df["Unusual_Hour_Flag"]
)

review_count = df["Review_Flag"].sum()

review_value = df.loc[
    df["Review_Flag"],
    "Amount"
].sum()

print("\nTransactions requiring review:")
print(review_count)

print("\nValue of transactions requiring review:")
print(round(review_value, 2))

# -----------------------------
# Save Analyzed Dataset
# -----------------------------

df.to_csv(
    "../data/customer_transactions_analyzed.csv",
    index=False
)

print("\nAnalyzed dataset saved successfully.")