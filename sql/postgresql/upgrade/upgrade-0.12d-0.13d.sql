select define_function_args('note__new','note_id,title,body,object_type;note,creation_date;now,creation_user,creation_ip,context_id');

create or replace function note__new (integer,varchar,varchar,varchar,timestamptz,integer,varchar,integer)
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

alter table notes drop column owner_id;
