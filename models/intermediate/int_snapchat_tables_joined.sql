-- models/intermediate/int_snapchat_tables__joined.sql
with stats as (
    select * from {{ ref('stg_snapchat_ads_stats') }}
),

ads as (
    select ad_id, ad_group_id, ad_name
    from {{ ref('stg_snapchat_ads_ad_history') }}
),

ad_groups as (
    select ad_group_id, campaign_id
    from {{ ref('stg_snapchat_ads_adgroup_history') }}
    qualify row_number() over (
        partition by ad_group_id
        order by ad_group_updated_at desc
    ) = 1
),

campaigns as (
    select campaign_id, campaign_name
    from {{ ref('stg_snapchat_ads_campaign_history') }}
)

select
    s.ad_detail_id,
    a.ad_name,
    s.ad_date,
    s.ad_country,
    s.ad_currency_code,
    s.ad_spend,
    s.ad_impressions,
    s.ad_clicks,
    g.campaign_id,
    c.campaign_name
from stats s
left join ads a         on s.ad_detail_id = a.ad_id
left join ad_groups g   on a.ad_group_id = g.ad_group_id
left join campaigns c   on g.campaign_id = c.campaign_id