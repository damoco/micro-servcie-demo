#!groovy

import jenkins.model.Jenkins

Jenkins jenkins = Jenkins.get()
jenkins.getDescriptor("jenkins.CLI").get().setEnabled(false)
jenkins.save()