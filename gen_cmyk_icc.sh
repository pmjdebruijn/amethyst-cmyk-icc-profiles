#!/bin/sh

BRANDING="${1:-Custom}"
SUFFIX=$(echo "${BRANDING}" | tr 'A-Z' 'a-z' | tr -d 'aeiou' | head -c 3)
COPYRIGHT="CC0 1.0 Universal Public Domain Dedication"
GAMUT_MAPPING="-S /usr/share/color/argyll/ref/sRGB.icm"

colprofcmyk ()
{
  URL="${1}"
  DATASET="${2}"
  DESCRIPTION="${3}"
  DESCRIPTION_F="$(echo ${3} | sed 's,Web,web,g;s,Coated,coated_,g;s,Uncoated,uncoated_,g;s,Newspaper,newspaper,g;s,Exchange,exchange,g;s,Space,space_,g;s,_$,,g' | tr -d ' ')"
  AVG_DEV="${4}"
  MAX_K="${5}"
  TOTAL_AREA_COVERAGE="${6}"
  STLE="${7}"
  STPO="${8}"
  ENPO="${9}"
  ENLE="${10}"
  SHAPE="${11}"

  mkdir -p chardata
  [ ! -f chardata/${DATASET}.txt ] && wget ${URL} -O chardata/${DATASET}.txt
  [ ! -f chardata/${DATASET}.ti3 ] && txt2ti3 chardata/${DATASET}.txt chardata/${DATASET}
  echo "${DATASET} ${DESCRIPTION_F}_${TOTAL_AREA_COVERAGE}_${SUFFIX}.icc"
  colprof \
          -D "${DESCRIPTION} ${TOTAL_AREA_COVERAGE}% (${BRANDING})" -C "${COPYRIGHT}"							\
          -r ${AVG_DEV} -n c -q h -cmt -dpp -K p ${STLE} ${STPO} ${ENPO} ${ENLE} ${SHAPE} -L ${MAX_K} -l ${TOTAL_AREA_COVERAGE} ${GAMUT_MAPPING}	\
          -O "${DESCRIPTION_F}_${TOTAL_AREA_COVERAGE}_${SUFFIX}.icc"											\
          chardata/${DATASET}

  profcheck -k chardata/${DATASET}.ti3 "${DESCRIPTION_F}_${TOTAL_AREA_COVERAGE}_${SUFFIX}.icc" | tee "${DESCRIPTION_F}_${TOTAL_AREA_COVERAGE}_${SUFFIX}.txt"
}

# https://printtechnologies.org/wp-content/uploads/2020/03/cgats-gracol-tr006-2016-1.zip
colprofcmyk no_direct_download_available				TR006	"GRACoL 2006 Coated"		2	100	340	0 0.2 1 1 0.7
colprofcmyk no_direct_download_available				TR006	"GRACoL 2006 Coated"		2	100	310	0 0.2 1 1 0.7

colprofcmyk https://standards.iso.org/iso/15339/-2/ISO15339-CRPC1.txt	CRPC1	"GRACoL 2013 Newspaper"		2	100	240	0 0.2 1 1 0.7
colprofcmyk https://standards.iso.org/iso/15339/-2/ISO15339-CRPC3.txt	CRPC3	"GRACoL 2013 Uncoated"		2	100	260	0 0.2 1 1 0.7
colprofcmyk https://standards.iso.org/iso/15339/-2/ISO15339-CRPC3.txt	CRPC3	"GRACoL 2013 Uncoated"		2	100	280	0 0.2 1 1 0.7
colprofcmyk https://standards.iso.org/iso/15339/-2/ISO15339-CRPC6.txt	CRPC6	"GRACoL 2013 Coated"		2	100	320	0 0.2 1 1 0.7

colprofcmyk https://standards.iso.org/iso/15339/-2/ISO15339-CRPC5.txt	CRPC5	"SWOP 2013 Coated"		2	100	260	0 0.2 1 1 0.7

colprofcmyk https://www.color.org/chardata/FOGRA27L.txt			FOGRA27	"ISO Coated v1"			2	100	350	0 0.2 1 1 0.7
colprofcmyk https://www.color.org/chardata/FOGRA27L.txt			FOGRA27	"ISO Coated v1"			2	100	300	0 0.2 1 1 0.7
colprofcmyk https://www.color.org/chardata/FOGRA27L.txt			FOGRA27 "ISO Coated v1"                 2	100	280	0 0.2 1 1 0.7

colprofcmyk https://www.color.org/chardata/FOGRA28L.txt			FOGRA28	"ISO Web Coated v1"		2	100	300	0 0.2 1 1 0.7
colprofcmyk https://www.color.org/chardata/FOGRA28L.txt			FOGRA28	"ISO Web Coated v1"		2	100	280	0 0.2 1 1 0.7

colprofcmyk https://www.color.org/chardata/FOGRA29L.txt			FOGRA29	"ISO Uncoated v1"		2	100	320	0 0.2 1 1 0.7
colprofcmyk https://www.color.org/chardata/FOGRA29L.txt			FOGRA29	"ISO Uncoated v1"		2	100	300	0 0.2 1 1 0.7
colprofcmyk https://www.color.org/chardata/FOGRA29L.txt			FOGRA29	"ISO Uncoated v1"		2	100	280	0 0.2 1 1 0.7

colprofcmyk https://www.color.org/chardata/FOGRA39L.txt			FOGRA39	"ISO Coated v2"			2	98	330	0 0.2 1 1 0.7
colprofcmyk https://www.color.org/chardata/FOGRA39L.txt			FOGRA39	"ISO Coated v2"			2	98	300	0 0.2 1 1 0.7
colprofcmyk https://www.color.org/chardata/FOGRA39L.txt			FOGRA39	"ISO Coated v2"			2	98	280	0 0.2 1 1 0.7
colprofcmyk https://www.color.org/chardata/FOGRA39L.txt			FOGRA39	"ISO Coated v2"			2	98	260	0 0.2 1 1 0.7

colprofcmyk https://www.color.org/chardata/FOGRA47L.txt			FOGRA47	"PSO Uncoated ISO12647"		2	98	330	0 0.2 1 1 0.7
colprofcmyk https://www.color.org/chardata/FOGRA47L.txt			FOGRA47	"PSO Uncoated ISO12647"		2	98	300	0 0.2 1 1 0.7
colprofcmyk https://www.color.org/chardata/FOGRA47L.txt			FOGRA47	"PSO Uncoated ISO12647"		2	98	280	0 0.2 1 1 0.7
colprofcmyk https://www.color.org/chardata/FOGRA47L.txt			FOGRA47	"PSO Uncoated ISO12647"		2	98	260	0 0.2 1 1 0.7

colprofcmyk https://www.color.org/chardata/FOGRA51.txt			FOGRA51	"PSO Coated v3"			2	96	300	0 0.2 1 1 0.7
colprofcmyk https://www.color.org/chardata/FOGRA51.txt			FOGRA51	"PSO Coated v3"			2	96	280	0 0.2 1 1 0.7
colprofcmyk https://www.color.org/chardata/FOGRA51.txt			FOGRA51	"PSO Coated v3"			2	96	260	0 0.2 1 1 0.7

colprofcmyk https://www.color.org/chardata/FOGRA52.txt			FOGRA52	"PSO Uncoated v3"		2	96	300	0 0.2 1 1 0.7
colprofcmyk https://www.color.org/chardata/FOGRA52.txt			FOGRA52	"PSO Uncoated v3"		2	96	280	0 0.2 1 1 0.7
colprofcmyk https://www.color.org/chardata/FOGRA52.txt			FOGRA52	"PSO Uncoated v3"		2	96	260	0 0.2 1 1 0.7
