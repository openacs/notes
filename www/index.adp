<master>
<property name="title">Notes</property>
<property name="context">@context;noquote@</property>

<table border=0 cellpadding=1 cellspacing=0 width="80%">
<tr><td bgcolor=#aaaaaa>
<table border=0 cellpadding=3 cellspacing=0 width="100%">
<multiple name=notes>
<if @notes.rownum@ odd>
  <tr bgcolor=#eeeeee>
</if>
<else>
  <tr bgcolor=#ffffff>
</else>

    <td valign=top width="1%">
      <if @notes.delete_p@ eq 1>
        <a href=delete?note_id=@notes.note_id@><img border=0 src=x alt=" [Delete] "></a>
      </if>
      <else>
        <img border=0 src=x-disabled alt=" [Can't Delete] ">
      </else>
    </td>
    <td>&nbsp;
        <a href=view-one?note_id=@notes.note_id@>@notes.title@</a>
      <if @notes.write_p@ eq 1>
        [<a href=add-edit?note_id=@notes.note_id@>Edit</a>]
      </if>
        <table border=0 cellpadding=4 cellspacing=0>
	  <tr>
	    <td>&nbsp;</td>
	    <td>@notes.body;noquote@</td>
	  </tr>
	</table>
    </td>
    <td valign=top align=right>
      <if @notes.admin_p@ eq 1>
        <font size=-1>(<a href=../permissions/one?object_id=@notes.note_id@>admin</a>)</font>
      </if>
      <else>
        &nbsp;
      </else>
    </td>

  </tr>
</multiple>
<if @notes:rowcount@ eq 0>
  <tr bgcolor=#eeeeee>
    <td colspan=2 align=center><br>(no notes)<br>&nbsp;</td>
  </tr>
</if>
  <tr bgcolor=#aaaaaa>
    <td colspan=2 align=center>
    <if @create_p@ eq 1>
      <a href=add-edit><img border=0 src=add alt=" [Add] "></a>
    </if>
    <else>
      <img border=0 src=add-disabled alt=" [Can't Add Note] ">
    </else>
    </td>
  </tr>
</table>
</td><tr>
</table>
