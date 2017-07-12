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

Open the configuration file of SMS Server Tools 3:

nano /etc/smsd.conf

Paste this information into the file (overwriting existing configuration file if you start from scratch)

```bash
# Example smsd.conf. Read the manual for a description

devices = GSM1
logfile = /var/log/smsd.log
loglevel = 5
spool_directory_order = yes
delaytime_mainprocess = 1
delaytime = 5
eventhandler =

[GSM1]
device = /dev/ttyUSB2
init = AT^CURC=0
incoming = yes
baudrate = 9600
pin = 0000
memory_start = 0
detect_unexpected_input = no
decode_unicode_text = no
#incoming_utf8 = false
```

###Change the following values:

devices = GSMx (if you have multiple modems installed, increment as required)
eventhandler = "Location to eventhandler script" ( for more details, see http://smstools3.kekekasvi.com/index.php?p=eventhandler )
device = /dev/ttyUSB2 ( In our case ttyUSB2 is the serial interface of our modem )
init = AT^CURC=0 ( These are optional commands that the daemon sends to the modem when initializing the modem itself (this command disables Debugging echo's on the serial interface) )
pin = 0000 ( this is the pin-code which is on the sim-card in the modem )

The rest of the settings are default, and can be kept this way.

To get the full list of options, follow this link: http://smstools3.kekekasvi.com/index.php?p=configure