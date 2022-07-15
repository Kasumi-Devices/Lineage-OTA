#!/bin/bash

if [ "${KASUMI_BUILD_TYPE}" == "vanilla" ]; then
    jsonfile="${TOP}/vendor/kasumiota/${LINEAGE_BUILD}.json"
else
    jsonfile="${TOP}/vendor/kasumiota/${KASUMI_BUILD_TYPE}/${LINEAGE_BUILD}.json"
fi
d=$(date +%Y%m%d)
sha256=$(sha256sum ${OUT}/Kasumi*.zip | cut -d ' ' -f 1)
utc=$(grep ro.build.date.utc ${OUT}/system/build.prop | cut -d '=' -f 2)
size=$(wc -c ${OUT}/Kasumi*.zip | cut -d ' ' -f 1)
url="https://dl.ayokaacr.net/4:/${LINEAGE_BUILD}/$(basename ${OUT}/Kasumi*.zip)"

# This is where the magic happens

echo -e "{\n  \"response\": [\n    {" > ${jsonfile}
echo -e "      \"datetime\": \"${utc}\"," >> ${jsonfile}
echo -e "      \"filename\": \"$(basename ${OUT}/Kasumi*.zip)\"," >> ${jsonfile}
echo -e "      \"id\": \"${sha256}\"," >> ${jsonfile}
echo -e "      \"romtype\": \"OFFICIAL\"," >> ${jsonfile}
echo -e "      \"size\": \"${size}\"," >> ${jsonfile}
echo -e "      \"url\": \"${url}\"," >> ${jsonfile}
echo -e "      \"version\": \"1.3\"\n    }\n  ]\n}" >> ${jsonfile}

echo "OTA has been created. Please navigate to $TOP/vendor/kasumiota and write a changelog named $LINEAGE_BUILD.md!"
