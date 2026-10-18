{{ config(
    materialized='incremental',
    incremental_strategy='merge',
    unique_key=['platform', 'ad_id', 'date', 'currency_code'],
    on_schema_change='append_new_columns'
) }}
with facebook as (
    select
        'facebook'              as platform,
        ad_id,
        campaign_id,
        ad_date                 as date,
        ad_currency_code        as currency_code,
        sum(ad_spend)           as spend,
        sum(ad_impressions)     as impressions,
        sum(ad_clicks)          as clicks
    from {{ ref('int_facebook_tables_joined') }}
    {{ incremental_date_filter('ad_date') }}
    group by 1, 2, 3, 4, 5
),

snapchat as (
    select
        'snapchat'              as platform,
        ad_detail_id            as ad_id,
        campaign_id,
        ad_date                 as date,
        ad_currency_code        as currency_code,
        sum(ad_spend)           as spend,
        sum(ad_impressions)     as impressions,
        sum(ad_clicks)          as clicks
    from {{ ref('int_snapchat_tables_joined') }}
    {{ incremental_date_filter('ad_date') }}
    group by 1, 2, 3, 4, 5
),

combined as (
    select * from facebook
    union all
    select * from snapchat
)

select
    {{ dbt_utils.generate_surrogate_key(['platform', 'ad_id']) }}       as ad_platform_id,
    {{ dbt_utils.generate_surrogate_key(['platform', 'campaign_id']) }} as campaign_platform_id,
    ad_id,
    campaign_id,
    platform,
    date,
    currency_code,
    spend,
    impressions,
    clicks
from combined