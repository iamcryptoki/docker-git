# What is git?

Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.

Website: [git-scm.com](https://git-scm.com/)

## Environment variables

Name | Description | Default
---- | ----------- | -------
TZ | Container timezone | `Europe/Paris`
UID | Container non-root user UID | `2000`
GID | Container non-root user GID | `2000`

## How to use this image

```
$ docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git iamcryptoki/git <git_command>
```

## How to use this image as a CronJob in a Kubernetes cluster

```
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: example-git
  namespace: example
  labels:
    app: example
spec:
  # At every 10th minute.
  schedule: "*/10 * * * *"
  failedJobsHistoryLimit: 3
  successfulJobsHistoryLimit: 3
  suspend: false
  jobTemplate:
    spec:
      template:
        metadata:
          labels:
            app: example
        spec:
          restartPolicy: Never
          volumes:
            - name: example-git
              persistentVolumeClaim:
                claimName: example-git
          containers:
            - name: example-git
              image: iamcryptoki/git
              imagePullPolicy: IfNotPresent
              securityContext:
                runAsNonRoot: true
                runAsUser: 2000
              command: ["git", "pull", "origin", "master"]
              volumeMounts:
                - name: example-git
                  mountPath: "/git"
```