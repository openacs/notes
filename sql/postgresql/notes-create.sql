--
-- packages/notes/sql/notes-create.sql
--
-- @author rhs@mit.edu
-- @creation-date 2000-10-22
-- @cvs-id $Id$
--
-- openacs port: vinod kurup vkurup@massmed.org
--

create function inline_0 ()
returns integer as '
begin
    PERFORM acs_object_type__create_type (
    ''note'',                  -- object_type
    ''Note'',                  -- pretty_name
    ''Notes'',                 -- pretty_plural
    ''acs_object'',            -- supertype
    ''notes'',                 -- table_name
    ''note_id'',               -- id_column
    null,                      -- package_name
    ''f'',                     -- abstract_p
    null,                      -- type_extension_table
    ''note.name''              -- name_method
    );

    return 0;
end;' language 'plpgsql';

select inline_0 ();

drop function inline_0 ();

create function inline_1 ()
returns integer as '
begin
    PERFORM acs_attribute__create_attribute (
      ''note'',                -- object_type
      ''title'',               -- attribute_name
      ''string'',              -- datatype
      ''Title'',               -- pretty_name
      ''Titles'',              -- pretty_plural
      null,                    -- table_name
      null,                    -- column_name
      null,                    -- default_value
      1,                       -- min_n_values
      1,                       -- max_n_values
      null,                    -- sort_order
      ''type_specific'',       -- storage
      ''f''                    -- static_p
    );

    PERFORM acs_attribute__create_attribute (
      ''note'',                -- object_type
      ''body'',                -- attribute_name
      ''string'',              -- datatype
      ''Body'',                -- pretty_name
      ''Bodies'',              -- pretty_plural
      null,                    -- table_name
      null,                    -- column_name
      null,                    -- default_value
      1,                       -- min_n_values
      1,                       -- max_n_values
      null,                    -- sort_order
      ''type_specific'',       -- storage
      ''f''                    -- static_p
    );

    return 0;
end;' language 'plpgsql';

select inline_1 ();

drop function inline_1 ();

create table notes (
    note_id    integer 
               constraint notes_note_id_fk
               references acs_objects(object_id) 
               constraint notes_note_id_pk
               primary key,
    title      varchar(255) 
               constraint notes_title_nn
               not null,
    body       text
);

select define_function_args('note__new','note_id,title,body,object_type;note,creation_date;now,creation_user,creation_ip,context_id');

create function note__new (integer,varchar,varchar,varchar,timestamptz,integer,varchar,integer)
returns integer as '
declare
  p_note_id                    alias for $1;       -- default null
  p_title                      alias for $2;
  p_body                       alias for $3;
  p_object_type                alias for $4;       -- default ''note''
  p_creation_date              alias for $5;        -- default now()
  p_creation_user              alias for $6;        -- default null
  p_creation_ip                alias for $7;        -- default null
  p_context_id                 alias for $8;        -- default null
  v_note_id                    notes.note_id%TYPE;
begin
    v_note_id := acs_object__new (
        p_note_id,
        p_object_type,
        p_creation_date,
        p_creation_user,
        p_creation_ip,
        p_context_id
    );

    insert into notes
      (note_id, title, body)
    values
      (v_note_id, p_title, p_body);

    PERFORM acs_permission__grant_permission(
          v_note_id,
          p_creation_user,
          ''admin''
    );

    return v_note_id;

end;' language 'plpgsql';

select define_function_args('note__del','note_id');

create function note__del (integer)
returns integer as '
declare
  p_note_id                alias for $1;
begin
    delete from acs_permissions
           where object_id = p_note_id;

    delete from notes
           where note_id = p_note_id;

    raise NOTICE ''Deleting note...'';
    PERFORM acs_object__delete(p_note_id);

    return 0;

end;' language 'plpgsql';

create function note__name (integer)
returns varchar as '
declare
    p_note_id      alias for $1;
    v_note_name    notes.title%TYPE;
begin
    select title into v_note_name
        from notes
        where note_id = p_note_id;

    return v_note_name;
end;
' language 'plpgsql';


-- neophytosd
\i notes-sc-create.sql
