# main index page for notes.

ad_page_contract {

  @author rhs@mit.edu
  @creation-date 2000-10-23
  @cvs-id $Id$
} -properties {
  notes:multirow
  context:onevalue
  create_p:onevalue
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

set context [list]
set create_p [ad_permission_p $package_id create]

db_multirow notes notes {} {
  set body [ad_text_to_html -- $body]
}

ad_return_template
