#!groovy

import jenkins.model.Jenkins

Jenkins jenkins = Jenkins.get()
jenkins.CLI.get().setEnabled(false)
jenkins.save()