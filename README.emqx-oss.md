# EMQX OSS runtime security branch

This branch starts at EMQX's `OTP-27.3.4.2-9` (619cebe774) and merges the
official Erlang/OTP `OTP-27.3.4.19` release. The runtime version is
`27.3.4.19-emqx-oss.1`.

The EMQX Mnesia hooks required by Mria RLOG, MQTT packet mode, OCSP stapling,
and session ticket extensions are retained. Merge resolutions use the current
upstream TLS state and session ticket APIs. Duplicate OCSP request extensions
are rejected consistently with upstream's extension validation.

Upstream security changes include the TLS authentication, certificate-chain,
and four-byte TCP packet length fixes shipped through OTP 27.3.4.19.
Runtime and cluster verification are required before distribution.

This fork retains Erlang/OTP's Apache-2.0 license and upstream copyright and
attribution files. Other bundled components retain their respective licenses.
See `LICENSE.txt`. The project is independently maintained;
upstream names identify provenance and do not imply endorsement.

## Docker build environment

The independently maintained image is published to `tryao/emqx-otp-oss`:

```sh
docker run --rm tryao/emqx-otp-oss:27.3.4.19-emqx-oss.1-1-debian13 check-emqx-otp
```

This is an OTP **development/build image**, not an EMQX broker image. It is
built from Debian 13, with the C/C++ toolchain and NIF build dependencies;
it does not carry an older bootstrap OTP or Elixir. The custom OTP is installed
at `/opt/emqx-otp`, first in PATH. License and modification records are under
`/opt/emqx-otp/share/licenses/erlang`. Debian packages retain their own licenses.
No `latest` tag is moved; consumers should pin the multi-architecture digest.

Push a `docker-<OTP_VERSION>-1-debian13` tag to run
`.github/workflows/release-emqx-otp-docker.yaml`. The workflow also accepts an
existing source tag through manual dispatch. It uses the `docker` GitHub
environment's `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` secrets. amd64 and arm64
build natively; both must pass installed-runtime checks before publication.
The `-1` component is the image packaging revision, separate from OTP_VERSION.
