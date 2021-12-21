# SL7 Docker Config

James Shen <jamesjieranshen@gmail.com>

- working directory should be mounted at `/work`
- `cvmfs` mount point should be mounted at `/cvmfs`
- In order to get autonomously get a kerberos ticket (and therefore get `kx509`
  and `voms` working out of box), you will need to setup a kerberos keytab, and
  make sure that the Dockerfile correctly points to it.
- To allow X11 forwarding to your desktop, you need to [mount the x11 socket to the docker as well](https://www.cloudsavvyit.com/10520/how-to-run-gui-applications-in-a-docker-container/). I did not have any issues with XAuth, but this may vary based depending on the system you are running.
- I see no need of setting up VNC, as the latency issue of X11 is not huge when there is no network involved, but setting it up is also possible.

Run `docker-compose build sl7` to build the docker. Afterwards, use `docker-compose run --rm sl7 bash` to get in a shell. The provided `bashrc` sets up proxies, dune ups packages, etc., when an interactive bash session is called.

## Setting Up Jupyter Notebook
If you would like to use PyROOT for analysis, you need to install it into the shared home directory, as we typically use a version of python and pip set up in the cvmfs during runtime.

When the docker is ran for the first time, do `pip install notebook` in a bash shell. This will install install the binaries to `~/.local/bin`, which is persistent in a mounted drive. This means subsequent docker instances can directly use this install.

## References:

- How to setup CVMFS:
  <https://wiki.dunescience.org/wiki/Setting_up_your_own_local_SL7_system>
- Get Kerberos keytab: <https://stackoverflow.com/a/55826172>

## Note

- It is technically possible fo run ups setup [using bundles provded by SciSoft](https://wiki.dunescience.org/wiki/DUNE_LAr_Software_Releases). To try making this compatible with scisoft, `kx509` is copied over from `cvmfs` instead of setup the usual way. However, some of the provided packages in SciSoft appears to be out of date. Your milage may vary.
