--
-- packages/notes/sql/notes-create.sql
--
-- @author rhs@mit.edu
-- @creation-date 2000-10-22
-- @cvs-id $Id$
--

create function inline_0 ()
returns integer as '
begin
    PERFORM acs_object_type__create_type (
	''note'',
	''Note'',
	''Notes'',
	''acs_object'',
	''notes'',
	''note_id'',
	null,
	''f'',
	null,
	null
	);

    return 0;
end;' language 'plpgsql';

select inline_0 ();

drop function inline_0 ();

--begin
--  acs_object_type.create_type (
--    supertype => 'acs_object',
--    object_type => 'note',
--    pretty_name => 'Note',
--    pretty_plural => 'Notes',
--    table_name => 'NOTES',
--    id_column => 'NOTE_ID'
--  );
--end;
--/
--show errors;

create function inline_1 ()
returns integer as '
begin
    PERFORM acs_attribute__create_attribute (
	  ''note'',
	  ''TITLE'',
	  ''string'',
	  ''Title'',
	  ''Titles'',
	  null,
	  null,
	  null,
	  1,
	  1,
	  null,
	  ''type_specific'',
	  ''f''
	);

    PERFORM acs_attribute__create_attribute (
	  ''note'',
	  ''BODY'',
	  ''string'',
	  ''Body'',
	  ''Bodies'',
	  null,
	  null,
	  null,
	  1,
	  1,
	  null,
	  ''type_specific'',
	  ''f''
	);

    return 0;
end;' language 'plpgsql';

select inline_1 ();

drop function inline_1 ();

--declare
--  attr_id acs_attributes.attribute_id%TYPE;
--
--begin
--  attr_id := acs_attribute.create_attribute (
--    object_type => 'note',
--    attribute_name => 'TITLE',
--    pretty_name => 'Title',
--    pretty_plural => 'Titles',
--    datatype => 'string'
--  );
--
--  attr_id := acs_attribute.create_attribute (
--    object_type => 'note',
--    attribute_name => 'BODY',
--    pretty_name => 'Body',
--    pretty_plural => 'Bodies',
--    datatype => 'string'
--  );
--end;
--/
--show errors;

create table notes (
    note_id    integer references acs_objects(object_id) primary key,
    owner_id   integer references users(user_id),
    title      varchar(255) not null,
    body       varchar(1024)
);

create function note__new (integer,integer,varchar,varchar,varchar,timestamp,integer,varchar,integer)
returns integer as '
declare
  new__note_id					alias for $1;       -- default null
  new__owner_id					alias for $2;       -- default null
  new__title					alias for $3;
  new__body						alias for $4;
  new__object_type				alias for $5;       -- default ''note''
  new__creation_date			alias for $6;		-- default now()
  new__creation_user			alias for $7;		-- default null
  new__creation_ip				alias for $8;		-- default null
  new__context_id				alias for $9;		-- default null
  v_note_id						notes.note_id%TYPE;
begin
	v_note_id := acs_object__new (
		new__note_id,
		new__object_type,
		new__creation_date,
		new__creation_user,
		new__creation_ip,
		new__context_id
	);

	insert into notes
	  (note_id, owner_id, title, body)
	values
	  (v_note_id, new__owner_id, new__title, new__body);

	PERFORM acs_permission__grant_permission(
          v_note_id,
          new__owner_id,
          ''admin''
    );

	return v_note_id;

end;' language 'plpgsql';

create function note__delete (integer)
returns integer as '
declare
  delete__note_id				alias for $1;
begin
    delete from acs_permissions
		   where object_id = delete__note_id;

	delete from notes
		   where note_id = delete__note_id;

	raise NOTICE ''Deleting note...'';
	PERFORM acs_object__delete(delete__note_id);

	return 0;

end;' language 'plpgsql';

--create or replace package note
--as
--    function new (
--		note_id             in notes.note_id%TYPE default null,
--		owner_id            in notes.owner_id%TYPE default null,
--		title               in notes.title%TYPE,
--		body                in notes.body%TYPE,
--		object_type         in acs_object_types.object_type%TYPE default 'note',
--		creation_date       in acs_objects.creation_date%TYPE default sysdate,
--		creation_user       in acs_objects.creation_user%TYPE default null,
--		creation_ip         in acs_objects.creation_ip%TYPE default null,
--		context_id          in acs_objects.context_id%TYPE default null
--    ) return notes.note_id%TYPE;
--
--    procedure delete (
--		note_id				in notes.note_id%TYPE
--    );
--end note;
--/
--show errors
--
--create or replace package body note
--as
--    function new (
--        note_id             in notes.note_id%TYPE default null,
--        owner_id            in notes.owner_id%TYPE default null,
--        title               in notes.title%TYPE,
--        body                in notes.body%TYPE,
--        object_type         in acs_object_types.object_type%TYPE default 'note',
--        creation_date       in acs_objects.creation_date%TYPE default sysdate,
--        creation_user       in acs_objects.creation_user%TYPE default null,
--        creation_ip         in acs_objects.creation_ip%TYPE default null,
--        context_id          in acs_objects.context_id%TYPE default null
--    ) return notes.note_id%TYPE
--    is
--        v_note_id integer;
--     begin
--        v_note_id := acs_object.new (
--            object_id => note_id,
--            object_type => object_type,
--            creation_date => creation_date,
--            creation_user => creation_user,
--            creation_ip => creation_ip,
--            context_id => context_id
--         );
--
--         insert into notes
--          (note_id, owner_id, title, body)
--         values
--          (v_note_id, owner_id, title, body);
--
--         return v_note_id;
--     end new;
--
--     procedure delete (
--         note_id      in notes.note_id%TYPE
--     )
--     is
--     begin
--         delete from notes
--         where note_id = note.delete.note_id;
--
--         acs_object.delete(note_id);
--     end delete;
--
--end note;
--/
--show errors;

