with source_data as (select 
* 
from 

{{ source('bronze', 'snapchat_ads_campaign_history_new_campaign_names') }}

),

formatted_data as (select cast(campaign_id as string) as campaign_id,
                            cast(campaign_name as string) as campaign_name,
                            cast(account_id as string) as account_id
                from source_data

)

select * from formatted_data