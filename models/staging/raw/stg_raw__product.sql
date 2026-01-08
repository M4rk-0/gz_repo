with 

source as (

    select * from {{ source('raw', 'product') }}

),

renamed as (

    select
        products_id,
        purchase_price

    from source

)

select * from renamed