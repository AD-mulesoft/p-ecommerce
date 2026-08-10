%dw 2.0
output application/json
//var random = randomInt(9999999999999) as String
---
((payload.orders map () -> {
	"account_Rut__c": ($.note_attributes filter (note,noteindex) -> (note.name == "company"))[0]."value" default "",
	"account_Name": if ((($.note_attributes filter (note,noteindex) -> (note.name == "tipo_documento"))[0]."value") == "boleta" ) (($.customer.first_name default "") ++ " " ++ ($.customer.last_name default ""))
					else
					($.note_attributes filter (note,noteindex) -> (note.name == "razon_social"))[0]."value" default "",
	"account_Nombre_de_Fantasia__c":  if ((($.note_attributes filter (note,noteindex) -> (note.name == "tipo_documento"))[0]."value") == "boleta" ) (($.customer.first_name default "") ++ " " ++ ($.customer.last_name default ""))
					else
					($.note_attributes filter (note,noteindex) -> (note.name == "razon_social"))[0]."value" default "",
	"account_Concepto_de_B_squeda_1__c": if ((($.note_attributes filter (note,noteindex) -> (note.name == "tipo_documento"))[0]."value") == "boleta" ) (($.customer.first_name default "") ++ " " ++ ($.customer.last_name default ""))
					else
					($.note_attributes filter (note,noteindex) -> (note.name == "razon_social"))[0]."value" default "",
	"account_Pais__c": $.billing_address.country default "",
	"account_Calle_Numero__c": if ((($.note_attributes filter (note,noteindex) -> (note.name == "tipo_documento"))[0]."value") == "boleta" ) (($.shipping_address.address1 default "") ++ " " ++ ($.shipping_address.address2 default ""))
					else
					($.note_attributes filter (note,noteindex) -> (note.name == "direccion_factura"))[0]."value" default "",
	"account_Global_Comuna_Zona_de_transporte__c": if ((($.note_attributes filter (note,noteindex) -> (note.name == "tipo_documento"))[0]."value") == "boleta" ) ($.shipping_address.city default "") else
					($.note_attributes filter (note,noteindex) -> (note.name == "comuna_factura"))[0]."value" default "",
	"account_Incoterms_parte_2__c": if ((($.note_attributes filter (note,noteindex) -> (note.name == "tipo_documento"))[0]."value") == "boleta" ) ($.shipping_address.city default "") else
					($.note_attributes filter (note,noteindex) -> (note.name == "comuna_factura"))[0]."value" default "",
	"flagBoletaFactura": if ((($.note_attributes filter (note,noteindex) -> (note.name == "tipo_documento"))[0]."value") == "boleta" ) "boleta" else "factura",
	
	"contact_FirstName": $.customer.first_name default "",
	"contact_LastName": $.customer.last_name default "",
	"contact_Email": $.customer.email default "",
	"contact_MobilePhone": $.customer.phone default "",
	"contact_Phone": $.customer.default_address.phone default "",
	
	"tiendaObra_Name": if ((($.note_attributes filter (note,noteindex) -> (note.name == "tipo_documento"))[0]."value") == "boleta" ) (($.customer.first_name default "") ++ " " ++ ($.customer.last_name default "") ++ " - " ++ ($.shipping_address.city default ""))
					else
					(($.note_attributes filter (note,noteindex) -> (note.name == "razon_social"))[0]."value" default "" ++ " - " ++ ($.shipping_address.city default "")),
	"tiendaObra_Nombre_de_Fantasia__c": if ((($.note_attributes filter (note,noteindex) -> (note.name == "tipo_documento"))[0]."value") == "boleta" ) (($.customer.first_name default "") ++ " " ++ ($.customer.last_name default ""))
					else
					($.note_attributes filter (note,noteindex) -> (note.name == "razon_social"))[0]."value" default "",
	"tiendaObra_RUT__c": ($.note_attributes filter (note,noteindex) -> (note.name == "company"))[0]."value" default "",
	"tiendaObra_Calle_Numero__c": (($.shipping_address.address1 default "") ++ " " ++ ($.shipping_address.address2 default "")),
	"tiendaObra_Global_Comuna_Zona_de_transporte__c": $.shipping_address.city default "",
	"tiendaObra_Pais__c": $.shipping_address.country default "",
	"tienda_ShippingAdress": ($.note_attributes filter (note,noteindex) -> (note.name == "direccion_factura"))[0]."value" default "",


	"opportunity_Id_Commerce__c": $.id as String,
	"opportunity_Name": $.name default "",
	"opportunity_Fecha_Oferta__c": $.created_at as DateTime,
	"opportunity_CloseDate": $.created_at as DateTime,
	"opportunity_CurrencyIsoCode": $.currency default "",


	"quote_VCPQ_Id_Commerce__c": $.id as String,
	"quote_VCPQ_NombreCotizacion__c": $.name default "",
	"quote_CurrencyIsoCode": $.currency default "",
	"quote_VCPQ_Fecha_Oferta__c": $.created_at as DateTime,
	"quote_VCPQ_FechaEmisionPago__c": $.processed_at as DateTime,
	"quote_VCPQ_FechaSolicitadaEntrega__c": $.created_at as DateTime + |P2D|,
	"quote_VCPQ_TipoDocumento__c": ($.note_attributes filter (note,noteindex) -> (note.name == "tipo_documento"))[0]."value" default "",
	"quote_VCPQ_CondicionPagoWorkcenter__c": $.payment_gateway_names[0] default "",
	"VCPQ_ObservacionesEntregaWorkcenter__c": $.note,
	"VCPQ_InformacionPago__c": $.transactions[0].payment_id,
	"VCPQ_FechaEmisionPago__c": $.transactions[0].processed_at,
//	"quote_VCPQ_RegionFlete__c": p('ecommerce.xRef.province_code_QPC_' ++ $.shipping_address.province_code default "") default "",
//	"quote_SBQQ__BillingCountry__c": $.billing_address.country default "",
//	"quote_SBQQ__BillingCity__c": p('ecommerce.xRef.province_code_' ++ $.billing_address.province_code default "") default "",
//	"quote_SBQQ__BillingState__c": p('ecommerce.xRef.province_code_' ++ $.billing_address.province_code default "") default "",
//	"quote_SBQQ__BillingStreet__c": $.billing_address.address1 default "",
//	"quote_SBQQ__BillingPostalCode__c": $.billing_address.zip default "",
//	"quote_SBQQ__ShippingCountry__c": $.shipping_address.country default "",
//	"quote_SBQQ__ShippingCity__c": p('ecommerce.xRef.city_' ++ $.shipping_address.province default "") default "",
//	"quote_SBQQ__ShippingState__c": p('ecommerce.xRef.province_code_' ++ $.shipping_address.province_code default "") default "",
//	"quote_SBQQ__ShippingStreet__c": $.shipping_address.address1 default "",
//	"quote_SBQQ__ShippingPostalCode__c": $.shipping_address.zip default "",


	"quoteItemLine": $.line_items map (line,lineindex) -> {
		"VCPQ_Id_Commerce__c": line.id as String default "",
	    "SBQQ__Quote__r.VCPQ_Id_Commerce__c": $.id as String,
	    "SBQQ__Product__r.Id_Commerce__c": line.product_id as String default "",
	    "SBQQ__Description__c": line.title default "",
	    "SBQQ__Quantity__c": line.quantity as String default "",
	    "SBQQ__PriorQuantity__c": line.quantity as String default "",
	    "SBQQ__NetPrice__c": line.price default "",
	    "SBQQ__ListPrice__c": line.price default "",
	    "SBQQ__OriginalPrice__c": line.price default "",
	    "SBQQ__AdditionalDiscountAmount__c": line.discount_allocations[0].amount default "0",
        "VCPQ_OriginalDiscountAmount__c": line.discount_allocations[0].amount default "0",
	    "CurrencyIsoCode": $.currency default ""
	},


	"quoteShippingLine": $.shipping_lines map (line,lineindex) -> {
		"VCPQ_Id_Commerce__c": line.id as String default "",
		"SBQQ__Quote__r.VCPQ_Id_Commerce__c": $.id as String,
	    "SBQQ__ListPrice__c": line.price default "",
	    "SBQQ__NetPrice__c": line.price default "",
	    "SBQQ__OriginalPrice__c": line.price default "",
	    "SBQQ__Description__c": line.title default "",
	    "SBQQ__AdditionalDiscountAmount__c": line.discount_allocations[0].amount default "0",
        "VCPQ_OriginalDiscountAmount__c": line.discount_allocations[0].amount default "0",
        "CurrencyIsoCode": $.currency default ""
	}

}) filter (!isEmpty($.account_Rut__c) and !isEmpty($.account_Name))) orderBy ($.opportunity_Id_Commerce__c)