%dw 2.0
output application/json
fun trunc80 (value) = if((!isEmpty(value)) and (sizeOf(value) > 79)) value[0 to 79] else value
fun trunc255 (value) = if((!isEmpty(value)) and (sizeOf(value) > 254)) value[0 to 254] else value
---
(payload map () -> {
	"Id_GFK__c": $.id_ioc as String,
	"LastName": trunc80($.nombre) default "SIN NOMBRE",
	"Nombre_Proyecto_GFK__c": trunc255($.nombre) default "SIN NOMBRE",
	"Estado_Obra_GFK__c": $.estado_obra default "",
    "Tipo_de_Obra__c": $.tipo default "",
	"Bdata_n_pisos__c": $.pisos_totales default "",
	"N_Viviendas_Proyecto__c": $.unidades as String default "",
	"Bdata_destino_final__c": $.destino default "",
	"Detalles_del_proyecto__c": $.detalle default "",
	"Bdata_arquitecto__c": $.arquitecto default "",
    "Bdata_telefono_arquitecto__c": $.telefono default "",
    "VLC_CompaniaArquitectoGFK__c": $.compania_arquitecto default "",
    "Company": $.compania_arquitecto default "",
    "Bdata_email_arquitecto__c": $.email default "",
    "Email": $.email default "",
    "Street": $.direccion default "",
    "Comuna_Zona_de_transporte__c": $.comuna default "",
    "Region__c": $.region default ""
})