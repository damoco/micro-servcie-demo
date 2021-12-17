import com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey
import com.cloudbees.plugins.credentials.CredentialsScope
import com.cloudbees.plugins.credentials.domains.Domain
import jenkins.model.Jenkins

println "--> creating SSH credentials"

domain = Domain.global()
store = Jenkins.get().getExtensionList('com.cloudbees.plugins.credentials.SystemCredentialsProvider')[0].getStore()

slavesPrivateKey = new BasicSSHUserPrivateKey(
        CredentialsScope.GLOBAL,
        "jenkins-slaves",
        "ec2-user",
        new BasicSSHUserPrivateKey.UsersPrivateKeySource(),
        "",
        ""
)

store.addCredentials(domain, slavesPrivateKey)