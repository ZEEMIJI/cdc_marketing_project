with staging as (
    select 'facebook' as platform,
           sum(ad_spend) as spend,
           sum(ad_impressions) as impressions,
           sum(ad_clicks) as clicks
    from {{ ref('stg_facebook_ads_stats') }}
    union all
    select 'snapchat' as platform,
           sum(ad_spend),
           sum(ad_impressions),
           sum(ad_clicks)
    from {{ ref('stg_snapchat_ads_stats') }}
),

gold as (
    select platform,
           sum(spend) as spend,
           sum(impressions) as impressions,
           sum(clicks) as clicks
    from {{ ref('mart_fct_ads_performance_daily') }}
    group by 1
)

select
    s.platform,
    s.spend as staging_spend, g.spend as gold_spend,
    s.impressions as staging_impressions, g.impressions as gold_impressions,
    s.clicks as staging_clicks, g.clicks as gold_clicks
from staging s
left join gold g on s.platform = g.platform
where g.platform is null
   or abs(s.spend - g.spend) > 0.01
   or s.impressions <> g.impressions
   or s.clicks <> g.clicks