<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="note_delete">      
      <querytext>
      
  begin
    note.delete(:note_id);
  end;

      </querytext>
</fullquery>

 
</queryset>
