import yaml

with open('config.yaml', 'r') as stream:
    try:
        config_data = yaml.safe_load(stream)
    except yaml.YAMLError as exc:
        print(exc)

for i, (chart, dependencies) in enumerate(config_data['charts'].items()):
    filename = f"./{i+1}.yaml"
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
                "url": "https://chart.paas.talkweb.com.cn",
                "auth": {
                    "username": "username",
                    "password": "password"
                }
            }
        },
        "relocateContainerImages": False
    }
    with open(filename, 'w+') as outfile:
        yaml.dump(data, outfile, default_flow_style=False)