<?xml version="1.0"?>
<queryset>
   <rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="notes">      
      <querytext>
  select note_id, owner_id, title, body,
         case when acs_permission__permission_p(note_id,:user_id,'write')='t' 
              then 1 else 0 end as write_p,
         case when acs_permission__permission_p(note_id,:user_id,'admin')='t'
			  then 1 else 0 end as admin_p,
         case when acs_permission__permission_p(note_id,:user_id,'delete')='t'
			  then 1 else 0 end as delete_p
  from notes n, acs_objects o
  where n.note_id = o.object_id
  and o.context_id = :package_id
  and acs_permission__permission_p(note_id, :user_id, 'read') = 't'
  order by creation_date

      </querytext>
</fullquery>

 
</queryset>
