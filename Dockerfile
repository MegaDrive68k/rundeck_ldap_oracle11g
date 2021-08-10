FROM rundeck/rundeck:SNAPSHOT

COPY --chown=rundeck:root remco /etc/remco
