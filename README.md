1) Search for the <select> box with name="shibboleth_username_field"
2) Remove all <option>'s from the select box and replace with the option below:

	<option value='HTTP_GLID' <?php echo ($element_data['shibboleth_username_field'] == "HTTP_GLID" ? "selected" : "") ?>>HTTP_GLID</option>

3) Go to your database and make sure that the field in redcap_config called "shibboleth_username_field" contains the value of "HTTP_GLID"
4) You should be good to go with only the 1 UF Shib option available to the admin users interface for Security & Authentication, bottom of the page.
