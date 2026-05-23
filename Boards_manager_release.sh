#!/bin/bash

##########################################################
##                                                      ##
## Shell script for generating a boards manager release ##
## Created by MCUdude                                   ##
## Requires wget, jq and a bash environment             ##
##                                                      ##
##########################################################

# Change these to match your repo
PAOOWNER=felias-fogg       # Github owner of PyAvrOCD  
AUTHOR=felias-fogg         # Github user name
REALAUTHOR=felias-fogg     # real author
REPOSITORY=ArduinoCore-avr # Github repo name

# Get the version number of most recent PyAvrOCD version
PAOVERSION=$(curl -s https://api.github.com/repos/$PAOOWNER/PyAvrOCD/releases/latest | grep "tag_name" |  awk -F\" '{print $4}')
AVROCDVERSION=${PAOVERSION#"v"}

# Get the download URL for the latest release from Github
DOWNLOAD_URL=$(curl -s https://api.github.com/repos/$AUTHOR/$REPOSITORY/releases/latest | grep "tarball_url" | awk -F\" '{print $4}')

# Get filename
DOWNLOADED_FILE=$(echo $DOWNLOAD_URL | awk -F/ '{print $8}')

# Check whether most recent board file is already in the index
if grep -q ${REPOSITORY}-${DOWNLOADED_FILE#"v"} package_${REALAUTHOR}_${REPOSITORY}_index.json; then
    echo "Most recent board version is already in the index file. Nothing to do."
    exit 1
fi

# Check whether already part of the index
if grep -q "avrocd-tools-"${AVROCDVERSION} package_${REALAUTHOR}_${REPOSITORY}_index.json; then
    echo "Current PyAvrOCD version is in index. Continue ..."
else
    echo "Current PyAvrOCD version is not in index. Add it first."
    exit 1
fi


# Download file
wget --no-verbose $DOWNLOAD_URL

# Add .tar.bz2 extension to downloaded file
mv $DOWNLOADED_FILE ${DOWNLOADED_FILE}.tar.bz2

# Extract downloaded file and place it in a folder
printf "\nExtracting folder ${DOWNLOADED_FILE}.tar.bz2 to $REPOSITORY-${DOWNLOADED_FILE#"v"}\n"
mkdir -p "$REPOSITORY-${DOWNLOADED_FILE#"v"}" && tar -xzf ${DOWNLOADED_FILE}.tar.bz2 -C "$REPOSITORY-${DOWNLOADED_FILE#"v"}" --strip-components=1
printf "Done!\n"

# Delete downloaded file 
rm -rf ${DOWNLOADED_FILE}.tar.bz2 

# Make sure there are no macOS related files added to the arching that's soon to be geneated
dot_clean .

# Compress folder to tar.bz2
printf "\nCompressing folder $REPOSITORY-${DOWNLOADED_FILE#"v"} to $REPOSITORY-${DOWNLOADED_FILE#"v"}.tar.bz2\n"
tar -cjSf $REPOSITORY-${DOWNLOADED_FILE#"v"}.tar.bz2 $REPOSITORY-${DOWNLOADED_FILE#"v"}
printf "Done!\n"

# Get file size on bytes
FILE_SIZE=$(wc -c "$REPOSITORY-${DOWNLOADED_FILE#"v"}.tar.bz2" | awk '{print $1}')

# Get SHA256 hash
SHA256="SHA-256:$(shasum -a 256 "$REPOSITORY-${DOWNLOADED_FILE#"v"}.tar.bz2" | awk '{print $1}')"

# Create Github download URL
URL="https://${AUTHOR}.github.io/${REPOSITORY}/$REPOSITORY-${DOWNLOADED_FILE#"v"}.tar.bz2"

cp "package_${REALAUTHOR}_${REPOSITORY}_index.json" "package_${REALAUTHOR}_${REPOSITORY}_index.json.tmp"

# Add new boards release entry
jq -r                                    \
--arg avrocdversion $AVROCDVERSION       \
--arg repository  $REPOSITORY            \
--arg version     ${DOWNLOADED_FILE#"v"} \
--arg url         $URL                   \
--arg checksum    $SHA256                \
--arg file_size   $FILE_SIZE             \
--arg file_name   $REPOSITORY-${DOWNLOADED_FILE#"v"}.tar.bz2  \
'.packages[].platforms[.packages[].platforms | length] |= . +
{
  "name": "Arduino AVR Boards (Debug enabled)",
  "architecture": "avr",
  "version": $version,
  "category": "Contributed",
  "url": $url,
  "archiveFileName": $file_name,
  "checksum": $checksum,
  "size": $file_size,
  "help": {
     "online": "https://pyavrocd.io"
  },
  "boards": [
            {
              "name": "Arduino Yún"
            },
            {
              "name": "Arduino UNO"
            },
            {
              "name": "Arduino UNO Mini"
            },
            {
              "name": "Arduino UNO WiFi"
            },
            {
              "name": "Arduino Diecimila"
            },
            {
              "name": "Arduino Nano"
            },
            {
              "name": "Arduino Mega"
            },
            {
              "name": "Arduino Mega ADK"
            },
            {
              "name": "Arduino Leonardo"
            },
            {
              "name": "Arduino Leonardo Ethernet"
            },
            {
              "name": "Arduino Micro"
            },
            {
              "name": "Arduino Esplora"
            },
            {
              "name": "Arduino Mini"
            },
            {
              "name": "Arduino Ethernet"
            },
            {
              "name": "Arduino Fio"
            },
            {
              "name": "Arduino BT"
            },
            {
              "name": "Arduino LilyPad USB"
            },
            {
              "name": "Arduino LilyPad"
            },
            {
              "name": "Arduino Pro"
            },
            {
              "name": "Arduino ATMegaNG"
            },
            {
              "name": "Arduino Robot Control"
            },
            {
              "name": "Arduino Robot Motor"
            },
            {
              "name": "Arduino Gemma"
            },
            {
              "name": "Adafruit Circuit Playground"
            },
            {
              "name": "Arduino Yún Mini"
            },
            {
              "name": "Arduino Industrial 101"
            },
            {
              "name": "Linino One"
            }
  ],
  "toolsDependencies": [
    {
      "packager": "arduino",
      "name": "avr-gcc",
      "version": "7.3.0-atmel3.6.1-arduino7"
    },
    {
      "packager": "MightyCore",
      "name": "avrdude",
      "version": "8.0.0-arduino1"
    },
    {
      "packager": "arduino",
      "name": "arduinoOTA",
      "version": "1.3.0"
    },
    {
      "packager": "ArduinoCore-avr",
      "name": "avrocd-tools",
      "version": $avrocdversion
    }   
  ]
}' "package_${REALAUTHOR}_${REPOSITORY}_index.json.tmp" > "package_${REALAUTHOR}_${REPOSITORY}_index.json"

# Remove files that's no longer needed
rm -rf "$REPOSITORY-${DOWNLOADED_FILE#"v"}" "package_${REALAUTHOR}_${REPOSITORY}_index.json.tmp"

