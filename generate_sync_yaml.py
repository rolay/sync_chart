import os
import yaml

repo = os.environ.get('CHART_REPO')
username = os.environ.get('USER')
password = os.environ.get('PASS')

with open('config.yaml', 'r') as stream:
    try:
        config_data = yaml.safe_load(stream)
    except yaml.YAMLError as exc:
        print(exc)

for i, (chart, dependencies) in enumerate(config_data['charts'].items()):
    filename = f"./chart-{i+1}.yaml"
    data = {
        "source": {
            "repo": {
                "kind": "HELM",
                "url": f"https://{chart}"
            }
        },
        "charts": dependencies,
        "target": {
            "repo": {
                "kind": "CHARTMUSEUM",
                "url": f"{repo}",
                "auth": {
                    "username": f"{username}",
                    "password": f"{password}"
                }
            }
        }
    }
    with open(filename, 'w+') as outfile:
        yaml.dump(data, outfile, default_flow_style=False)
