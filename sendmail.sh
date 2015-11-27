#!/bin/bash
export SHELL=/bin/bash

# Define SERVER, FROM, TO, RUNS, JOBS and SUBJECT as ENV.
# Example:
# docker run -e SERVER=smtp.example.com -e FROM=me@example.com -e TO=you@example.com -e SUBJECT=cool -e RUNS=100 -e JOBS=3 <imageId> "Message Content"

if [[ -z "$SERVER" ]] || [[ -z "$FROM" ]] || [[ -z "$TO" ]] || [[ -z "$SUBJECT" ]] || \
   [[ -z "$RUNS" ]] || [[ -z "JOBS" ]]; then
    echo "SERVER, FROM, TO, RUNS, or JOBS are missing"
    echo "Usage: docker run -h <fqdn> -e SERVER=smtp.example.com -e FROM=me@example.com -e TO=you@example.com  -e SUBJECT=cool -e RUNS=100 -e JOBS=3 <imageId>"
    exit 1
else
    server=$SERVER
    from=$FROM
    to=$TO
    runs=$RUNS
    jobs=$JOBS
    subject=$SUBJECT
fi

swakscmd="swaks -S --tls-optional --server $server --from $from --to $to --body $@ --header 'Subject: $subject'"

seq $runs | parallel -j$jobs -n0 $swakscmd :::
