with source_data as (
    select 
* 
from 

{{ source('bronze', 'new_adgroup_de_randomized') }}
),

formatted_data as (select cast(ad_group_id as string) as ad_group_id,
                            cast(ad_group_name as string) as ad_group_name,
                            cast(ad_group_updated_at as timestamp) as ad_group_updated_at
                from source_data

)

select * from formatted_data