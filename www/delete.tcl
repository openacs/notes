# packages/notes/www/delete.tcl

ad_page_contract {

  @author rhs@mit.edu
  @creation-date 2000-10-23
  @cvs-id $Id$
} {
  note_id:integer,notnull
}

ad_require_permission $note_id delete

db_exec_plsql note_delete {
  begin
    note.del(:note_id);
  end;
}

ad_returnredirect "./"
