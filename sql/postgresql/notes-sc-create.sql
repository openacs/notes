--
-- packages/notes/sql/notes-sc-create.sql
--
--
-- This sets up the service contracts that make the text in notes
-- available for indexing by the search package. See documentation 
-- on the packages 'search' and 'acs-service-contract'.
--
--


select acs_sc_impl__new(
	   'FtsContentProvider',		-- impl_contract_name
           'note',				-- impl_name
	   'notes'				-- impl_owner_name
);

select acs_sc_impl_alias__new(
           'FtsContentProvider',		-- impl_contract_name
           'note',           			-- impl_name
	   'datasource',			-- impl_operation_name
	   'notes__datasource',     		-- impl_alias
	   'TCL'				-- impl_pl
);

select acs_sc_impl_alias__new(
           'FtsContentProvider',		-- impl_contract_name
           'note',           			-- impl_name
	   'url',				-- impl_operation_name
	   'notes__url',			-- impl_alias
	   'TCL'				-- impl_pl
);


create function notes__itrg ()
returns opaque as '
begin
    perform search_observer__enqueue(new.note_id,''INSERT'');
    return new;
end;' language 'plpgsql';

create function notes__dtrg ()
returns opaque as '
begin
    perform search_observer__enqueue(old.note_id,''DELETE'');
    return old;
end;' language 'plpgsql';

create function notes__utrg ()
returns opaque as '
begin
    perform search_observer__enqueue(old.note_id,''UPDATE'');
    return old;
end;' language 'plpgsql';


create trigger notes__itrg after insert on notes
for each row execute procedure notes__itrg (); 

create trigger notes__dtrg after delete on notes
for each row execute procedure notes__dtrg (); 

create trigger notes__utrg after update on notes
for each row execute procedure notes__utrg (); 





