
//环境变量
def REPOSITORY="https://github.com/Tigerye/security-fe-crm.git"
def MODULE="security-fe-crm"
def DEPLOY_PATH="/home/jenkins/deploy"
def SCRIPT_PATH="/home/jenkins/script"

// k8s中转服务器登录配置
def remote = [:]
remote.name = 'k8s-proxy'
remote.host = '10.0.8.127'
remote.allowAnyHosts = true


node {
        stage('获取代码'){
            deleteDir() //清理工作空间
            echo "start fetch code from git:${REPOSITORY}"
                echo "构建的分支或者tag名称：>>>>>  ${TAG}"
                git branch: "master", credentialsId: 'guonl-github', url: "${REPOSITORY}"
                sh '[ -n "${TAG}" ] &&  git checkout ${TAG} ||  { echo -e "切换至指定的tag的版本，tag：${TAG} 不存在或为空，请检查输入的tag!" && exit 111; }'
        }

        stage('打压缩包'){
            echo "打压缩包……"
            sh "tar -cvf ${MODULE}.tar ."
            
        }
        
        withCredentials([sshUserPrivateKey(credentialsId: 'k8s-proxy-key', keyFileVariable: 'identity', passphraseVariable: '', usernameVariable: 'userName')]) {
        remote.user = 'jenkins'
        remote.identityFile = identity
        stage('打包编译') {
            echo "打包编译……"
            sshCommand remote: remote, command: "rm -rf ${DEPLOY_PATH}/${MODULE}"
            sshCommand remote: remote, command: "mkdir -p ${DEPLOY_PATH}/${MODULE}"
            sshPut remote: remote, from: "${MODULE}.tar", into: "${DEPLOY_PATH}/${MODULE}"
            sshCommand remote: remote, command: "cd ${DEPLOY_PATH}/${MODULE}/ && tar -xf ${MODULE}.tar"
            sshCommand remote: remote, command: "source .bash_profile;cd ${DEPLOY_PATH}/${MODULE};npm install;npm run build"
        }

        stage('构建镜像') {
            echo "构建镜像……"
            sshCommand remote: remote, command: "${SCRIPT_PATH}/${MODULE}/build_images.sh ${MODULE} ${TAG}"
        }

        stage('发布服务') {
            echo "发布服务……"
            sshCommand remote: remote, command: "${SCRIPT_PATH}/${MODULE}/deploy.sh ${MODULE}"
        }


    }

}
