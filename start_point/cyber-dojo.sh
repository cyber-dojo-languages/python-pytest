set -e

# ------------------------------------------------------------------------
# cyber-dojo returns text files under /sandbox that are
# created/deleted/changed. In tidy_up you can remove any
# such files you don't want returned to the browser.

trap tidy_up EXIT

function tidy_up()
{
  delete_dirs .pytest_cache
}

function delete_dirs()
{
  for dirname in "$@"
  do
      rm -rf "${dirname}" 2> /dev/null || true
  done
}

# ------------------------------------------------------------------------
REPORT_DIR=${CYBER_DOJO_SANDBOX}/report
rm -rf ${REPORT_DIR} || true
mkdir -p ${REPORT_DIR}

coverage3 run \
  --source=${CYBER_DOJO_SANDBOX} \
  --module pytest \
    *test*.py

# https://coverage.readthedocs.io/en/v4.5.x/index.html

coverage3 report \
  --show-missing \
    > ${REPORT_DIR}/coverage.txt

# http://pycodestyle.pycqa.org/en/latest/intro.html#configuration

pycodestyle \
  ${CYBER_DOJO_SANDBOX} \
    --show-source `# show source code for each error` \
    --show-pep8   `# show relevent text from pep8` \
    --ignore E302,E305,W293 \
    --max-line-length=80 \
      > ${REPORT_DIR}/style.txt

# E302 expected 2 blank lines, found 0
# E305 expected 2 blank lines after end of function or class
# W293 blank line contains whitespace
