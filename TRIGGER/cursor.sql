--Un cursor el cual se defina por cada cliente el nombre, el apellido, el número de entrenadores
--por los cuales ha sido atendido la fecha en la que que ingreso la primera vez y la última fecha
--en la que estuvo. 
do 
	$$
	DECLARE 
		datos RECORD;
		cur_datos  cursor for SELECT 
		  min(ingreso_gimnasio.gim_ingreso)as fechacomienzo,
		  max(ingreso_gimnasio.gim_ingreso)as fechaultima,
		  cliente.cli_nombre,
		  cliente.cli_apellido,
		  COUNT(tipo_cargo.tipo_detalle) AS entrenadores
		FROM 
		  public.personal
		  INNER JOIN public.rutina_establecida ON  rutina_establecida.per_code_personal = personal.per_code
		  INNER JOIN public.rutina ON  rutina.ruti_code = rutina_establecida.ruti_code_rutina
		  INNER JOIN public.cliente ON cliente.ruti_code_rutina = rutina.ruti_code
		  INNER JOIN public.ingreso_gimnasio ON cliente.cli_ced = ingreso_gimnasio.cli_ced_cliente 
		  INNER JOIN public.tipo_cargo ON personal.tipo_id_tipo_cargo = tipo_cargo.tipo_id
		GROUP BY  
		  cliente.cli_nombre, 
		  cliente.cli_apellido,
		  tipo_cargo.tipo_detalle;
	BEGIN	
		OPEN cur_datos;
		FETCh cur_datos INTO datos;
		while (found) loop 
		RAISE NOTICE 
		'
		NOMBRE DEL CLIENTE: % 
		APELLIDO DEL CLIENTE: % 
		TOTAL DE ENTRENADORES: % 
		FECHA EN LA QUE INGRESO LA PRIMERA VEZ: % 
		FECHA DE LA ULTIMA VEZ QUE INGRESO AL GIMNASIO: % 
		',
		datos.cli_nombre, datos.cli_apellido, datos.entrenadores, datos.fechacomienzo, datos.fechaultima;
		FETCh cur_datos INTO datos;
	end loop;	
	end $$
	Language 'plpgsql';
	
	








