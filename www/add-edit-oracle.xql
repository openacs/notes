<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="new_note">      
      <querytext>
      
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

      </querytext>
</fullquery>

 
</queryset>
