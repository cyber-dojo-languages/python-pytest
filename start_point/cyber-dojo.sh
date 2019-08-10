coverage3 run --source='.' -m pytest *test*.py
echo; echo
coverage3 report -m
echo; echo
pycodestyle /sandbox
