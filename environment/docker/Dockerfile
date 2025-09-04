FROM debian:latest

ARG ENV_PATH=/tmp/environment
RUN mkdir -p ${ENV_PATH}
COPY . ${ENV_PATH}/

### Dependencies

# Install default tools and dependencies
RUN apt-get update && \
	apt-get install -y \
	lsb-release \
	gnupg \
	curl \
	wget \
	sudo \
	python3 \
	python3-venv \
	python3-pip \
	pipx 

# Install other useful apt tool from packages.txt
RUN if [ -s ${ENV_PATH}/packages.txt ]; then \
		xargs -r -a ${ENV_PATH}/packages.txt apt-get install -y --no-install-recommends && \
		rm -rf /var/lib/apt/lists/* ; \
	fi

# Add /sbin to path for some commands
ENV PATH="/sbin:/usr/sbin:${PATH}"

### Python

# Create a virtualenv
RUN python3 -m venv /venv \
	&& /venv/bin/pip install --upgrade pip

# Install python libs into the venv from requirement.txt
RUN if [ -s ${ENV_PATH}/requirements.txt ]; then \
		/venv/bin/pip install -r ${ENV_PATH}/requirements.txt ; \
	fi

# Add venv to path by default
ENV PATH="/venv/bin:$PATH"

### Ansible

# Install Ansible
RUN pipx install --include-deps ansible 
RUN pipx ensurepath
# Make pipx-installed apps available
ENV PATH="/root/.local/bin:$PATH"

# Ansible-galaxy
RUN if [ -s ${ENV_PATH}/ansible-galaxy.yml ]; then \
		ansible-galaxy install -r ${ENV_PATH}/ansible-galaxy.yml ; \
	fi

### Hashicorp

# Setup Hashicorp keys
RUN wget -O - https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list
RUN apt-get update

# Install Packer
RUN apt-get install -y packer

# Install Terraform
RUN apt-get install -y terraform

# Set default shell
CMD [ "/bin/bash" ]
