%dw 2.0
output application/json
fun trunc40 (value) = if((!isEmpty(value)) and (sizeOf(value) > 39)) value[0 to 39] else value
---
(payload.checkouts map () -> {
	"Id_Commerce__c": $.id as String,
	"FirstName": trunc40($.customer.first_name) default "SIN NOMBRE",
	"LastName": trunc40($.customer.last_name) default "SIN APELLIDO",
	"Email": $.customer.email default "",
	"MobilePhone": $.customer.phone default "",
    "Company": $.customer.default_address.company default "",
	"LeadSource": p('ecommerce.xRef.source_name_' ++ $.source_name default "") default "",
	"State": p('ecommerce.xRef.province_code_' ++ $.shipping_address.province_code default "") default "",
	"Monto_Total__c": $.total_price default "",
	"CurrencyIsoCode": $.currency default "",
	"Street": $.customer.default_address.address1 default "",
	"City": $.customer.default_address.city default "",
	"Country": $.customer.default_address.country default "",
	"Description": (($.line_items map (line,index) -> ("SKU: " ++ line.sku ++ " - Cantidad: " ++ line.quantity)) joinBy (", ")) default ""
}) orderBy($.Id_Commerce__c)