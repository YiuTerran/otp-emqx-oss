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
