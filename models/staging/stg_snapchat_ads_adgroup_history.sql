with source_data as (select 
* 
from 

{{ source('bronze', 'snapchat_ads_adgroup_history_new_ad_group_names') }}

),

formatted_data as (select cast( _surrogate_key as string) as surrogate_key,
                            cast(ad_group_id as string) as ad_group_id,
                            cast(campaign_id as string) as campaign_id,
                            cast(ad_group_name as string) as ad_group_name,
                            cast(ad_group_updated_at as timestamp) as ad_group_updated_at
                from source_data

)

select * from formatted_data