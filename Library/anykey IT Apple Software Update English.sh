#!/usr/bin/perl -w

# taken from https://jamfnation.jamfsoftware.com/discussion.html?id=5404 
# edited by tanya pfeffer t.pfeffer@anykeyit.ch
# 20150918 - 10:52 - tobiaslinder

use strict;

my $AVAILABLEUPDATES="";
my $CHANCESTOUPDATE=5;
my $COUNTFILE='/etc/SUScount.txt';
my $UPDATECOUNT=0;

system '/usr/sbin/softwareupdate --ignore "macOS High Sierra"';

$AVAILABLEUPDATES=`/usr/sbin/softwareupdate --list`;
chomp $AVAILABLEUPDATES;

printf "available updates is %s \n\n", "$AVAILABLEUPDATES";

unless (-e $COUNTFILE){
    system "/bin/echo 0 > $COUNTFILE";
} 

$UPDATECOUNT=`/bin/cat $COUNTFILE`;
printf "update count is $UPDATECOUNT\n\n";

# If available updates contains * there are updates available

if ($AVAILABLEUPDATES=~/\*/){

    printf "there are updates available\n";

    if ($AVAILABLEUPDATES=~/(restart)|(shut\sdown)/){

        printf "updates need a restart\n";

        my $LOGGEDINUSER='';

        $LOGGEDINUSER=`/usr/bin/who | /usr/bin/grep console | /usr/bin/cut -d " " -f 1`;
        chomp $LOGGEDINUSER;

        printf "value of logged in user is $LOGGEDINUSER..\n";

        if ($LOGGEDINUSER=~/[a-zA-Z]/) {

            printf "as there is a logged in user checking count\n";

            my $CHANCESLEFT=$CHANCESTOUPDATE - $UPDATECOUNT;
            printf "Chances left is $CHANCESLEFT\n";      

            if ($CHANCESLEFT <= 0) {
                printf "No chances left installing updates and will reboot..\n";
                system 'jamf displayMessage -message "There are new updates available that request a restart. Because you already postphoned the update process 5 times it will now be enforced. Please save all documents right away."';
                system "jamf policy -trigger runapplesoftwareupdate";
                system "/bin/echo 0 > $COUNTFILE";
                exit 0;
            }

            else {
                printf "$CHANCESLEFT chances left... checking whether ok to restart\n";
                my $ATTEMPT = $UPDATECOUNT + 1;
                my $FINAL = $CHANCESTOUPDATE + 1;

                my $COMMAND= "\'/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper\' -startlaunchd -windowType utility -icon \'/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/Resources/Message.png\' -heading \"New Apple Software Updates\" -description \"Is it okay for you if we now install your updates and restart your computer? ($CHANCESLEFT times till updates are enforced).\" -button1 \"Yes\" -button2 \"No\" -cancelButton \"2\" -timeout \"1800\"";

                my $RESPONSE = "";
                $RESPONSE=system $COMMAND;

                if ($RESPONSE eq "0") {
                    printf "\nUser said YES to Updates\n";
                    system "jamf policy -trigger runapplesoftwareupdate";
                    system "/bin/echo 0 > $COUNTFILE";
                    exit 0;
                } else {
                    printf "\nUser said NO to Updates update count is $UPDATECOUNT\n";
                    $UPDATECOUNT=$UPDATECOUNT + 1;
                    system "/bin/echo $UPDATECOUNT > $COUNTFILE";
                    printf "\nUpdate count is now $UPDATECOUNT\n";
                    exit 0;
                }
            }
        } else {
            printf "no logged in user so ok to run updates\n";
            system "jamf policy -trigger runapplesoftwareupdate";
            system "/bin/echo 0 > $COUNTFILE";
            exit 0;
        }
    } 
    else {
        printf "no restart required\n";
        system "jamf policy -trigger runapplesoftwareupdate";
        system "/bin/echo 0 > $COUNTFILE";
        exit 0;
    }
}
else {
    printf "there are no updates available\n";
    system "/bin/echo 0 > $COUNTFILE";
    exit 0;
}
exit 0;