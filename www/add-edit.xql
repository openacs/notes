<?xml version="1.0"?>
<queryset>

<fullquery name="note_select">      
      <querytext>
      
    select title, body
    from notes
    where note_id = :note_id
  
      </querytext>
</fullquery>

 
<fullquery name="note_update">      
      <querytext>
      
      update notes
      set title = :title,
          body = :body
      where note_id = :note_id
    
      </querytext>
</fullquery>

 
</queryset>
