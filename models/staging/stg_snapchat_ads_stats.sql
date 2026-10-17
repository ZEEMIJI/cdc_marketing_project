with source_data as (select 
* 
from 

{{ source('bronze', 'snapchat_ads_stats') }}

),

formatted_data as (select cast(ad_detail_id as string) as ad_detail_id,
                            upper(cast(ad_currency_code as string)) as ad_currency_code,
                            upper(cast(ad_country as string)) as ad_country,
                            cast(ad_spend as double) as ad_spend,
                            coalesce(try_cast(ad_impressions as int),0) as ad_impressions,
                            coalesce(try_cast(ad_clicks as int),0) as ad_clicks,
                            cast(ad_date as date) as ad_date
                    from source_data

)

select * from formatted_data