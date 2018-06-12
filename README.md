# crails-docker
docker-based building and deployment toolset

### Building your application
Firstly, you must mount your crails application on the `crailsapp` directory.

Then, run the `package.sh` script by using the following command:

```
docker/shell -c package.sh
```

When the process successfully ends, the `runtime` folder will be filled with all the files necessary to run your web application.

Note: by default, your docker image will build silently. You may use the `-v` option to display the output of the `docker build` command.

### Interactive shell
You may also run an interactive shell simply by running:
```
docker/shell
```
