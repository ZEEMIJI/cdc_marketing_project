with ads as (
    select 'facebook' as platform, ad_id, ad_name
    from {{ ref('stg_facebook_new_ads') }}
    union all
    select 'snapchat' as platform, ad_id, ad_name
    from {{ ref('stg_snapchat_ads_ad_history') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['platform', 'ad_id']) }} as ad_platform_id,
    ad_id,
    ad_name
from ads