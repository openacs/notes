-- notes
-- drop script
-- Vinod Kurup, vkurup@massmed.org
--

-- neophytosd
\i notes-sc-drop.sql 

--drop functions
drop function note__new (integer,varchar,varchar,varchar,timestamptz,integer,varchar,integer);
drop function note__del(integer);
drop function note__name (integer);

--drop permissions
delete from acs_permissions where object_id in (select note_id from notes);

--drop objects
create function inline_0 ()
returns integer as '
declare
	object_rec		record;
begin
	for object_rec in select object_id from acs_objects where object_type=''note''
	loop
		perform acs_object__delete( object_rec.object_id );
	end loop;

	return 0;
end;' language 'plpgsql';

select inline_0();
drop function inline_0();

--drop table
drop table notes;

--drop attributes
select acs_attribute__drop_attribute (
	   'note',
	   'TITLE'
	);

select acs_attribute__drop_attribute (
	   'note',
	   'BODY'
	);


--drop type
select acs_object_type__drop_type(
	   'note',
	   't'
	);

