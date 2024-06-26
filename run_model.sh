# variable
data=$(date +'%Y-%m-%dT%H:%M:%S')

# path
path='/home/bruno/repos/3_ciclo_intermediario/3_ds_em_clusterizacao'
path_to_envs='/home/bruno/anaconda3/envs/ds-insiders/bin'

$path_to_envs/papermill $path/src/models/cluster_insiders_deploy_aws.ipynb $path/reports/cluster_insiders_deploy_aws_$data.ipynb

# if you want to improve the automation create a crontab file with the following example line command:
# 0 1 * * 0 /usr/bin/bash /home/usr/path/run_model.sh