ad_proc notes__datasource {
    object_id
} {
    @author Neophytos Demetriou
} {
    db_0or1row notes_datasource {
	select n.note_id as object_id, 
	       n.title as title, 
	       n.body as content,
	       'text/plain' as mime,
	       '' as keywords,
	       'text' as storage
	from notes n
	where note_id = :object_id
    } -column_array datasource

    return [array get datasource]
}


ad_proc notes__url {
    object_id
} {
    @author Neophytos Demetriou
} {

    set package_id [apm_package_id_from_key notes]
    db_1row get_url_stub "
        select site_node__url(node_id) as url_stub
        from site_nodes
        where object_id=:package_id
    "

    set url "${url_stub}view-one?note_id=$object_id"

    return $url
}
