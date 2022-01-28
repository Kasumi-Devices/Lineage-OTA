#!/bin/bash

if ["${KASUMI_BUILD_TYPE}" == "vanilla"]; then
    jsonfile="${ROM_DIR}/vendor/kasumiota/${device}.json"
else
    jsonfile="${ROM_DIR}/vendor/kasumiota/${KASUMI_BUILD_TYPE}/${device}.json"
fi
d=$(date +%Y%m%d)
md5=$(md5sum ${finalzip_path} | cut -d ' ' -f 1)
utc=$(grep ro.build.date.utc $(dirname ${finalzip_path})/system/build.prop | cut -d '=' -f 2)
size=$(wc -c ${finalzip_path} | cut -d ' ' -f 1)
url="${release_repo}/releases/${tag}/${zip_name}/"

# This is where the magic happens

echo -e "{\n  \"response\": [\n    {" > ${jsonfile}
echo -e "      \"datetime\": \"${utc}\"," >> ${jsonfile}
echo -e "      \"filename\": \"${zip_name}\"," >> ${jsonfile}
echo -e "      \"id\": \"${md5}\"," >> ${jsonfile}
echo -e "      \"romtype\": \"OFFICIAL\"," >> ${jsonfile}
echo -e "      \"size\": \"${size}\"," >> ${jsonfile}
echo -e "      \"url\": \"${url}\"," >> ${jsonfile}
echo -e "      \"version\": \"1.0\"\n    }\n  ]\n}" >> ${jsonfile}
