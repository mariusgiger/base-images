# AUTOGENERATED FILE
FROM balenalib/up-board-alpine:3.5-run

# remove several traces of python
RUN apk del python*

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# install python dependencies
RUN apk add --no-cache ca-certificates libffi \
	&& apk add --no-cache libssl1.0 || apk add --no-cache libssl1.1

# key 63C7CC90: public key "Simon McVittie <smcv@pseudorandom.co.uk>" imported
# key 3372DCFA: public key "Donald Stufft (dstufft) <donald@stufft.io>" imported
RUN gpg --keyserver keyring.debian.org --recv-keys 4DE8FF2A63C7CC90 \
	&& gpg --keyserver keyserver.ubuntu.com --recv-key 6E3CBCE93372DCFA \
	&& gpg --keyserver keyserver.ubuntu.com --recv-keys 0x52a43a1e4b77b059

# point Python at a system-provided certificate database. Otherwise, we might hit CERTIFICATE_VERIFY_FAILED.
# https://www.python.org/dev/peps/pep-0476/#trust-database
ENV SSL_CERT_FILE /etc/ssl/certs/ca-certificates.crt

ENV PYTHON_VERSION 2.7.15

# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"
ENV PYTHON_PIP_VERSION 19.0.1

ENV SETUPTOOLS_VERSION 40.6.3

RUN set -x \
	&& buildDeps=' \
		curl \
		gnupg \
	' \
	&& apk add --no-cache --virtual .build-deps $buildDeps \
	&& curl -SLO "http://resin-packages.s3.amazonaws.com/python/v$PYTHON_VERSION/Python-$PYTHON_VERSION.linux-alpine-amd64.tar.gz" \
	&& echo "780a65ad6b4f510856394610425cef309ce6a82090ce15318b6400590f81156b  Python-$PYTHON_VERSION.linux-alpine-amd64.tar.gz" | sha256sum -c - \
	&& tar -xzf "Python-$PYTHON_VERSION.linux-alpine-amd64.tar.gz" --strip-components=1 \
	&& rm -rf "Python-$PYTHON_VERSION.linux-alpine-amd64.tar.gz" \
	&& if [ ! -e /usr/local/bin/pip ]; then : \
		&& curl -SLO "https://raw.githubusercontent.com/pypa/get-pip/430ba37776ae2ad89f794c7a43b90dc23bac334c/get-pip.py" \
		&& echo "19dae841a150c86e2a09d475b5eb0602861f2a5b7761ec268049a662dbd2bd0c  get-pip.py" | sha256sum -c - \
		&& python get-pip.py \
		&& rm get-pip.py \
	; fi \
	&& pip install --no-cache-dir --upgrade --force-reinstall pip=="$PYTHON_PIP_VERSION" setuptools=="$SETUPTOOLS_VERSION" \
	&& find /usr/local \
		\( -type d -a -name test -o -name tests \) \
		-o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
		-exec rm -rf '{}' + \
	&& cd / \
	&& apk del .build-deps \
	&& rm -rf /usr/src/python ~/.cache

# https://github.com/docker-library/python/issues/147
ENV PYTHONIOENCODING UTF-8

# set PYTHONPATH to point to dist-packages
ENV PYTHONPATH /usr/lib/python2.7/site-packages:$PYTHONPATH

CMD ["echo","'No CMD command was set in Dockerfile! Details about CMD command could be found in Dockerfile Guide section in our Docs. Here's the link: https://balena.io/docs"]