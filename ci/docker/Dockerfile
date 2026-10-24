FROM debian:13-slim AS toolchain

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
RUN apt-get update && apt-get install -y --no-install-recommends \
    autoconf automake bison build-essential ca-certificates cmake curl \
    debhelper flex git jq libffi-dev libkrb5-dev libncurses-dev \
    libsasl2-dev libsasl2-modules-gssapi-mit libssl-dev libtool m4 \
    openssl pkg-config procps python3 unixodbc-dev unzip wget zip zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

FROM toolchain AS build
ARG OTP_BUILD_JOBS=4
ARG OTP_VERSION=27.3.4.19-emqx-oss.1
WORKDIR /usr/src/otp
COPY . .
RUN test "$(cat OTP_VERSION)" = "$OTP_VERSION" && \
    ./otp_build autoconf && \
    ./configure --prefix=/opt/emqx-otp --without-javac --without-wx \
      --without-debugger --without-observer --without-et && \
    make -j"$OTP_BUILD_JOBS" && make install && \
    install -d /opt/emqx-otp/share/licenses/erlang && \
    cp LICENSE.txt system/COPYRIGHT README.emqx-oss.md \
      /opt/emqx-otp/share/licenses/erlang/

FROM toolchain
ARG OTP_VERSION=27.3.4.19-emqx-oss.1
LABEL org.opencontainers.image.title="EMQX OSS custom OTP build environment" \
      org.opencontainers.image.source="https://github.com/YiuTerran/otp-emqx-oss" \
      org.opencontainers.image.licenses="Apache-2.0" \
      org.opencontainers.image.otp.version="$OTP_VERSION"
ENV PATH="/opt/emqx-otp/bin:${PATH}"
COPY --from=build /opt/emqx-otp /opt/emqx-otp
COPY ci/docker/check-runtime.sh /usr/local/bin/check-emqx-otp
RUN chmod 755 /usr/local/bin/check-emqx-otp && check-emqx-otp
WORKDIR /work
CMD ["erl"]
