import os
import yaml

chartRepo = os.environ.get('CHART_REPO')
chartUsername = os.environ.get('CHART_USER')
chartPassword = os.environ.get('CHART_PASS')
containerRegistry = os.environ.get('CONTAINER_REGISTRY')
containerRepository = os.environ.get('CONTAINER_REPO')

with open('config.yaml', 'r') as stream:
    try:
        config_data = yaml.safe_load(stream)
    except yaml.YAMLError as exc:
        print(exc)

for i, (chart, dependencies) in enumerate(config_data['charts'].items()):
    filename = f"./{chart}.yaml"
    data = {
        "source": {
            "repo": {
                "kind": "HELM",
                "url": f"https://{chart}"
            }
        },
        "target": {
            "containerRegistry": f"{containerRegistry}",
            "containerRepository": f"{containerRepository}",
            "repo": {
                "kind": "CHARTMUSEUM",
                "url": f"{chartRepo}",
                "auth": {
                    "username": f"{chartUsername}",
                    "password": f"{chartPassword}"
                }
            }
        }
    }
    with open(filename, 'w+') as outfile:
        yaml.dump(data, outfile, default_flow_style=False)
