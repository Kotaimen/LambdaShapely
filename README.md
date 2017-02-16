# Shapely in Lambda

Running [shapely](https://github.com/Toblerity/Shapely) in [lambda](https://aws.amazon.com/lambda).

## Usage 

Fist build base Amazon Linux image:

	docker build -t lambdabuilder docker


Build `geos` and install `shapely` in a `virtualenv`, then package lambda code them:

	./build-lambda-package.sh

> You can add additional packages in `build-virtualenv.sh`,
> lambda code is at `src/app.py`

Then, use `awscli` to prepare the package and cloudformation template (which uses official serverless cloudformation template):

```bash
aws cloudformation package \
    --template-file template.yaml \
    --s3-bucket=${YOUR_BUCKET_HERE} \
    --output-template-file packaged-template.yaml
```

Finally, deploy the template using [`awscfncli`](https://pypi.python.org/pypi/awscfncli) (or official `awscli`):

	cfn changeset create stack-config.yaml --changeset-type=CREATE --execute


