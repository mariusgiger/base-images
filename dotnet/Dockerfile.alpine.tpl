# AUTOGENERATED FILE
FROM #{FROM}

#{ARCH=ARM} RUN [ "cross-build-start" ]

RUN apk add --update --no-cache \
      curl \
      coreutils \
      gettext \
      icu-libs \
      ca-certificates \
      # .NET Core dependencies
      krb5-libs \
      libgcc \
      libintl \
      libssl1.0 \
      libstdc++ \
      tzdata \
      userspace-rcu \
      zlib \
    && apk -X https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache \
        lttng-ust \
	  && rm -rf /var/cache/apk/*

WORKDIR /tmp

RUN curl -sSL -o #{DOTNET_BUNDLE_BASENAME} #{DOTNET_BUNDLE} && \
    echo "#{DOTNET_BUNDLE_SHA256SUM}" | sha256sum -c - || true && \
    mkdir -p /opt/dotnet && \
    tar zxf #{DOTNET_BUNDLE_BASENAME} -C /opt/dotnet && \
    ln -s /opt/dotnet/dotnet /usr/local/bin && \
    rm -rf /tmp/*

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8

# Enable correct mode for dotnet watch (only mode supported in a container)
ENV DOTNET_USE_POLLING_FILE_WATCHER=true \
    # Skip extraction of XML docs - generally not useful within an image/container - helps perfomance
    NUGET_XMLDOC_MODE=skip

#{ARCH=ARM} RUN [ "cross-build-end" ]

WORKDIR /app

CMD [ "dotnet", "--help" ]
