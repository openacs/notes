<?xml version="1.0"?>
<queryset>

<fullquery name="notes">      
      <querytext>

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

      </querytext>
</fullquery>

 
</queryset>
