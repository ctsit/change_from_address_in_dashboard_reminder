There are two options for making this patch work:

--------Manual Edit--------------
1) Change directory to where your redcap instance is running (/var/www/redcap/redcap_vx/)
2) Change directory to ControlCenter/
3) Open security_settings.php in your favorite editor
4) Search for the <select> box with name="shibboleth_username_field"
5) Remove all <option>'s from the select box and replace with the option below:

	<option value='HTTP_GLID' <?php echo ($element_data['shibboleth_username_field'] == "HTTP_GLID" ? "selected" : "") ?>>HTTP_GLID</option>

6) Go to your database and make sure that the field in redcap_config called "shibboleth_username_field" contains the value of "HTTP_GLID"
7) You should be good to go with only the 1 UF Shib option available to the admin users interface for Security & Authentication, bottom of the page.

---------Pre-Edited file----------
1) This option was originally created on version 6.0.5, so your results may vary, as long as the new version doesn't have major
changes, it should work
2) Copy security_settings.php from the repo where you got this README.md file over file in your redcap instance (/var/www/redcap/redcap_vx/ControlCenter/)
