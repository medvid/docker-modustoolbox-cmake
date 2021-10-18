# Use https://github.com/medvid/docker-modustoolbox as a base image
ARG MTB_TAG=latest
FROM vmmedvid/modustoolbox:${MTB_TAG}

# Install CMake, Ninja and LLVM/Clang
RUN apt update -y \
 && apt install -y apt-transport-https ca-certificates curl gnupg software-properties-common --no-install-recommends \
 && curl -fsSL https://apt.kitware.com/keys/kitware-archive-latest.asc | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null \
 && curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
 && apt-add-repository -y 'deb https://apt.kitware.com/ubuntu/ focal main' \
 && apt-add-repository -y 'deb http://apt.llvm.org/focal/ llvm-toolchain-focal-13 main' \
 && apt update -y \
 && apt install -y cmake ninja-build clang-13 lld-13 --no-install-recommends \
 && apt autoremove -y --purge gnupg \
 && apt clean

# Install GCC 10.3.1
#RUN curl -fsSL https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.07/gcc-arm-none-eabi-10.3-2021.07-x86_64-linux.tar.bz2 -o /tmp/gcc-arm-none-eabi-10.3-2021.07-x86_64-linux.tar.bz2 \
# && tar -C /opt -xjf /tmp/gcc-arm-none-eabi-10.3-2021.07-x86_64-linux.tar.bz2 \
# && rm /tmp/gcc-arm-none-eabi-10.3-2021.07-x86_64-linux.tar.bz2
#ENV GCC_TOOLCHAIN_PATH="/opt/gcc-arm-none-eabi-10.3-2021.07"

# Use GCC 10.3.1 provided with ModusToolbox 2.4
ENV GCC_TOOLCHAIN_PATH="$CY_TOOLS_PATHS/gcc"
