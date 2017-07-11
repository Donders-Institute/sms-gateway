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