FROM debian:9.5-slim

RUN apt-get update && apt-get install -y curl

LABEL "com.github.actions.name"="Auto Merge Action"
LABEL "com.github.actions.description"="Automatically merge one branch into another"
LABEL "com.github.actions.icon"="arrow"
LABEL "com.github.actions.color"="orange"

LABEL "repository"="http://github.com/andyhansen/auto-merge-action"
LABEL "homepage"="http://github.com/andyhanseh/auto-merge-action"
LABEL "maintainer"="Andy Hansen <github@andyhansen.co.nz>"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]