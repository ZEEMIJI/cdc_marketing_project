# Marketing Ads dbt Project

## Business objective

Build a data pipeline that takes raw Facebook Ads and Snapchat Ads data, loads it into Databricks, transforms it with dbt, and produces a unified marketing data model that both technical and non-technical users can consume.

The final data lets an analyst answer questions such as:

- How much did we spend on Facebook compared with Snapchat?
- How many impressions did each platform generate?
- How many clicks did each campaign generate?
- What is the cost per click?
- What is the cost per 1,000 impressions?
- How does campaign performance change over time?
- Which campaigns are generating the most impressions and clicks?
- How does advertising performance differ between platforms?

The data is suitable for consumption through:

- SQL / Databricks
- BI tools
- Analytics workflows
- AI-powered analytics agents such as Claude

The objective is not simply to load the data, but to build a reusable and well-designed analytical data product.

## Data flow

Source tables -> staging -> intermediate -> marts

| Layer | Folder | What it does |
|---|---|---|
| Source | `models/staging/sources.yml` | Raw Facebook and Snapchat tables already loaded in Databricks (`bronze` schema) |
| Staging | `models/staging/` | One model per source table: rename and cast columns |
| Intermediate | `models/intermediate/` | Joins each platform's stats to its ads and campaigns |
| Marts | `models/marts/` | `mart_fct_ad_performance`, `mart_dim_campaign`, `mart_dim_ad` |


## Final tables

- `mart_fct_ad_performance`: one row per platform, ad, day and currency. Incremental.
- `mart_dim_campaign`: campaign names. Join on `campaign_platform_id`.
- `mart_dim_ad`: ad names. Join on `ad_platform_id`.

Spend is in each account's own currency and is not converted, so do not sum it across currencies. Calculate cost per click as `sum(spend) / sum(clicks)`.

## How to run

1. Load the raw tables into Databricks and point `models/staging/sources.yml` at them.
2. Create a `profiles.yml` for your Databricks connection (not committed). Use `env_var('DATABRICKS_TOKEN')` for the token.
3. Install and run:

```bash
pip install -r requirements.txt
dbt deps
dbt debug
dbt build
```

`dbt build` creates all models and runs all tests.

## Documentation

Download the interactive dbt docs, then open the file in a browser: [docs/dbt_docs.html](docs/dbt_docs.html)

To regenerate it:

```bash
dbt docs generate --static
```
