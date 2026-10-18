{% macro incremental_date_filter(source_column, target_column='date', lookback_days=7) %}
    {% if is_incremental() %}
        where {{ source_column }} >= (
            select dateadd(day, -{{ lookback_days }}, max({{ target_column }}))
            from {{ this }}
        )
    {% endif %}
{% endmacro %}