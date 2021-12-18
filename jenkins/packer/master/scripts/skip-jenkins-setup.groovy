#!groovy
import hudson.util.*
import jenkins.install.*
import jenkins.model.*

def instance = Jenkins.getInstance()
instance.setInstallState(InstallState.INITIAL_SETUP_COMPLETED)