ad_page_contract {
    @author Neophytos Demetriou <k2pts@yahoo.com>
    @creation-date 2001-09-02
} {
    note_id:integer,notnull
} -properties {
    context:onevalue
    title:onevalue
    body:onevalue
}

set context [list "One note"]

db_1row note_select {
    select title, body
    from notes
    where note_id = :note_id
}


ad_return_template
