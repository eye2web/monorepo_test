FROM sonarsource/sonar-scanner-cli:4.6

# Set up local envs in order to allow for special chars (non-asci) in filenames.
ENV LC_ALL="C.UTF-8"

# https://help.github.com/en/actions/creating-actions/dockerfile-support-for-github-actions#user
USER root

RUN apk add jq

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
