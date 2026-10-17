with stats as (
    select * from {{ ref('stg_facebook_ads_stats') }}
),

ads as (
    select ad_id, campaign_id,ad_name
    from {{ ref('stg_facebook_new_ads') }}
),

campaigns as (
    select campaign_id, campaign_name
    from {{ ref('stg_facebook_new_campaign') }}
),

accounts as (
    select account_id, ad_currency_code
    from {{ ref('stg_facebook_new_account') }}
)

select
    s.ad_id,
    a.ad_name,
    s.ad_date,
    a.campaign_id,
    c.campaign_name,
    acc.ad_currency_code,
    s.ad_spend,
    s.ad_impressions,
    s.ad_clicks  
from stats s
left join ads a         on s.ad_id = a.ad_id
left join campaigns c   on a.campaign_id = c.campaign_id
left join accounts acc  on s.account_id = acc.account_id