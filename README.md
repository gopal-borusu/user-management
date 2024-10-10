# user-management
Bash script useful for **Managing user accounts on multiple Linux Servers**. The Script is capable of **Onboarding new user accounts**, **Modifying the existing user accounts**, **Deleting the user accounts**.

The Servers on which the user accounts has to be managed is placed in on file (One server in each line and can include IP addresses as well) and will be passed as an argument while running the script.

# Usage
In below given example
1) I am creating a user named "testuser1" in 2 servers.
2) I am modifying home directory of testuser1 in both servers.
3) Deleting the testuser1 from the 2 servers.

The Script has to be executed in below format.

**Usage:** ./usermanage.sh serversfile

Note:

i) While onboarding the new user, The user will be created with default values and can be edited later through script.

ii) While running the script it will prompt you for **"Enter logon SSH user:"**. This is the **user account through which we will do SSH and configure the users**. Do not confuse it with the username that needs to be configured in servers. In below example i have used "root" as my Logon account.

iii) The username that needs to be configured will be asked after you select the type of action that needs to be performed on server. 

**1) User Onboarding:** 

Selecting the option "Add the user" will create the given user in the servers if it is not already present.

![VirtualBox_vm1_10_10_2024_15_29_43](https://github.com/user-attachments/assets/5aac3b20-883d-4405-b53b-f93bdc2f91a3)

**2) User Modification:**

Selecting the option "Modify the user" will prompt you for additional details on what you want to modify for the given user. In my example i have selected "Change user home directory" to update the homedirectory for the user. You need to select appropriate option depending on what you need to modify.

![VirtualBox_vm1_10_10_2024_15_31_12](https://github.com/user-attachments/assets/73cc1b08-0bdb-4d14-997b-a87fc1677e86)

**3) User Deletion:** 

Selecting the option "Delete the user" will delete the given user from servers if it is present.

![image](https://github.com/user-attachments/assets/d0b5382a-67cb-420d-88e0-43909bc5cce8)
