--drop package note;
drop function note__new (integer,integer,varchar,varchar,varchar,timestamp,integer,varchar,integer);
drop function note__delete (integer);

drop table notes;

select acs_attribute__drop_attribute (
	   'note',
	   'TITLE'
	);

select acs_attribute__drop_attribute (
	   'note',
	   'BODY'
	);


--execute acs_object_type.drop_type('note');
select acs_object_type__drop_type(
	   'note',
	   'f'
	);

--show errors
