---Trigger que impida utilizar una maquina si al menos en tres meses no haya tenido mantenimiento

create or replace function usarmaquina()
returns trigger as $usarmaquina$
	declare 
	maquina int;
begin
SELECT   maq_nombre, mant_fecha INTO maquina FROM maquina
  INNER JOIN mantenimiento ON maquina.maq_cod = mantenimiento.maq_cod_maquina
  WHERE (maquina.maq_nombre=NEW.maquina.maq_nombre) AND (mantenimiento.mant_fecha<NEW.mantenimiento.mant_fecha);
	if (maquina > 0) then /**/
	  raise exception 'Esta maquina no ha tenido mantenimiento hace mas de tres meses';
	/*se indica el mensaje que se mostrara ante el susceso*/
	end if;
	return new;/**/
end;
$usarmaquina$
Language plpgsql;	
		 

/*trigger*/
CREATE trigger control_de_uso before insert
	on USO_MAQUINA  for each row
	execute procedure usarmaquina();


INSERT INTO USO_MAQUINA (USO_ID, MAQ_COD_MAQUINA, CLI_CED_CLIENTE) VALUES 
(10, 1, 1350696397);











