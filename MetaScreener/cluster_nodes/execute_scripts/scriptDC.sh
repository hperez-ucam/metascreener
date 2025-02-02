#!/usr/bin/env bash
DRAGON_PATH=${path_external_sw}dragon/
DRAGON_CFG=${DRAGON_PATH}cfg_template.drs
DRAGON_RUN=${DRAGON_PATH}dragon6shell
TOKEN_INPUT="MOL_FILE.SDF"
TOKEN_OUTPUT="SAVE_MOL.CSV"
SCRIPT_FILTER_COLUMNNS=${path_extra_metascreener}used_by_metascreener/filter_columns_dc.py
DRAGON_OUT="${out_grid%_0_0_0*}_$(basename ${query%.*})".csv
FILTER_BBDD=${out_grid}_filter_bbdd.csv
FILTER_QUERY=${out_grid}_filter_query.csv
PYTHON_RUN="python"
OUT_MOLEC=${out_molec}.csv

execute_script()
{
	TAG=`echo $(basename $BASH_SOURCE)`
	sed  -e "s ${TOKEN_INPUT} ${query} g" -e "s ${TOKEN_OUTPUT} ${DRAGON_OUT} g" ${DRAGON_CFG}	 > ${out_aux}.drs
	execute "${DRAGON_RUN} -s ${out_aux}.drs &> ${out_aux}.ucm"
	execute "${PYTHON_RUN} ${SCRIPT_FILTER_COLUMNNS} ${target} ${DRAGON_OUT} ${OUT_MOLEC}"
}
