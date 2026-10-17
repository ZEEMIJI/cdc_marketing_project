with source_data as (
select 
* 
from 

{{source('bronze', 'ads_stats')}}
),

formatted_data as( select cast(ad_id as string) as ad_id,
                          cast(account_id as string) as account_id,
                          cast(ad_spend as double) as ad_spend,
                          coalesce(try_cast(ad_impressions as int), 0) as ad_impressions,
                          coalesce(try_cast(ad_clicks as int), 0) as ad_clicks,
                        cast(ad_date as date) as ad_date
                FROM source_data

)

Select * from formatted_data