# main index page for notes.

ad_page_contract {

  @author rhs@mit.edu
  @creation-date 2000-10-23
  @cvs-id $Id$
} -properties {
  notes:multirow
  context_bar:onevalue
  create_p:onevalue
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

set context_bar [ad_context_bar]
set create_p [ad_permission_p $package_id create]

db_multirow notes notes {
  select note_id, owner_id, title, body,
         decode(acs_permission.permission_p(note_id,
                                            :user_id,
                                            'write'),
                't', 1,
                'f', 0) as write_p,
         decode(acs_permission.permission_p(note_id,
                                            :user_id,
                                            'admin'),
                't', 1,
                'f', 0) as admin_p,
         decode(acs_permission.permission_p(note_id,
                                            :user_id,
                                            'delete'),
                't', 1,
                'f', 0) as delete_p
  from notes n, acs_objects o
  where n.note_id = o.object_id
  and o.context_id = :package_id
  and acs_permission.permission_p(note_id, :user_id, 'read') = 't'
  order by creation_date
}

ad_return_template