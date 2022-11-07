FROM python:3

# We need node etc for gulp
RUN apt-get update && \
    apt-get install -y nodejs npm

WORKDIR app
# copy all our various lock files etc.
COPY Pipfile Pipfile.lock package.json package-lock.json gulpfile.js .

# Install python deps
RUN pip install pipenv && \
    pipenv install

# Install node deps
RUN npm install

# Copy everything else
COPY . .

RUN npm run gulp build

EXPOSE 8000

CMD ["pipenv", "run", "server"]
