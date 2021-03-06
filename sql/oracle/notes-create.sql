--
-- packages/notes/sql/notes-create.sql
--
-- @author rhs@mit.edu
-- @creation-date 2000-10-22
-- @cvs-id $Id$
--

begin
  acs_object_type.create_type (
    supertype => 'acs_object',
    object_type => 'note',
    pretty_name => 'Note',
    pretty_plural => 'Notes',
    table_name => 'notes',
    id_column => 'note_id',
	name_method => 'note.name'
  );
end;
/
show errors;

declare
  attr_id acs_attributes.attribute_id%TYPE;
begin
  attr_id := acs_attribute.create_attribute (
    object_type => 'note',
    attribute_name => 'title',
    pretty_name => 'Title',
    pretty_plural => 'Titles',
    datatype => 'string'
  );

  attr_id := acs_attribute.create_attribute (
    object_type => 'note',
    attribute_name => 'body',
    pretty_name => 'Body',
    pretty_plural => 'Bodies',
    datatype => 'string'
  );
end;
/
show errors;

create table notes (
    note_id    integer references acs_objects(object_id) primary key,
    title      varchar(255) not null,
    body       varchar(4000)
);

create or replace package note
as
    function new (
        note_id             in notes.note_id%TYPE default null,
	title               in notes.title%TYPE,
	body                in notes.body%TYPE,
	object_type         in acs_object_types.object_type%TYPE
			       default 'note',
	creation_date       in acs_objects.creation_date%TYPE
                               default sysdate,
        creation_user       in acs_objects.creation_user%TYPE
                               default null,
        creation_ip         in acs_objects.creation_ip%TYPE default null,
        context_id          in acs_objects.context_id%TYPE default null
    ) return notes.note_id%TYPE;

    procedure del (
         note_id      in notes.note_id%TYPE
    );

	function name (
		note_id			in notes.note_id%TYPE
	) return notes.title%TYPE;
end note;
/
show errors

create or replace package body note
as
    function new (
        note_id             in notes.note_id%TYPE default null,
        title               in notes.title%TYPE,
        body                in notes.body%TYPE,
        object_type         in acs_object_types.object_type%TYPE
			       default 'note',
        creation_date       in acs_objects.creation_date%TYPE
                                default sysdate,
        creation_user       in acs_objects.creation_user%TYPE
                                default null,
        creation_ip         in acs_objects.creation_ip%TYPE default null,
        context_id          in acs_objects.context_id%TYPE default null
    ) return notes.note_id%TYPE
    is
        v_note_id integer;
     begin
        v_note_id := acs_object.new (
            object_id => note_id,
            object_type => object_type,
            creation_date => creation_date,
            creation_user => creation_user,
            creation_ip => creation_ip,
            context_id => context_id
         );

         insert into notes
          (note_id, title, body)
         values
          (v_note_id, title, body);

		 acs_permission.grant_permission(
           object_id => v_note_id,
           grantee_id => creation_user,
           privilege => 'admin'
         );

         return v_note_id;
     end new;

     procedure del (
         note_id      in notes.note_id%TYPE
     )
     is
     begin
		 delete from acs_permissions
		 where object_id = note.del.note_id;
         
         delete from notes
         where note_id = note.del.note_id;

         acs_object.del(note_id);
     end del;

	 function name (
		note_id			in notes.note_id%TYPE
	 ) return notes.title%TYPE
	 is
		v_note_name		notes.title%TYPE;
	 begin
		select title into v_note_name
			from notes
			where note_id = name.note_id;

		return v_note_name;
	 end name;
end note;
/
show errors;
