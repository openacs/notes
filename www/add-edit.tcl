# packages/notes/www/add-edit.tcl

ad_page_contract {

  @author rhs@mit.edu
  @creation-date 2000-10-23
  @cvs-id $Id$
} {
	note_id:integer,notnull,optional
	{title:html,notnull,optional ""}
	{body ""}
} -properties {
	context_bar:onevalue
}

set package_id [ad_conn package_id]

if {[info exists note_id]} {
	ad_require_permission $note_id write

	set context_bar [ad_context_bar "Edit Note"]
} else {
	ad_require_permission $package_id create

	set context_bar [ad_context_bar "New Note"]
}

template::form create new_note

if {[template::form is_request new_note] && [info exists note_id]} {

  template::element create new_note note_id \
      -widget hidden \
      -datatype number \
      -value $note_id

  db_1row note_select {
    select title, body
    from notes
    where note_id = :note_id
  }
}

template::element create new_note title \
    -datatype text \
    -label "Title" \
    -html { size 20 } \
    -value $title

template::element create new_note body \
    -widget textarea \
    -datatype text \
    -label "Body" \
    -html { rows 10 cols 40 wrap soft } \
    -value $body

if [template::form is_valid new_note] {
  set user_id [ad_conn user_id]
  set peeraddr [ad_conn peeraddr]

  if [info exists note_id] {
    db_dml note_update {
      update notes
      set title = :title,
          body = :body
      where note_id = :note_id
    }
  } else {
    db_exec_plsql new_note {
      declare
        id integer;
      begin
        id := note.new(
          owner_id => :user_id,
          title => :title,
          body => :body,
          creation_user => :user_id,
          creation_ip => :peeraddr,
          context_id => :package_id
        );
      end;
    }
  }

  ad_returnredirect "."
}

ad_return_template
