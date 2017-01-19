There are four options for making this patch work:

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

---------Patch file---------------
Apply the patch like this:

    cd ~
    git clone git@ctsit-forge.ctsi.ufl.edu:redcap_security_settings.git
    export REDCAP_VERSION=6.11.5
    cd /var/https/redcap/redcap_v$REDCAP_VERSION/ControlCenter/
    sudo patch -p1 < /home/$USER/redcap_security_settings/security_settings.php.patch


---------Deploy Script------------
Clone the repo and run the deploy script with the appropriate parameters

    git clone git@ctsit-forge.ctsi.ufl.edu:redcap_security_settings.git
    redcap_security_settings/deploy.sh /var/https/redcap 6.18.1


If the patch file or deploy script fail, you will need to update the patch.  Follow these steps to update the patch:

1) Copy ./redcap/redcap_v$REDCAP_VERSION/ControlCenter/security_settings.php to this repo.
2) git add the new file
3) Use step 5 of the manual edit procedure as your guide to edit the file.
4) use git diff to generate the patch file and save it as security_settings.php.patch
5) Commit the security_settings.php and security_settings.php.patch and push the changes
6) test the resulting patch file via the pathc file or deploy script methods above.
