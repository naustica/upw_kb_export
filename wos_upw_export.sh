unpigz -c -p 12 unpaywall_snapshot_2020-10-09T153852.jsonl.gz | parallel --pipe --block 100M --jobs 12 --files --tmpdir ./output_upw --recend '}\n' "jq -r '[.doi, .is_oa, .journal_is_in_doaj, .journal_is_oa, .oa_status, .has_repository_copy, .is_paratext] + (.oa_locations | if length > 0 then .[] | [.evidence, .host_type, .is_best, .license, .oa_date, .repository_institution, .url_for_landing_page, .url_for_pdf] else [null, null, null, null, null, null, null, null] end) | @csv'"

for upw_file in ./output_upw/*.par
do
    uuid=$(uuidgen)
    echo "cat head.txt $upw_file > ./output/$uuid.csv"
done | parallel --jobs 12

python filter.py

for upw_file in ./output_kb/*.csv
do
    uuid=$(uuidgen)
    echo "cat $upw_file | sed 1d > ./merge/$uuid.csv"
done | parallel --jobs 12

cat head.txt ./merge/*csv > out.csv
