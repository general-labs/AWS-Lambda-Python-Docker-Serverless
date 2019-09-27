FROM python:3.7.3

ARG aws_access_key_id
ARG aws_secret_access_key

# update apt-get
RUN apt-get update -y && apt-get upgrade -y

# install dev tool
RUN apt-get install -y vim

# --------------------------------------------------
RUN apt-get install curl
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install nodejs -y
# --------------------------------------------------
# Install app dependencies
RUN npm install -y
# --------------------------------------------

# install aws-cli
RUN pip install awscli
# install serverless framework
RUN npm install -g serverless

# change work directory
#RUN mkdir -p /app
WORKDIR /app

# install necessary libraries
#RUN pip install requests -t /app/src/requests
#RUN pip install requests -t /app/src/numpy

COPY requirements.txt .
COPY serverless.yml .
COPY Dockerfile .

RUN echo "Setting up serverless config $aws_access_key_id   |  $aws_secret_access_key"
RUN serverless config credentials --provider aws --key $aws_access_key_id --secret $aws_secret_access_key

RUN pwd
RUN ls --all
#RUN ls -l src

RUN echo 'plugins:' >> serverless.yml
RUN echo '  - serverless-python-requirements' >> serverless.yml

RUN sls plugin install -n serverless-python-requirements
RUN ls --all

RUN pip install -t /app/src/lib/ -r requirements.txt
#RUN [ "python", "-c", "import nltk; nltk.download('punkt')" ]
#RUN [ "python", "-c", "import nltk; nltk.download('stopwords')" ]