FROM python:3-slim-buster

# Configuration
ARG USD_RELEASE="21.11"
ARG USD_INSTALL="/usr/local/usd"
ENV PYTHONPATH="${PYTHONPATH}:${USD_INSTALL}/lib/python"
ENV PATH="${PATH}:${USD_INSTALL}/bin"

# Dependencies
RUN apt-get -y update && apt-get -y autoremove && apt-get clean \
    && apt-get install -y --no-install-recommends \
    git build-essential cmake nasm curl zip unzip tar pkg-config \
    libxrandr-dev libxcursor-dev libxinerama-dev libxi-dev libxt-dev libglew-dev  && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip install cmake --upgrade

RUN git clone https://github.com/Microsoft/vcpkg.git  ./vcpkg
RUN ./vcpkg/bootstrap-vcpkg.sh
RUN ./vcpkg/vcpkg install openimageio


WORKDIR /usr/src/usd

# Build + install USD
RUN git clone --branch "v${USD_RELEASE}" --depth 1 https://github.com/PixarAnimationStudios/USD.git /usr/src/usd
RUN curl -L https://raw.githubusercontent.com/AKarpetc/OpenUSD/release/build_scripts/build_usd.py --output  build_usd.py
RUN cp  -f build_usd.py  build_scripts/build_usd.py

RUN python ./build_scripts/build_usd.py --verbose --prefer-safety-over-speed --no-examples --no-tutorials --no-python --no-imaging --no-usdview --draco "${USD_INSTALL}" && \
  rm -rf "${USD_REPO}" "${USD_INSTALL}/build" "${USD_INSTALL}/src"


# Share the volume that we have built to
VOLUME ["/usr/local/usd"]