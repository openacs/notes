select acs_sc_impl__delete(
	   'FtsContentProvider',		-- impl_contract_name
           'note'				-- impl_name
);




drop trigger notes__utrg on notes;
drop trigger notes__dtrg on notes;
drop trigger notes__itrg on notes;



drop function notes__utrg ();
drop function notes__dtrg ();
drop function notes__itrg ();

