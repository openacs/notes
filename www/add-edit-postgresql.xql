<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="new_note">      
      <querytext>
      
        select note__new(
		  null,
		  :user_id,
          :title,
          :body,
          'note',
		  now(),
		  :user_id,
		  :peeraddr,
		  :package_id
        );

      </querytext>
</fullquery>

 
</queryset>
