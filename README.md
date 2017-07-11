# sms-gateway
SMS gateway for sending and receiving SMS messages

# hardware used:

The following hardware was used for this project:

- Raspberry PI 3 with 32GB Micro-SD
- Huawei 3131 3G USB modem

# software used:

The following software was used for making this collection of scripts work:

- Raspbian (Linux distribution for Raspberry pi)
- SMS Server Tools 3 (http://smstools3.kekekasvi.com/) as the SMS daemon

# SMS Server Tools 3:

The SMS Server Tools 3 is a SMS Gateway software which can send and receive short messages through GSM modems and mobile phones.

You can send short messages by simply storing text files into a special spool directory. The program monitors this directory and sends new files automatically. It also stores received short messages into another directory as text files.

The program can be run as a SMS daemon which can be started automatically when the operating system starts.

The program can run other external programs or scripts after events like reception of a new message, successful sending and also when the program detects a problem. These programs can inspect the related text files and perform automatic actions.

## Installation of SMS Server Tools 3:

- Log in as root on the Linux system
- use Wget or any other method to get the TAR file on the linux machine "wget http://smstools3.kekekasvi.com/packages/smstools3-3.1.21.tar.gz" (please note, this might not be the newest version, check the website for the newest version available.)
- untar the file: "tar -xzf smstools*.tar.gz"
- run "make"
- run "make install"

Done! the SMS Server Tools 3 utility is now installed and ready for use.

## configuring SMS Server Tools 3:

After installing SMS Server Tools 3, make sure your USB modem or any other supported device is plugged in to a suitable USB port and check if it is being recognized by running the command:
"cd /dev/" and check if TTYUSBxx (where xx is a number) is shown, this is the Serial interface of your USB modem.

Once the device is properly detected we can continue with the configuration of SMS Server Tools 3.