FROM cyberdojofoundation/python
LABEL maintainer=jon@jaggersoft.com

RUN pip3 install --upgrade pytest coverage

COPY red_amber_green.rb /usr/local/bin
