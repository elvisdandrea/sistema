<h5>{$address['address_type']}:
    <small>{$address['street_addr']}, {$address['street_number']}, {if {$address['street_additional'] != ''}}{$address['street_additional']},{/if} {$address['hood']}, {$address['city']}, {$address['zip_code']}</small>
</h5>
<input type="hidden" name="address_id" value="{$address['id']}"/>