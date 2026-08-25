{{
    config 
    (
        materialized = 'table'
    )
}}

with session_src as 
(
    select 
    SESSION_ID,
    USER_ID,
    BROWSER,
    DEVICE_TYPE,
    b.country_name as COUNTRY_NAME,
    b.continent as CONTINENT,
    b.currency as CURRENCY,
    START_TIME,
    END_TIME,
    PAGES_VISITED,
    CURRENT_TIMESTAMP AS INSERT_DTS
    from {{source('session','SESSION_SRC')}} a 
    left join {{ref('country_code')}} b
    on a.country_code = b.country_code
)

SELECT * FROM session_src