# packages/notes/www/delete.tcl

ad_page_contract {

  @author rhs@mit.edu
  @creation-date 2000-10-23
  @cvs-id $Id$
} {
  note_id:integer,notnull
}

ad_require_permission $note_id delete

db_dml note_delete {
  begin
    delete from acs_permissions
    where object_id = :note_id;

    note.delete(:note_id);
  end;
}

ad_returnredirect "."
