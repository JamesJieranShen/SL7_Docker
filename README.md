# SL7 Docker Config

James Shen <jamesjieranshen@gmail.com>

- working directory should be mounted at `/work`
- `cvmfs` mount point should be mounted at `/cvmfs`
- In order to get autonomously get a kerberos ticket (and therefore get `kx509`
  and `voms` working out of box), you will need to setup a kerberos keytab, and
  make sure that the Dockerfile correctly points to it.

I use the following script to start the docker:

```
#!/bin/bash
# disable build if nothing is changed...
docker build -t sl7 $WORK/hep/sl7
echo "Entering Docker... run `source setup_lar` to setup all environment variables"
docker run -it --rm --name sl7 \
    -v $WORK/hep:/work \
    -v /cvmfs:/cvmfs \
    --user="1000:1000"\
    sl7 bash

```

## References:

- How to setup CVMFS:
  <https://wiki.dunescience.org/wiki/Setting_up_your_own_local_SL7_system>
- Get Kerberos keytab: <https://stackoverflow.com/a/55826172>

## Note

- It is technically possible fo run ups setup [using bundles provded by SciSoft](https://wiki.dunescience.org/wiki/DUNE_LAr_Software_Releases). To try making this compatible with scisoft, `kx509` is copied over from `cvmfs` instead of setup the usual way. However, some of the provided packages in SciSoft appears to be out of date. Your milage may vary.
