with source_data as (select 
* 
from 

{{ source('bronze', 'snapchat_ads_ad_history_new_ad_names') }}

),

formatted_data as (select cast(ad_id as string) as ad_id,
                            cast(ad_group_id as string) as ad_group_id,
                            cast(ad_name as string) as ad_name,
                            cast(ad_detail_updated_at as timestamp) as ad_detail_updated_at
                from source_data

)

select * from formatted_data