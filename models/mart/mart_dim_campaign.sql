with campaigns as (
    select 'facebook' as platform, campaign_id, campaign_name
    from {{ ref('stg_facebook_new_campaign') }}
    union all
    select 'snapchat' as platform, campaign_id, campaign_name
    from {{ ref('stg_snapchat_ads_campaign_history') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['platform', 'campaign_id']) }} as campaign_platform_id,
    campaign_id,
    campaign_name
from campaigns