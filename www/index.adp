<master>

@context_bar@

<hr>

<center>

<table border=0 cellpadding=1 cellspacing=0 width=80%>
<tr><td bgcolor=#aaaaaa>
<table border=0 cellpadding=3 cellspacing=0 width=100%>
<multiple name=notes>
<if @notes.rownum@ odd>
  <tr bgcolor=#eeeeee>
</if>
<else>
  <tr bgcolor=#ffffff>
</else>

    <td valign=top width=1%>
      <if @notes.delete_p@ eq 1>
        <a href=delete?note_id=@notes.note_id@><img border=0 src=x></a>
      </if>
      <else>
        <img border=0 src=x-disabled>
      </else>
    </td>
    <td>&nbsp;
      <if @notes.write_p@ eq 1>
        <a href=add-edit?note_id=@notes.note_id@>@notes.title@</a>
      </if>
      <else>
        @notes.title@
      </else>
        <table border=0 cellpadding=4 cellspacing=0>
	  <tr>
	    <td>&nbsp;</td>
	    <td>
	    <%
	    regsub -all "\n" $notes(body) "<br>" body
	    adp_puts $body
	    %>
	    </td>
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
      <a href=add-edit><img border=0 src=add></a>
    </if>
    <else>
      <img border=0 src=add-disabled>
    </else>
    </td>
  </tr>
</table>
</td><tr>
</table>

</center>
