--drop functions
drop function note__new (integer,integer,varchar,varchar,varchar,timestamp,integer,varchar,integer);
drop function note__delete (integer);

--drop permissions
delete from acs_permissions where object_id in (select note_id from notes);

--drop objects
delete from acs_objects where object_type='note';

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
	   'f'
	);

