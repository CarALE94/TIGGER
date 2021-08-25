--Un procedimiento almacenado que reciba un parámetro de entrada el cual es el entrenador
--y con ello muestre el total de las rutinas que ha realizado. 

create or replace function mostrarrutina(integer)
returns  text
as $mostrarrutina$
	declare 
	 entre alias for $1;
	 totalrutiesta int;
begin
	select count(rutina_establecida.ruti_code_rutina) into  totalrutiesta from rutina_establecida 
		WHERE rutina_establecida.per_code_personal = entre group by rutina_establecida.ruti_code_rutina;
			return totalrutiesta;
end;
$mostrarrutina$
Language plpgsql;

SELECT mostrarrutina(1839372111)