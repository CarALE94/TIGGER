
	SELECT 
		cliente.cli_nombre as cliente,
		sum(tipo_plan.plan_costo) as costo_plan,
		sum (producto_adicional.pro_adi_costo * detalle_factura.deta_cant)as producto,
		SUM(tipo_plan.plan_costo+(producto_adicional.pro_adi_costo * detalle_factura.deta_cant))as total,
		extract (month from ingreso_gimnasio.gim_ingreso) as mes
	FROM  detalle_factura
		INNER JOIN factura ON detalle_factura.fact_num_factura = factura.fact_num 
		INNER JOIN cliente ON cliente.cli_ced = detalle_factura.cli_ced_cliente
		INNER JOIN ingreso_gimnasio ON  ingreso_gimnasio.cli_ced_cliente = cliente.cli_ced
		INNER JOIN tipo_plan ON ingreso_gimnasio.plan_id_tipo_plan = tipo_plan.plan_id
		INNER JOIN producto_adicional ON detalle_factura.pro_adi_cod_producto_adicional = producto_adicional.pro_adi_cod
	WHERE
		extract (year from ingreso_gimnasio.gim_ingreso)=2021
	GROUP BY 
		ingreso_gimnasio.gim_ingreso, cliente.cli_nombre