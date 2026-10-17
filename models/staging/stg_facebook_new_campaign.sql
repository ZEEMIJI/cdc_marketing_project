with source_data as (select 
* 
from 

{{ source('bronze', 'new_campaign_de_randomized') }}

),

formatted_data as (select cast(campaign_id as string) as campaign_id,
                            cast(campaign_name as string) as campaign_name,
                            cast(campaign_updated_at as timestamp) as campaign_updated_at
                from source_data

)

select * from formatted_data